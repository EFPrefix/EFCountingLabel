//
// Created by Kirow on 2019-05-26.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import EFCountingLabel

struct CounterCellModel {
    let counter: EFCounter

    init(from: CGFloat, to: CGFloat, duration: TimeInterval, function: EFTiming = EFTimingFunction.linear) {
        self.counter = EFCounter()
        self.counter.timingFunction = function
        self.counter.countFrom(from, to: to, withDuration: duration)
    }
}

class CountingTableViewCell: UITableViewCell {

    weak var counter: EFCounter?

    func setCounter(_ model: CounterCellModel, formatter: NumberFormatter) {
        //unbind counter from cell
        if let current = self.counter {
            current.updateBlock = nil
        }

        if let from = formatter.string(from: NSNumber(value: Int(model.counter.fromValue))),
           let to = formatter.string(from: NSNumber(value: Int(model.counter.toValue))) {
            textLabel?.text = "Count from \(from) to \(to)"
        }

        //bind new counter
        model.counter.updateBlock = { [unowned self] value in
            self.detailTextLabel?.text = formatter.string(from: NSNumber(value: Int(value)))
        }

        counter = model.counter
    }

}

class CustomTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."

        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        return formatter
    }()

    var dataSource: [CounterCellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        remakeDataSource()
        tableView.reloadData()
    }

    @IBAction func didClickRefresh(_ sender: UIBarButtonItem) {
        remakeDataSource()
        tableView.reloadData()
    }

    private func remakeDataSource() {
        dataSource.forEach({ $0.counter.invalidate() })
        dataSource.removeAll()

        var prevValue: CGFloat = 0
        for i in 1...12 {
            let from = prevValue
            let to = pow(10, CGFloat(i))
            let model = CounterCellModel(from: from, to: to, duration: 60)
            dataSource.append(model)
            prevValue = to
        }
    }

    deinit {
        dataSource.forEach({ $0.counter.invalidate() })
    }
}


extension CustomTableViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountingTableViewCell") as? CountingTableViewCell else {
            fatalError()
        }

        let model = dataSource[indexPath.row]
        cell.setCounter(model, formatter: formatter)

        return cell
    }
}
