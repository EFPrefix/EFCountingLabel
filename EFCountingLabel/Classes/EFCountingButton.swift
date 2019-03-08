//
//  EFCountingButton.swift
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

public class EFCountingButtonLabel: EFCountingLabel {

    fileprivate weak var parentButton: UIButton?

    public override func setTextValue(_ value: CGFloat) {
        if let button = parentButton {
            if let tryAttributedFormatBlock = self.attributedFormatBlock {
                button.setAttributedTitle(tryAttributedFormatBlock(value), for: UIControl.State.normal)
            } else if let tryFormatBlock = self.formatBlock {
                button.setTitle(tryFormatBlock(value), for: UIControl.State.normal)
            } else {
                // check if counting with ints - cast to int
                let format = self.format
                if format.hasIntConversionSpecifier() {
                    button.setTitle(String(format: format, Int(value)), for: UIControl.State.normal)
                } else {
                    button.setTitle(String(format: format, value), for: UIControl.State.normal)
                }
            }
        } else {
            super.setTextValue(value)
        }
    }
}

// EFCountingButton.titleLabel.font = xxx do not work, use NSAttributedString instead as in example project.
open class EFCountingButton: UIButton {

    open lazy var countingLabel: EFCountingButtonLabel = {
        let buttonLabel: EFCountingButtonLabel = EFCountingButtonLabel()
        buttonLabel.parentButton = self
        return buttonLabel
    }()

    override open var titleLabel: UILabel? {
        get {
            return countingLabel
        }
    }
}
