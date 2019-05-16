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


public protocol EFCountAdapter: class {
    var counter: EFCounter { get }
}

extension EFCountAdapter where Self: EFCount {
    public var updateBlock: ((CGFloat) -> Void)? {
        get { return counter.updateBlock }
        set { counter.updateBlock = newValue }
    }

    public var completionBlock: (() -> Void)? {
        get { return counter.completionBlock }
        set { counter.completionBlock = newValue }
    }

    public func countFrom(_ startValue: CGFloat, to endValue: CGFloat, withDuration duration: TimeInterval) {
        counter.countFrom(startValue, to: endValue, withDuration: duration)
    }

    public func countFrom(_ startValue: CGFloat, to endValue: CGFloat) {
        counter.countFrom(startValue, to: endValue)
    }

    public func countFromCurrentValueTo(_ endValue: CGFloat, withDuration duration: TimeInterval) {
        counter.countFromCurrentValueTo(endValue, withDuration: duration)
    }

    public func countFromCurrentValueTo(_ endValue: CGFloat) {
        counter.countFromCurrentValueTo(endValue)
    }

    public func countFromZeroTo(_ endValue: CGFloat, withDuration duration: TimeInterval) {
        counter.countFromZeroTo(endValue, withDuration: duration)
    }

    public func countFromZeroTo(_ endValue: CGFloat) {
        counter.countFromZeroTo(endValue)
    }

    public func stopAtCurrentValue() {
        counter.stopAtCurrentValue()
    }
}

open class EFCountingButton: UIButton, EFCountAdapter, EFCount {
    public private(set) var counter = EFCounter()
}

open class EFCountingLabel: UILabel, EFCountAdapter, EFCount {
    public private(set) var counter = EFCounter()
}
