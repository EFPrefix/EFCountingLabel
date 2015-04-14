//
//  ViewController.swift
//  UICountingLabel
//
//  Created by EyreFree on 15/4/14.
//  Copyright (c) 2015 EyreFree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var testLabel: UICountingLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testAction(sender: AnyObject) {
        testLabel.countFrom(testLabel.currentValue(), endValue: 0, duration: 1)
    }
    @IBAction func testAction_2(sender: AnyObject) {
        testLabel.countFrom(testLabel.currentValue(), endValue: 60, duration: 1)
    }
    @IBAction func testAction_3(sender: AnyObject) {
        testLabel.countFrom(testLabel.currentValue(), endValue: 100, duration: 1)
    }

}

