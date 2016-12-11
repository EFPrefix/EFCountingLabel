//
//  ViewController.swift
//  EFCountingLabel
//
//  Created by EyreFree on 16/12/11.
//  Copyright © 2016年 EyreFree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UICountingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // make one that counts up
        let myLabel = UICountingLabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
        myLabel.method = .Linear
        myLabel.format = "%d"
        self.view.addSubview(myLabel)
        myLabel.countFrom(startValue: 1, to: 10, withDuration: 3.0)

        // make one that counts up from 5% to 10%, using ease in out (the default)
        let countPercentageLabel = UICountingLabel(frame: CGRect(x: 10, y: 50, width: 200, height: 40))
        self.view.addSubview(countPercentageLabel)
        countPercentageLabel.format = "%.1f%%"
        countPercentageLabel.countFrom(startValue: 5, to: 10)

        // count up using a string that uses a number formatter
        let scoreLabel = UICountingLabel(frame: CGRect(x: 10, y: 90, width: 200, height: 40))
        self.view.addSubview(scoreLabel)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        scoreLabel.formatBlock = {
            (value) in
            return "Score: " + (formatter.string(from: NSNumber(value: Int(value))) ?? "")
        }
        scoreLabel.method = .EaseOut
        scoreLabel.countFrom(startValue: 0, to: 10000, withDuration: 2.5)

        // count up with attributed string
        let toValue = 100.0
        let attributedLabel = UICountingLabel(frame: CGRect(x: 10, y: 130, width: 200, height: 40))
        self.view.addSubview(attributedLabel)
        attributedLabel.attributedFormatBlock = {
            (value) in
            let highlight = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 20)]
            let normal = [NSFontAttributeName: UIFont(name: "HelveticaNeue-UltraLight", size: 20)]

            let prefix = String(format: "%d", Int(value))
            let postfix = String(format: "/%d", Int(toValue))

            let prefixAttr = NSMutableAttributedString(string: prefix, attributes: highlight)
            let postfixAttr = NSAttributedString(string: postfix, attributes: normal)

            prefixAttr.append(postfixAttr)
            return prefixAttr
        }
        attributedLabel.countFrom(startValue: 0, to: CGFloat(toValue), withDuration: 2.5)

        //storyboard
        self.label.method = .EaseInOut
        self.label.format = "%d%%"
        self.label.completionBlock = {
            [weak self] () in
            self?.label.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
        }
        self.label.countFrom(startValue: 0, to: 100)
    }
}

