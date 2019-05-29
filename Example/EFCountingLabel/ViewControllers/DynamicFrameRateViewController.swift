//
// Created by Kirow Onet on 2019-05-29.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import EFCountingLabel

class DynamicFrameRateViewController: UIViewController {
    @IBOutlet weak var countingLabel: EFCountingLabel!
    @IBOutlet weak var frameIntervalSlider: UISlider!
    @IBOutlet weak var expectedFrameRate: UILabel!
    @IBOutlet weak var actualFrameRate: UILabel!

    var eventCount = 0

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        countingLabel.setUpdateBlock { [unowned self] value, label in
            self.eventCount += 1
            label.text = "\(Int(value.truncatingRemainder(dividingBy: 60)))"
        }
        frameIntervalSlider.value = Float(countingLabel.counter.refreshRateInterval)
        update(interval: countingLabel.counter.refreshRateInterval)
        countingLabel.countFrom(0, to: 3_600_000, withDuration: 3600)
    }

    @IBAction func sliderDidChangeValue(_ sender: UISlider) {
        update(interval: Int(sender.value))

    }

    private func update(interval: Int) {
        eventCount = 0
        countingLabel.counter.refreshRateInterval = interval
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshActualFramerate),
                userInfo: nil, repeats: true)
        expectedFrameRate.text = interval > 0 ? "\(60 / interval)" : "max"
        actualFrameRate.text = "0"
    }

    @objc func refreshActualFramerate() {
        actualFrameRate.text = "\(eventCount)"
        eventCount = 0
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }

}