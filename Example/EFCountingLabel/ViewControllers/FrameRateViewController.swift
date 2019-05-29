//
//  FrameRateViewController.swift
//  EFCountingLabel_Example
//
//  Created by Kirow Onet on 5/29/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import EFCountingLabel

class FrameRateViewController: UIViewController {

    @IBOutlet weak var rate5: EFCountingLabel!      //5fps
    @IBOutlet weak var rate6: EFCountingLabel!      //6fps
    @IBOutlet weak var rate8: EFCountingLabel!      //7.5fps -> 8fps
    @IBOutlet weak var rate10: EFCountingLabel!     //10fps
    @IBOutlet weak var rate12: EFCountingLabel!     //12fps
    @IBOutlet weak var rate15: EFCountingLabel!     //15fps
    @IBOutlet weak var rate30: EFCountingLabel!     //30fps
    @IBOutlet weak var rate60: EFCountingLabel!     //60fps

    var rate5Count = 0
    var rate6Count = 0
    var rate8Count = 0
    var rate10Count = 0
    var rate12Count = 0
    var rate15Count = 0
    var rate30Count = 0
    var rate60Count = 0

    var cycle = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        rate5.counter.refreshRateInterval = Int(60.0 / 5.0)
        rate6.counter.refreshRateInterval = Int(60.0 / 6.0)
        rate8.counter.refreshRateInterval = Int(60.0 / 7.5) //this one works unexpected
        rate10.counter.refreshRateInterval = Int(60.0 / 10.0)
        rate12.counter.refreshRateInterval = Int(60.0 / 12.0)
        rate15.counter.refreshRateInterval = Int(60.0 / 15.0)
        rate30.counter.refreshRateInterval = Int(60.0 / 30.0)
        rate60.counter.refreshRateInterval = Int(60.0 / 60.0)

        rate5.setUpdateBlock({ [weak self] value, label in
            label.text = "\(Int(value))"
            self?.rate5Count += 1
        })
        rate6.setUpdateBlock({ [weak self] value, label in
            label.text = "\(Int(value))"
            self?.rate6Count += 1
        })
        rate8.setUpdateBlock({ [weak self] value, label in
            label.text = "\(Int(value))"
            self?.rate8Count += 1
        })
        rate10.setUpdateBlock({ [weak self] value, label in
            label.text = "\(Int(value))"
            self?.rate10Count += 1
        })
        rate12.setUpdateBlock({ [weak self] value, label in
            label.text = "\(Int(value))"
            self?.rate12Count += 1
        })
        rate15.setUpdateBlock({ [weak self] value, label in
            label.text = "\(Int(value))"
            self?.rate15Count += 1
        })
        rate30.setUpdateBlock({ [weak self] value, label in
            label.text = "\(Int(value))"
            self?.rate30Count += 1
        })
        rate60.setUpdateBlock({ [weak self] value, label in
            label.text = "\(Int(value))"
            self?.rate60Count += 1
        })

        refresh()
    }

    @IBAction func refresh() {
        rate5Count = 0
        rate6Count = 0
        rate8Count = 0
        rate10Count = 0
        rate12Count = 0
        rate15Count = 0
        rate30Count = 0
        rate60Count = 0

        cycle += 1

        //expectation for 60fps screen
        rate5.setCompletionBlock({ [unowned self] _ in
            print("rate5 - \(self.rate5Count). (expected \(5 * self.cycle)+1)")
        })
        rate6.setCompletionBlock({ [unowned self] _ in
            print("rate6 - \(self.rate6Count). (expected \(6 * self.cycle)+1)")
        })
        rate8.setCompletionBlock({ [unowned self] _ in
            print("rate8 - \(self.rate8Count). (expected \(Int(7.5) * self.cycle)+1)")
        })
        rate10.setCompletionBlock({ [unowned self] _ in
            print("rate10 - \(self.rate10Count). (expected \(10 * self.cycle)+1)")
        })
        rate12.setCompletionBlock({ [unowned self] _ in
            print("rate12 - \(self.rate12Count). (expected \(12 * self.cycle)+1)")
        })
        rate15.setCompletionBlock({ [unowned self] _ in
            print("rate15 - \(self.rate15Count). (expected \(15 * self.cycle)+1)")
        })
        rate30.setCompletionBlock({ [unowned self] _ in
            print("rate30 - \(self.rate30Count). (expected \(30 * self.cycle)+1)")
        })
        rate60.setCompletionBlock({ [unowned self] _ in
            print("rate60 - \(self.rate60Count). (expected \(60 * self.cycle)+1)")
        })

        let duration = TimeInterval(cycle)

        print("running animation for \(cycle) second\(cycle > 1 ? "s" : "")")

        rate5.countFrom(0, to: 100, withDuration: duration)
        rate6.countFrom(0, to: 100, withDuration: duration)
        rate8.countFrom(0, to: 100, withDuration: duration)
        rate10.countFrom(0, to: 100, withDuration: duration)
        rate12.countFrom(0, to: 100, withDuration: duration)
        rate15.countFrom(0, to: 100, withDuration: duration)
        rate30.countFrom(0, to: 100, withDuration: duration)
        rate60.countFrom(0, to: 100, withDuration: duration)
    }
}
