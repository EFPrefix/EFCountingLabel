//
//  UICountingLabel.swift
//  EFCountingLabel
//
//  Created by EyreFree on 16/12/11.
//  Copyright © 2016年 EyreFree. All rights reserved.
//

import UIKit

enum UILabelCountingMethod: Int {
    case Linear = 0
    case EaseIn = 1
    case EaseOut = 2
    case EaseInOut = 3
}

//MARK: - UILabelCounter
let kUILabelCounterRate = Float(3.0)

protocol UILabelCounter {
    func update(t: CGFloat) -> CGFloat
}

class UILabelCounterLinear: UILabelCounter {
    internal func update(t: CGFloat) -> CGFloat {
        return t
    }
}

class UILabelCounterEaseIn: UILabelCounter {
    internal func update(t: CGFloat) -> CGFloat {
        return CGFloat(powf(Float(t), kUILabelCounterRate))
    }
}

class UILabelCounterEaseOut: UILabelCounter {
    internal func update(t: CGFloat) -> CGFloat {
        return CGFloat(1.0 - powf(Float(1.0 - t), kUILabelCounterRate))
    }
}

class UILabelCounterEaseInOut: UILabelCounter {
    internal func update(t: CGFloat) -> CGFloat {
        let newt: CGFloat = 2 * t
        if newt < 1 {
            return CGFloat(0.5 * powf (Float(newt), kUILabelCounterRate))
        } else {
            return CGFloat(0.5 * (2.0 - powf(Float(2.0 - newt), kUILabelCounterRate)))
        }
    }
}

//MARK: - UICountingLabel
class UICountingLabel: UILabel {

    var format = "%f"
    var method = UILabelCountingMethod.Linear
    var animationDuration = TimeInterval(2)
    var formatBlock: ((CGFloat) -> String)?
    var attributedFormatBlock: ((CGFloat) -> NSAttributedString)?
    var completionBlock: (() -> Void)?

    private var startingValue: CGFloat!
    private var destinationValue: CGFloat!
    private var progress: TimeInterval!
    private var lastUpdate: TimeInterval!
    private var totalTime: TimeInterval!
    private var easingRate: CGFloat!

    private var timer: CADisplayLink?
    private var counter: UILabelCounter = UILabelCounterLinear()

    func countFrom(startValue: CGFloat, to endValue: CGFloat) {
        self.countFrom(startValue: startValue, to: endValue, withDuration: self.animationDuration)
    }

    func countFrom(startValue: CGFloat, to endValue: CGFloat, withDuration duration: TimeInterval) {
        self.startingValue = startValue
        self.destinationValue = endValue

        // remove any (possible) old timers
        self.timer?.invalidate()
        self.timer = nil

        if duration == 0.0 {
            // No animation
            self.setTextValue(value: endValue)
            self.runCompletionBlock()
            return
        }

        self.easingRate = 3.0
        self.progress = 0
        self.totalTime = duration
        self.lastUpdate = NSDate.timeIntervalSinceReferenceDate

        switch self.method {
        case .Linear:
            self.counter = UILabelCounterLinear()
            break
        case .EaseIn:
            self.counter = UILabelCounterEaseIn()
            break
        case .EaseOut:
            self.counter = UILabelCounterEaseOut()
            break
        case .EaseInOut:
            self.counter = UILabelCounterEaseInOut()
            break
        }

        let timer = CADisplayLink(target: self, selector: #selector(UICountingLabel.updateValue(timer:)))
        timer.frameInterval = 2
        timer.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        timer.add(to: RunLoop.main, forMode: RunLoopMode.UITrackingRunLoopMode)
        self.timer = timer
    }

    func countFromCurrentValueTo(endValue: CGFloat) {
        self.countFrom(startValue: self.currentValue(), to: endValue)
    }

    func countFromCurrentValueTo(endValue: CGFloat, withDuration duration: TimeInterval) {
        self.countFrom(startValue: self.currentValue(), to: endValue, withDuration: duration)
    }

    func countFromZeroTo(endValue: CGFloat) {
        self.countFrom(startValue: 0, to: endValue)
    }

    func countFromZeroTo(endValue: CGFloat, withDuration duration: TimeInterval) {
        self.countFrom(startValue: 0, to: endValue, withDuration: duration)
    }

    func currentValue() -> CGFloat {
        if self.progress >= self.totalTime {
            return self.destinationValue
        }

        let percent = self.progress / self.totalTime
        let updateVal = self.counter.update(t: CGFloat(percent))

        return self.startingValue + updateVal * (self.destinationValue - self.startingValue)
    }

    func updateValue(timer: Timer) {
        // update progress
        let now = NSDate.timeIntervalSinceReferenceDate
        self.progress = self.progress + now - self.lastUpdate
        self.lastUpdate = now

        if self.progress >= self.totalTime {
            self.timer?.invalidate()
            self.timer = nil
            self.progress = self.totalTime
        }

        self.setTextValue(value: self.currentValue())

        if self.progress == self.totalTime {
            self.runCompletionBlock()
        }
    }

    private func setTextValue(value: CGFloat) {
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

    private func setFormat(format: String) {
        self.format = format
        self.setTextValue(value: self.currentValue())
    }

    private func runCompletionBlock() {
        if let tryCompletionBlock = self.completionBlock {
            tryCompletionBlock()
            
            self.completionBlock = nil
        }
    }
}

