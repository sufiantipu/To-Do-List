//
//  TaskViewController.swift
//  To Do List
//
//  Created by Brisk on 11/5/18.
//  Copyright © 2018 Brisk. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var isCompleteSwitch: UISwitch!
    @IBOutlet var submitButton: UIButton!
    
    var delegate: TaskViewControllerProtocol?
    
    class func getInstance() -> TaskViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isCompleteSwitch.isOn = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonClicked(_ sender: Any?) {
        if let name = nameTextField.text, name != "", let description = descriptionTextField.text {
            let task = Task(name: name, detail: description, date: "", isComplete: isCompleteSwitch.isOn)
            delegate?.didCreate(task)
            self.showAlertWith("Success", message: "New task created", success: true)
        } else {
            showAlertWith("Error!!!", message: "Name field should not be empty", success: false)
        }
        
    }
    
    func showAlertWith(_ title: String, message: String, success: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if success {
                self.navigationController?.popViewController(animated: true)
            }
        }))
        present(alert, animated: true, completion: nil)
    }

}


protocol TaskViewControllerProtocol {
    func didCreate(_ task: Task)
}
