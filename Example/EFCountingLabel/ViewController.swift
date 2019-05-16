//
//  ViewController.swift
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
import EFCountingLabel

class ViewController: UIViewController {

    @IBOutlet weak var label: EFCountingLabel!

    var myLabel: EFCountingLabel!
    var countPercentageLabel: EFCountingLabel!
    var scoreLabel: EFCountingLabel!
    var attributedLabel: EFCountingLabel!
    var countingButton: EFCountingButton!
    @IBOutlet weak var stopCountButton: EFCountingButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabels()
        setupButton()

        startCount()
    }

    func setupLabels() {
        stopCountButton.updateBlock = { value in
            self.stopCountButton.setTitle("\(value)", for: .normal)
        }
        // make one that counts up
        let myLabel = EFCountingLabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
        myLabel.updateBlock = { value in
            myLabel.text = String(format: "%d", value)
        }
        self.view.addSubview(myLabel)
        self.myLabel = myLabel

        // make one that counts up from 5% to 10%, using ease in out (the default)
        let countPercentageLabel = EFCountingLabel(frame: CGRect(x: 10, y: 50, width: 200, height: 40))
        countPercentageLabel.updateBlock = { value in
            countPercentageLabel.text = String(format: "%.1f%%", value)
        }
        self.view.addSubview(countPercentageLabel)
        self.countPercentageLabel = countPercentageLabel

        // count up using a string that uses a number formatter
        let scoreLabel = EFCountingLabel(frame: CGRect(x: 10, y: 90, width: 200, height: 40))
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        scoreLabel.updateBlock = { value in
            scoreLabel.text = "Score: " + (formatter.string(from: NSNumber(value: Int(value))) ?? "")
        }
        scoreLabel.counter.timingMethod = EFTimingMethod.easeOut(easingRate: 3)

        self.view.addSubview(scoreLabel)
        self.scoreLabel = scoreLabel

        // count up with attributed string
        let attributedLabel = EFCountingLabel(frame: CGRect(x: 10, y: 130, width: 200, height: 40))

        attributedLabel.updateBlock = { value in
            let highlight = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 20) ?? UIFont.systemFont(ofSize: 20)]
            let normal = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-UltraLight", size: 20) ?? UIFont.systemFont(ofSize: 20)]

            let prefix = String(format: "%d", Int(value))
            let postfix = String(format: "/%d", 100)

            let prefixAttr = NSMutableAttributedString(string: prefix, attributes: highlight)
            let postfixAttr = NSAttributedString(string: postfix, attributes: normal)

            prefixAttr.append(postfixAttr)

            attributedLabel.attributedText = prefixAttr
        }

        self.view.addSubview(attributedLabel)
        self.attributedLabel = attributedLabel

        // storyboard
        self.label.counter.timingMethod = EFTimingMethod.easeInOut(easingRate: 3)
        self.label.updateBlock = { [weak self] value in
            self?.label.text = String(format: "%d%%", value)
        }

        self.label.completionBlock = { [weak self] in
            self?.label.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
        }

        // button: a simple countdown button
        self.countingButton = EFCountingButton(frame: CGRect(x: 10, y: 170, width: 200, height: 40))
        self.countingButton.setTitle("CountDown", for: .normal)
        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.blue]
        let attributedString = NSAttributedString(string: countingButton.title(for: UIControl.State.normal) ?? "", attributes: attrs)
        self.countingButton.setAttributedTitle(attributedString, for: UIControl.State.normal)
        self.countingButton.contentHorizontalAlignment = .left
        self.countingButton.updateBlock = { [weak self] value in
            self?.countingButton.setAttributedTitle(NSAttributedString(string: String(format: "%.0lf", value), attributes: attrs), for: .normal)
        }

        self.countingButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        self.countingButton.addTarget(self, action: #selector(buttonClicked), for: UIControl.Event.touchUpInside)
        self.countingButton.counter.timingMethod = EFTimingMethod.linear
        self.view.addSubview(countingButton)
    }

    func setupButton() {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        let button = UIButton(
                frame: CGRect(x: (screenWidth - 72) / 2, y: (screenHeight - 24 - 100), width: 72, height: 24)
        )
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 0, green: 122.0 / 255.0, blue: 1, alpha: 1).cgColor
        button.layer.cornerRadius = 4.0
        button.setTitleColor(UIColor(red: 0, green: 122.0 / 255.0, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Repeat", for: .normal)
        button.addTarget(self, action: #selector(ViewController.startCount), for: .touchUpInside)
        self.view.addSubview(button)
    }

    @objc func startCount() {
        myLabel.countFrom(1, to: 10, withDuration: 3.0)
        countPercentageLabel.countFrom(5, to: 10)
        scoreLabel.countFrom(0, to: 10000, withDuration: 2.5)
        attributedLabel.countFrom(0, to: 100, withDuration: 2.5)
        self.label.countFrom(0, to: 100)
    }

    @objc func buttonClicked(button: EFCountingButton) {
        let titleBackup: NSAttributedString? = button.attributedTitle(for: UIControl.State.normal)
        self.countingButton.completionBlock = { [weak self] in
            guard let _ = self else { return }
            button.setAttributedTitle(titleBackup, for: UIControl.State.normal)
        }
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.countingButton.countFrom(10, to: 0, withDuration: 10)
        }
    }

    @IBAction func stopButtonClicked(_ sender: EFCountingButton) {
        if sender.counter.isCounting {
            sender.stopAtCurrentValue()
        } else {
            sender.countFromCurrentValueTo(1000000, withDuration: 20)
        }

    }
}
