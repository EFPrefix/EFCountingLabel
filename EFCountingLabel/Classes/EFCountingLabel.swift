//
//  EFCountingLabel.swift
//  EFCountingLabel
//
//  Created by EyreFree on 2016/12/11.
//
//  Copyright (c) 2017 EyreFree <eyrefree@eyrefree.org>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

public enum EFLabelCountingMethod: Int {
    case linear = 0
    case easeIn = 1
    case easeOut = 2
    case easeInOut = 3
    case easeInBounce = 4
    case easeOutBounce = 5
}

//MARK: - UILabelCounter
let kUILabelCounterRate = Float(3.0)

public protocol UILabelCounter {
    func update(_ t: CGFloat) -> CGFloat
}

public class UILabelCounterLinear: UILabelCounter {
    public func update(_ t: CGFloat) -> CGFloat {
        return t
    }
}

public class UILabelCounterEaseIn: UILabelCounter {
    public func update(_ t: CGFloat) -> CGFloat {
        return CGFloat(powf(Float(t), kUILabelCounterRate))
    }
}

public class UILabelCounterEaseOut: UILabelCounter {
    public func update(_ t: CGFloat) -> CGFloat {
        return CGFloat(1.0 - powf(Float(1.0 - t), kUILabelCounterRate))
    }
}

public class UILabelCounterEaseInOut: UILabelCounter {
    public func update(_ t: CGFloat) -> CGFloat {
        let newt: CGFloat = 2 * t
        if newt < 1 {
            return CGFloat(0.5 * powf (Float(newt), kUILabelCounterRate))
        } else {
            return CGFloat(0.5 * (2.0 - powf(Float(2.0 - newt), kUILabelCounterRate)))
        }
    }
}

public class UILabelCounterEaseInBounce: UILabelCounter {
    public func update(_ t: CGFloat) -> CGFloat {
        if t < 4.0 / 11.0 {
            return CGFloat(1.0 - (powf(11.0 / 4.0, 2) * powf(Float(t), 2))) - t
        } else if t < 8.0 / 11.0 {
            return CGFloat(1.0 - (3.0 / 4.0 + powf(11.0 / 4.0, 2) * powf(Float(t - 6.0 / 11.0), 2))) - t
        } else if t < 10.0 / 11.0 {
            return CGFloat(1.0 - (15.0 / 16.0 + powf(11.0 / 4.0, 2) * powf(Float(t - 9.0 / 11.0), 2))) - t
        }
        return CGFloat(1.0 - (63.0 / 64.0 + powf(11.0 / 4.0, 2) * powf(Float(t - 21.0 / 22.0), 2))) - t
    }
}

public class UILabelCounterEaseOutBounce: UILabelCounter {
    public func update(_ t: CGFloat) -> CGFloat {
        if t < 4.0 / 11.0 {
            return CGFloat(powf(11.0 / 4.0, 2) * powf(Float(t), 2))
        } else if t < 8.0 / 11.0 {
            return CGFloat(3.0 / 4.0 + powf(11.0 / 4.0, 2) * powf(Float(t - 6.0 / 11.0), 2))
        } else if t < 10.0 / 11.0 {
            return CGFloat(15.0 / 16.0 + powf(11.0 / 4.0, 2) * powf(Float(t - 9.0 / 11.0), 2))
        }
        return CGFloat(63.0 / 64.0 + powf(11.0 / 4.0, 2) * powf(Float(t - 21.0 / 22.0), 2))
    }
}

//MARK: - EFCountingLabel
open class EFCountingLabel: UILabel {

    public var format = "%f"
    public var method = EFLabelCountingMethod.linear
    public var animationDuration = TimeInterval(2)
    public var formatBlock: ((CGFloat) -> String)?
    public var attributedFormatBlock: ((CGFloat) -> NSAttributedString)?
    public var completionBlock: (() -> Void)?

    private var startingValue: CGFloat!
    private var destinationValue: CGFloat!
    private var progress: TimeInterval = 0
    private var lastUpdate: TimeInterval!
    private var totalTime: TimeInterval!
    private var easingRate: CGFloat!

