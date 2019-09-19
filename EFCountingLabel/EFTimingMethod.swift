//
//  EFTimingMethod.swift
//  EFCountingLabel
//
//  Created by Kirow on 2019/05/14.
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

public enum EFTimingFunction: EFTiming {
    case linear
    case easeIn(easingRate: CGFloat)
    case easeOut(easingRate: CGFloat)
    case easeInOut(easingRate: CGFloat)
    case easeInBounce
    case easeOutBounce
    
    public func update(_ time: CGFloat) -> CGFloat {
        switch self {
        case .linear:
            return time
        case .easeIn(let rate):
            return pow(time, rate)
        case .easeOut(let rate):
            return 1.0 - pow(1.0 - time, rate)
        case .easeInOut(let rate):
            let newt: CGFloat = 2 * time
            if newt < 1 {
                return 0.5 * pow(newt, rate)
            } else {
                return 0.5 * (2.0 - pow(2.0 - newt, rate))
            }
        case .easeInBounce:
            if time < 4.0 / 11.0 {
                return 1.0 - (pow(11.0 / 4.0, 2) * pow(time, 2)) - time
            } else if time < 8.0 / 11.0 {
                return 1.0 - (3.0 / 4.0 + pow(11.0 / 4.0, 2) * pow(time - 6.0 / 11.0, 2)) - time
            } else if time < 10.0 / 11.0 {
                return 1.0 - (15.0 / 16.0 + pow(11.0 / 4.0, 2) * pow(time - 9.0 / 11.0, 2)) - time
            }
            return 1.0 - (63.0 / 64.0 + pow(11.0 / 4.0, 2) * pow(time - 21.0 / 22.0, 2)) - time
        case .easeOutBounce:
            if time < 4.0 / 11.0 {
                return pow(11.0 / 4.0, 2) * pow(time, 2)
            } else if time < 8.0 / 11.0 {
                return 3.0 / 4.0 + pow(11.0 / 4.0, 2) * pow(time - 6.0 / 11.0, 2)
            } else if time < 10.0 / 11.0 {
                return 15.0 / 16.0 + pow(11.0 / 4.0, 2) * pow(time - 9.0 / 11.0, 2)
            }
            return 63.0 / 64.0 + pow(11.0 / 4.0, 2) * pow(time - 21.0 / 22.0, 2)
        }
    }
}
