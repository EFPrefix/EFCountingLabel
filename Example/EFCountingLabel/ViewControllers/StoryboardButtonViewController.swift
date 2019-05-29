//
// Created by Kirow on 2019-05-26.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import EFCountingLabel


class StoryboardButtonViewController: UIViewController {
    @IBOutlet weak var countDownButton: EFCountingButton!
    @IBOutlet weak var stoppableButton: EFCountingButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor.darkText
        ]

        let valueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .ultraLight),
            .foregroundColor: UIColor.red
        ]

        stoppableButton.setUpdateBlock { value, button in
            button.setTitle("\(value)", for: .normal)
            let attributed = NSMutableAttributedString()
            attributed.append(NSAttributedString(string: "Current Value:\t", attributes: textAttributes))
            attributed.append(NSAttributedString(string: String(format: "%.04f", value), attributes: valueAttributes))
            button.setAttributedTitle(attributed, for: .normal)
        }

        stoppableButton.setCompletionBlock { button in
            button.counter.reset()
            button.setTitle("Press to Start", for: .normal)
        }

        countDownButton.setUpdateBlock { value, button in
            button.setTitle("\(Int(value))", for: .normal)
        }

        countDownButton.setCompletionBlock { button in
            button.setTitle("Count Down", for: .normal)
        }

    }

    @IBAction func didClickCountDownButton(_ sender: EFCountingButton) {
        if !sender.counter.isCounting {
            sender.countFrom(10, to: 0, withDuration: 10)
        }
    }

    @IBAction func didClickStopButton(_ sender: EFCountingButton) {
        if sender.counter.isCounting {
            sender.stopCountAtCurrentValue()
            sender.setAttributedTitle(nil, for: .normal)
            sender.contentHorizontalAlignment = .center
            sender.setTitle("Press to Resume", for: .normal)
        } else {
            sender.contentHorizontalAlignment = .left
            sender.countFromCurrentValueTo(1000000, withDuration: 20)
        }
    }
}
