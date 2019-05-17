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

import Foundation

public protocol EFTiming {
    func update(_ time: CGFloat) -> CGFloat
}

public protocol EFCount {
    func countFrom(_ startValue: CGFloat, to endValue: CGFloat, withDuration duration: TimeInterval)
    func countFromCurrentValueTo(_ endValue: CGFloat, withDuration duration: TimeInterval)
    func stopCountAtCurrentValue()
}

extension EFCount {
    public func countFromZeroTo(_ endValue: CGFloat, withDuration duration: TimeInterval) {
        countFrom(0, to: endValue, withDuration: duration)
    }

    public func countFrom(_ startValue: CGFloat, to endValue: CGFloat) {
        countFrom(startValue, to: endValue, withDuration: 0)
    }

    public func countFromCurrentValueTo(_ endValue: CGFloat) {
        countFromCurrentValueTo(endValue, withDuration: 0)
    }

    public func countFromZeroTo(_ endValue: CGFloat) {
        countFromZeroTo(endValue, withDuration: 0)
    }
}

public class EFCounter {
    public var timingMethod: EFTiming = EFTimingMethod.linear

    public var updateBlock: ((CGFloat) -> Void)?
    public var completionBlock: (() -> Void)?

    private var startingValue: CGFloat = 0
    private var destinationValue: CGFloat = 1
    private var progress: TimeInterval = 0
    private var lastUpdate: TimeInterval = 0
    private var totalTime: TimeInterval = 1

    private var timer: CADisplayLink?

    public var isCounting: Bool {
        return timer != nil
    }

    public var currentValue: CGFloat {
        if progress == 0 {
            return 0
        } else if progress >= totalTime {
            return destinationValue
        }

        let percent = progress / totalTime
        let updateVal = timingMethod.update(CGFloat(percent))

        return startingValue + updateVal * (destinationValue - startingValue)
    }

    @objc public func updateValue(_ timer: Timer) {
        // update progress
        let now = CACurrentMediaTime()
        progress += now - lastUpdate
        lastUpdate = now

        if progress >= totalTime {
            self.timer?.invalidate()
            self.timer = nil
            progress = totalTime
        }

        updateBlock?(currentValue)

        if progress == totalTime {
            runCompletionBlock()
        }
    }

    private func runCompletionBlock() {
        if let tryCompletionBlock = completionBlock {
            completionBlock = nil
            tryCompletionBlock()
        }
    }

    public func reset() {
        //set init values
        timer?.invalidate()
        timer = nil
        startingValue = 0
        destinationValue = 1
        progress = 0
        lastUpdate = 0
        totalTime = 1
    }
}

extension EFCounter: EFCount {
    public func countFromCurrentValueTo(_ endValue: CGFloat, withDuration duration: TimeInterval) {
        countFrom(currentValue, to: endValue, withDuration: duration)
    }

    public func countFrom(_ startValue: CGFloat, to endValue: CGFloat, withDuration duration: TimeInterval) {
        startingValue = startValue
        destinationValue = endValue

        // remove any (possible) old timers
        self.timer?.invalidate()
        self.timer = nil

        if duration == 0.0 {
            // No animation
            updateBlock?(endValue)
            runCompletionBlock()
            return
        }

        progress = 0
        totalTime = duration
        lastUpdate = CACurrentMediaTime()

        let timer = CADisplayLink(target: self, selector: #selector(updateValue(_:)))
        if #available(iOS 10.0, *) {
            timer.preferredFramesPerSecond = 30
        } else {
            timer.frameInterval = 2
        }
        timer.add(to: .main, forMode: .default)
        timer.add(to: .main, forMode: .tracking)
        self.timer = timer
    }

    public func stopCountAtCurrentValue() {
        timer?.invalidate()
        timer = nil

        updateBlock?(currentValue)
    }
}