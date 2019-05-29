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

    public enum RefreshRate: Int {
        case _5fps = 5
        case _6fps = 6
        case _10fps = 10
        case _12fps = 12
        case _15fps = 15
        case _20fps = 20
        case _30fps = 30
        case _60fps = 60
        case max = 0

        private var interval: Int {
            switch self {
            case ._5fps:    return 12
            case ._6fps:    return 10
            case ._10fps:   return 6
            case ._12fps:   return 5
            case ._15fps:   return 4
            case ._20fps:   return 3
            case ._30fps:   return 2
            default:        return 1
            }
        }

        func apply(to displayLink: CADisplayLink) {
            if #available(iOS 10.0, *) {
                displayLink.preferredFramesPerSecond = rawValue
            } else {
                displayLink.frameInterval = interval
            }
        }
    }

    public var timingFunction: EFTiming = EFTimingFunction.linear
    public var refreshRate: RefreshRate = ._30fps

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
        refreshRate.apply(to: timer)
        timer.add(to: .main, forMode: .default)
        timer.add(to: .main, forMode: .tracking)
        self.timer = timer
    }

    public func stopCountAtCurrentValue() {
        invalidate()
        updateBlock?(currentValue)
    }
}