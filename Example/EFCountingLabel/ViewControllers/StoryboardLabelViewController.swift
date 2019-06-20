//
// Created by Kirow on 2019-05-26.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import EFCountingLabel

class StoryboardLabelViewController: UIViewController {

    @IBOutlet weak var simpleCounterLabel: EFCountingLabel!
    @IBOutlet weak var attributedCountLabel: EFCountingLabel!
    @IBOutlet weak var timingCounterLabel: EFCountingLabel!
    @IBOutlet weak var completionCounterLabel: EFCountingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        //simple label setup
        simpleCounterLabel.setUpdateBlock { value, label in
            label.text = String(format: "%d", Int(value))
        }

        //attributed label setup
        let highlightAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "HelveticaNeue", size: 20) ?? UIFont.systemFont(ofSize: 20)
        ]

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "HelveticaNeue-UltraLight", size: 20) ?? UIFont.systemFont(ofSize: 20)
        ]

        attributedCountLabel.setUpdateBlock { value, label in
            let prefix = String(format: "%d", Int(value))
            let postfix = String(format: "/%d", 100)

            let prefixAttr = NSMutableAttributedString(string: prefix, attributes: highlightAttributes)
            let postfixAttr = NSAttributedString(string: postfix, attributes: normalAttributes)
            prefixAttr.append(postfixAttr)

            label.attributedText = prefixAttr
        }

        //timing label setup
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        timingCounterLabel.setUpdateBlock { value, label in
            label.text = "Score: " + (formatter.string(from: NSNumber(value: Int(value))) ?? "")
        }
        timingCounterLabel.counter.timingFunction = EFTimingFunction.easeOut(easingRate: 3)


        //completion label setup
        completionCounterLabel.setUpdateBlock { value, label in
            label.text = String(format: "%i%%", Int(value))
        }

        completionCounterLabel.setCompletionBlock { label in
            label.textColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
        }


        startCount()
    }

    @IBAction func startCount() {
        simpleCounterLabel.countFrom(1, to: 10, withDuration: 3.0)
        timingCounterLabel.countFrom(0, to: 10000, withDuration: 2.5)
        attributedCountLabel.countFrom(0, to: 100, withDuration: 2.5)

        completionCounterLabel.textColor = .darkText
        completionCounterLabel.countFrom(0, to: 100, withDuration: 4)
    }
}