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

    public var timingFunction: EFTiming = EFTimingFunction.linear
    //works same way as CADisplayLink.frameInterval
    //0 - max frame rate
    public var refreshRateInterval: Int = 2

    public var updateBlock: ((CGFloat) -> Void)?
    public var completionBlock: (() -> Void)?

    public private(set) var fromValue: CGFloat = 0
    public private(set) var toValue: CGFloat = 1
    private var currentDuration: TimeInterval = 0
    public private(set) var totalDuration: TimeInterval = 1
    private var lastUpdate: TimeInterval = 0

    private var timer: CADisplayLink?

    public var isCounting: Bool {
        return timer != nil
    }

    public var progress: CGFloat {
        guard totalDuration != 0 else { return 1 }
        return CGFloat(currentDuration / totalDuration)
    }

    public var currentValue: CGFloat {
        if currentDuration == 0 {
            return 0
        } else if currentDuration >= totalDuration {
            return toValue
        }
        return fromValue + timingFunction.update(progress) * (toValue - fromValue)
    }

    public init() {

    }

    // CADisplayLink callback
    @objc public func updateValue(_ timer: Timer) {
        let now = CACurrentMediaTime()
        currentDuration += now - lastUpdate
        lastUpdate = now

        if currentDuration >= totalDuration {
            invalidate()
            currentDuration = totalDuration
        }

        updateBlock?(currentValue)

        if currentDuration == totalDuration {
            runCompletionBlock()
        }
    }

    private func runCompletionBlock() {
        if let tryCompletionBlock = completionBlock {
            completionBlock = nil
            tryCompletionBlock()
        }
    }

    private func apply(interval: Int, to displayLink: CADisplayLink) {
        if #available(iOS 10.3, *) {
            displayLink.preferredFramesPerSecond = interval > 0 ? max(1, UIScreen.main.maximumFramesPerSecond / interval) : 0
        } else if #available(iOS 10.0, *) {
            displayLink.preferredFramesPerSecond = interval > 0 ? max(1, 60 / interval) : 0
        } else {
            displayLink.frameInterval = interval == 0 ? 1 : interval
        }
    }

    //set init values
    public func reset() {
        invalidate()
        fromValue = 0
        toValue = 1
        currentDuration = 0
        lastUpdate = 0
        totalDuration = 1
    }

    public func invalidate() {
        timer?.invalidate()
        timer = nil
    }
}

extension EFCounter: EFCount {
    public func countFromCurrentValueTo(_ endValue: CGFloat, withDuration duration: TimeInterval) {
        countFrom(currentValue, to: endValue, withDuration: duration)
    }

    public func countFrom(_ startValue: CGFloat, to endValue: CGFloat, withDuration duration: TimeInterval) {
        fromValue = startValue
        toValue = endValue

        // remove any (possible) old timers
        invalidate()

        if duration == 0.0 {
            // No animation
            updateBlock?(endValue)
            runCompletionBlock()
            return
        }

        currentDuration = 0
        totalDuration = duration
        lastUpdate = CACurrentMediaTime()

        let timer = CADisplayLink(target: self, selector: #selector(updateValue(_:)))
        apply(interval: refreshRateInterval, to: timer)
        timer.add(to: .main, forMode: .default)
        timer.add(to: .main, forMode: .tracking)
        self.timer = timer
    }

    public func stopCountAtCurrentValue() {
        invalidate()
        updateBlock?(currentValue)
    }
}