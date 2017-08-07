//
//  ViewController.swift
//  TableViewSwipe
//
//  Created by Steven Smith on 8/2/17.
//  Copyright © 2017 Steven Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data = Email.mockData(numberOfItems: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    func contextualToggleReadAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        var email = data[indexPath.row]
        let title = email.isNew ? "Mark as Read" : "Mark as Unread"
        let action = UIContextualAction(style: .normal, title: title) { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
            if email.toggleReadFlag() {
                self.data[indexPath.row] = email
                self.tableView.reloadRows(at: [indexPath], with: .none)
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
        action.backgroundColor = UIColor.blue
        return action
    }

    func contextualDeleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
            print("Deleting")
            self.data.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .left)
            completionHandler(true)
        }

        return action
    }

    func contextualToggleFlagAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        var email = data[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Flag") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
            if email.toggleFlaggedFlag() {
                self.data[indexPath.row] = email
                self.tableView.reloadRows(at: [indexPath], with: .none)
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
        action.image = UIImage(named: "flag")
        action.backgroundColor = email.isFlagged ? UIColor.gray : UIColor.orange
        return action
    }
}

//MARK: Delegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeConfig = UISwipeActionsConfiguration(actions: [self.contextualToggleReadAction(forRowAtIndexPath: indexPath)])
        return swipeConfig
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
        let flagAction = self.contextualToggleFlagAction(forRowAtIndexPath: indexPath)
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction, flagAction])
        return swipeConfig
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}

//MARK: DataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmailCell") else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: "EmailCell")
        }

        let email = data[indexPath.row]
        cell.textLabel?.text = email.subject
        cell.detailTextLabel?.text = email.body
        if email.isNew {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        } else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17.0)
        }

        if email.isFlagged {
            cell.imageView?.image = UIImage(named: "flag")
        } else {
            cell.imageView?.image = nil
        }
        return cell
    }
}

