//
//  ViewController.swift
//  EFCountingLabel
//
//  Created by eyrefree on 12/11/2016.
//  Copyright (c) 2016 eyrefree. All rights reserved.
//

import UIKit
import EFCountingLabel

class ViewController: UIViewController {

    @IBOutlet weak var label: EFCountingLabel!

    var myLabel: EFCountingLabel!
    var countPercentageLabel: EFCountingLabel!
    var scoreLabel: EFCountingLabel!
    var attributedLabel: EFCountingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabels()
        setupButton()

        startCount()
    }

    func setupLabels() {
        // make one that counts up
        let myLabel = EFCountingLabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
        myLabel.method = .linear
        myLabel.format = "%d"
        self.view.addSubview(myLabel)
        self.myLabel = myLabel

        // make one that counts up from 5% to 10%, using ease in out (the default)
        let countPercentageLabel = EFCountingLabel(frame: CGRect(x: 10, y: 50, width: 200, height: 40))
        countPercentageLabel.format = "%.1f%%"
        self.view.addSubview(countPercentageLabel)
        self.countPercentageLabel = countPercentageLabel

        // count up using a string that uses a number formatter
        let scoreLabel = EFCountingLabel(frame: CGRect(x: 10, y: 90, width: 200, height: 40))
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        scoreLabel.formatBlock = {
            (value) in
            return "Score: " + (formatter.string(from: NSNumber(value: Int(value))) ?? "")
        }
        scoreLabel.method = .easeOut
        self.view.addSubview(scoreLabel)
        self.scoreLabel = scoreLabel

        // count up with attributed string
        let attributedLabel = EFCountingLabel(frame: CGRect(x: 10, y: 130, width: 200, height: 40))
        attributedLabel.attributedFormatBlock = {
            (value) in
            let highlight = [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 20) ?? UIFont.systemFont(ofSize: 20)]
            let normal = [NSFontAttributeName: UIFont(name: "HelveticaNeue-UltraLight", size: 20) ?? UIFont.systemFont(ofSize: 20)]

            let prefix = String(format: "%d", Int(value))
            let postfix = String(format: "/%d", 100)

            let prefixAttr = NSMutableAttributedString(string: prefix, attributes: highlight)
            let postfixAttr = NSAttributedString(string: postfix, attributes: normal)

            prefixAttr.append(postfixAttr)
            return prefixAttr
        }
        self.view.addSubview(attributedLabel)
        self.attributedLabel = attributedLabel

        //storyboard
        self.label.method = .easeInOut
        self.label.format = "%d%%"
        self.label.completionBlock = {
            [weak self] () in
            self?.label.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
        }
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

    func startCount() {
        myLabel.countFrom(1, to: 10, withDuration: 3.0)
        countPercentageLabel.countFrom(5, to: 10)
        scoreLabel.countFrom(0, to: 10000, withDuration: 2.5)
        attributedLabel.countFrom(0, to: 100, withDuration: 2.5)
        self.label.countFrom(0, to: 100)
    }
}

