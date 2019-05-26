//
// Created by Kirow on 2019-05-26.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

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

        controller.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self,
                action: #selector(didClickRefreshLabel(_:)))
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