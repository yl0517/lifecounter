//
//  HistoryViewController.swift
//  lifecounter
//
//  Created by Yoobin Lee on 4/23/25.
//

import UIKit

class HistoryViewController: UITableViewController {
    // will be injected before display
    var history: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        cell.textLabel?.text = history[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