    private var timer: CADisplayLink?
    private var counter: UILabelCounter = UILabelCounterLinear()

    public func countFrom(_ startValue: CGFloat, to endValue: CGFloat) {
        self.countFrom(startValue, to: endValue, withDuration: self.animationDuration)
    }

    public func countFrom(_ startValue: CGFloat, to endValue: CGFloat, withDuration duration: TimeInterval) {
        self.startingValue = startValue
        self.destinationValue = endValue

        // remove any (possible) old timers
        self.timer?.invalidate()
        self.timer = nil

        if duration == 0.0 {
            // No animation
            self.setTextValue(endValue)
            self.runCompletionBlock()
            return
        }

        self.easingRate = 3.0
        self.progress = 0
        self.totalTime = duration
        self.lastUpdate = CACurrentMediaTime()

        switch self.method {
        case .linear:
            self.counter = UILabelCounterLinear()
        case .easeIn:
            self.counter = UILabelCounterEaseIn()
        case .easeOut:
            self.counter = UILabelCounterEaseOut()
        case .easeInOut:
            self.counter = UILabelCounterEaseInOut()
        case .easeOutBounce:
            self.counter = UILabelCounterEaseOutBounce()
        case .easeInBounce:
            self.counter = UILabelCounterEaseInBounce()
        }

        let timer = CADisplayLink(target: self, selector: #selector(EFCountingLabel.updateValue(_:)))
        if #available(iOS 10.0, *) {
            timer.preferredFramesPerSecond = 30
        } else {
            timer.frameInterval = 2
        }
        timer.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
        timer.add(to: RunLoop.main, forMode: RunLoop.Mode.tracking)
        self.timer = timer
    }

    public func countFromCurrentValueTo(_ endValue: CGFloat) {
        self.countFrom(self.currentValue(), to: endValue)
    }

    public func countFromCurrentValueTo(_ endValue: CGFloat, withDuration duration: TimeInterval) {
        self.countFrom(self.currentValue(), to: endValue, withDuration: duration)
    }

    public func countFromZeroTo(_ endValue: CGFloat) {
        self.countFrom(0, to: endValue)
    }

    public func countFromZeroTo(_ endValue: CGFloat, withDuration duration: TimeInterval) {
        self.countFrom(0, to: endValue, withDuration: duration)
    }

    public func currentValue() -> CGFloat {
        if self.progress == 0 {
            return 0
        } else if self.progress >= self.totalTime {
            return self.destinationValue
        }

        let percent = self.progress / self.totalTime
        let updateVal = self.counter.update(CGFloat(percent))

        return self.startingValue + updateVal * (self.destinationValue - self.startingValue)
    }

    @objc public func updateValue(_ timer: Timer) {
        // update progress
        let now = CACurrentMediaTime()
        self.progress = self.progress + now - self.lastUpdate
        self.lastUpdate = now

        if self.progress >= self.totalTime {
            self.timer?.invalidate()
            self.timer = nil
            self.progress = self.totalTime
        }

        self.setTextValue(self.currentValue())

        if self.progress == self.totalTime {
            self.runCompletionBlock()
        }
    }

    public func setTextValue(_ value: CGFloat) {
        if let tryAttributedFormatBlock = self.attributedFormatBlock {
            self.attributedText = tryAttributedFormatBlock(value)
        } else if let tryFormatBlock = self.formatBlock {
            self.text = tryFormatBlock(value)
        } else {
            // check if counting with ints - cast to int
            if nil != self.format.range(of: "%(.*)d", options: String.CompareOptions.regularExpression, range: nil)
                || nil != self.format.range(of: "%(.*)i") {
                self.text = String(format: self.format, Int(value))
            } else {
                self.text = String(format: self.format, value)
            }
        }
    }

    private func setFormat(_ format: String) {
        self.format = format
        self.setTextValue(self.currentValue())
    }

    private func runCompletionBlock() {
        if let tryCompletionBlock = self.completionBlock {
            tryCompletionBlock()
            
            self.completionBlock = nil
        }
    }
}
