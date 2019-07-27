//
//  ListTableViewController.swift
//  EFCountingLabel
//
//  Created by Kirow on 2019-05-26.
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
import EFCountingLabel

class ListTableViewController: UITableViewController {
    
    @IBOutlet weak var createButtonCell: UITableViewCell!
    @IBOutlet weak var createLabelCell: UITableViewCell!
    
    var refreshLabelBlock: (() -> Void)?
    
    private func present<T: EFCountAdapter>(countingView: T) -> UIViewController where T: UIView {
        countingView.translatesAutoresizingMaskIntoConstraints = false
        
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        
        controller.view.addSubview(countingView)
        countingView.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        countingView.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor).isActive = true
        
        navigationController?.pushViewController(controller, animated: true)
        
        return controller
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        switch cell {
        case createButtonCell: showControllerWithButton()
        case createLabelCell: showControllerWithLabel()
        default: return
        }
    }
    
    func showControllerWithLabel() {
        let label = EFCountingLabel()
        label.counter.timingFunction = EFTimingFunction.easeOut(easingRate: 4)
        label.setUpdateBlock { value, label in
            label.text = String(format: "%.2f%%", value)
        }
        
        //do not retain to release label immediately after pop viewController
        refreshLabelBlock = { [unowned label] in
            label.countFromZeroTo(100, withDuration: 10)
        }
        
        let controller = present(countingView: label)
        
        refreshLabelBlock?()
        
        controller.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(didClickRefreshLabel(_:))
        )
    }
    
    @objc func didClickRefreshLabel(_ sender: UIBarButtonItem) {
        refreshLabelBlock?()
    }
    
    func showControllerWithButton() {
        let button = EFCountingButton(type: .custom)
        button.counter.timingFunction = EFTimingFunction.easeInOut(easingRate: 2)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        button.setTitle("Start Counter", for: .normal)
        button.setUpdateBlock { value, button in
            button.setTitle(String(format: "%.2f%%", value), for: .normal)
        }
        button.setCompletionBlock { button in
            button.setTitle("Restart Counter", for: .normal)
        }
        
        button.addTarget(self, action: #selector(didClickCountingButton(_:)), for: .touchUpInside)
        
        _ = present(countingView: button)
    }
    
    @objc func didClickCountingButton(_ sender: EFCountingButton) {
        if sender.counter.isCounting {
            sender.stopCountAtCurrentValue()
        } else {
            sender.countFromZeroTo(100, withDuration: 10)
        }
    }
}
