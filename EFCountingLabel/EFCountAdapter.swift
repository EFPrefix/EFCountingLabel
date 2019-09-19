//
//  EFCountAdapter.swift
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

import Foundation
import UIKit

public protocol EFCountAdapter: class, EFCount {
    var counter: EFCounter { get }
}

extension EFCountAdapter {
    public func setUpdateBlock(_ update: ((_ value: CGFloat, _ sender: Self) -> Void)?) {
        if let update = update {
            counter.updateBlock = { [unowned self] value in
                update(value, self)
            }
        } else {
            counter.updateBlock = nil
        }
    }
    
    public func setCompletionBlock(_ completion: ((_ sender: Self) -> Void)?) {
        if let completion = completion {
            counter.completionBlock = { [unowned self] in
                completion(self)
            }
        } else {
            counter.completionBlock = nil
        }
    }
    
    public func countFrom(_ startValue: CGFloat, to endValue: CGFloat, withDuration duration: TimeInterval) {
        counter.countFrom(startValue, to: endValue, withDuration: duration)
    }
    
    public func countFromCurrentValueTo(_ endValue: CGFloat, withDuration duration: TimeInterval) {
        countFrom(counter.currentValue, to: endValue, withDuration: duration)
    }
    
    public func stopCountAtCurrentValue() {
        counter.stopCountAtCurrentValue()
    }
}

open class EFCountingButton: UIButton, EFCountAdapter {
    public private(set) var counter = EFCounter()
    
    open var formatBlock: ((CGFloat) -> String)? {
        set {
            if let formatBlock = newValue {
                setUpdateBlock { value, button in button.setTitle(formatBlock(value), for: .normal) }
            } else {
                setUpdateBlock(nil)
            }
        }
        @available(*, unavailable)
        get {
            return nil
        }
    }
    open var attributedFormatBlock: ((CGFloat) -> NSAttributedString)? {
        set {
            if let attributedFormatBlock = newValue {
                setUpdateBlock { value, button in button.setAttributedTitle(attributedFormatBlock(value), for: .normal) }
            } else {
                setUpdateBlock(nil)
            }
        }
        @available(*, unavailable)
        get {
            return nil
        }
    }
    open var completionBlock: (() -> Void)? {
        set {
            if let completionBlock = newValue {
                setCompletionBlock { _ in completionBlock() }
            } else {
                setCompletionBlock(nil)
            }
        }
        @available(*, unavailable)
        get {
            return nil
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        customInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        customInit()
    }

    func customInit() {
        setUpdateBlock { [weak self] (value, _) in
            guard let self = self else { return }
            self.setTitle("\(Int(value))", for: UIControl.State.normal)
        }
    }

    deinit {
        counter.invalidate()
    }
}

open class EFCountingLabel: UILabel, EFCountAdapter {
    public private(set) var counter = EFCounter()
    
    open var formatBlock: ((CGFloat) -> String)? {
        set {
            if let formatBlock = newValue {
                setUpdateBlock { value, label in label.text = formatBlock(value) }
            } else {
                setUpdateBlock(nil)
            }
        }
        @available(*, unavailable)
        get {
            return nil
        }
    }
    open var attributedFormatBlock: ((CGFloat) -> NSAttributedString)? {
        set {
            if let attributedFormatBlock = newValue {
                setUpdateBlock { value, label in label.attributedText = attributedFormatBlock(value) }
            } else {
                setUpdateBlock(nil)
            }
        }
        @available(*, unavailable)
        get {
            return nil
        }
    }
    open var completionBlock: (() -> Void)? {
        set {
            if let completionBlock = newValue {
                setCompletionBlock { _ in completionBlock() }
            } else {
                setCompletionBlock(nil)
            }
        }
        @available(*, unavailable)
        get {
            return nil
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        customInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        customInit()
    }

    func customInit() {
        setUpdateBlock { [weak self] (value, _) in
            guard let self = self else { return }
            self.text = "\(Int(value))"
        }
    }
    
    deinit {
        counter.invalidate()
    }
}
