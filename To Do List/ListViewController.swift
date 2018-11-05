//
//  ListViewController.swift
//  To Do List
//
//  Created by Brisk on 10/22/18.
//  Copyright © 2018 Brisk. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var isRootViewControllr = true
    
    var list: List!
    
    @IBOutlet var tableView: UITableView!
    
    class func getInstance() -> ListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if isRootViewControllr {
            if let list = DataManager.getList() {
                self.list = list
            } else {
                list = List(name: "List")
            }
        }
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = list.name
        DataManager.save(list: list)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        if isRootViewControllr {
            createNewSubList()
        } else {
            askForCreatingOpitons()
        }
        
    }
    
    func askForCreatingOpitons() {
        let alert = UIAlertController(title: "Options", message: nil, preferredStyle: .alert)
        alert.addAction((UIAlertAction(title: "New Task", style: .default) { (action) in
            self.createNewTask()
        }))
        alert.addAction((UIAlertAction(title: "New Sublist", style: .default) { (action) in
            self.createNewSubList()
        }))
        alert.addAction((UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func createNewTask() {
        let controller = TaskViewController.getInstance()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func createNewSubList() {
        let alert = UIAlertController(title: "Add New List", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            let name = alert.textFields![0].text!
            self.list.addNewSubList(name: name)
            self.updateData()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func updateData() {
        let firstViewController = self.navigationController?.viewControllers.first as! ListViewController
        DataManager.save(list: firstViewController.list)
        self.tableView.reloadData()
    }
    
}


extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isRootViewControllr {
            return 1
        } else {
            if list.tasks.count > 0 {
                return 2
            }
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return list.subLists.count
        }
        return list.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell
        if indexPath.section == 0 {
            let subList = list.subLists[indexPath.row]
            cell.label.text = subList.name
        } else {
            let task = list.tasks[indexPath.row]
            cell.label.text = task.name
        }
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = ListViewController.getInstance()
        controller.list = list.subLists[indexPath.row]
        controller.isRootViewControllr = false
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        label.backgroundColor = .gray
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        if section == 0 {
            label.text = "Lists"
        } else {
            label.text = "Tasks"
        }
        return label
    }
}

extension ListViewController: TaskViewControllerProtocol {
    
    func didCreate(_ task: Task) {
        list.tasks.append(task)
        updateData()
    }
}
