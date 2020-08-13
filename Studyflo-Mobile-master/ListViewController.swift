//
//  ListViewController.swift
//  Project1
//
//  Created by Arianna O'Neil on 4/19/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

/*
Authors: Arianna O'Neil, Samantha Silvia, Logan Teceno & Joshua Keif
*/

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, ChangeButton {

    var todoUserName: String = ""
    
    var tasks: [Task] = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        todoUserName = (presentingViewController as! ViewController).userName
        if todoUserName == "" {
            headerLabel.text = "Whats on the agenda?"
        }
        else {
            headerLabel.text = "Whats on the agenda, \(todoUserName)?"
        }
    }
    
    override func viewDidLoad() {
        assignbackground()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.taskNameLabel.text = tasks[indexPath.row].name
        
        if tasks[indexPath.row].checked {
            cell.checkBoxOutlet.setBackgroundImage(UIImage(named: "checkBoxFILLED"), for: UIControl.State.normal)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(UIImage(named: "checkBoxOUTLINE"), for: UIControl.State.normal)
        }
        
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.tasks = tasks
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            self.tasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddTaskController
        vc.delegate = self
    }
    
    func addTask(name: String) {
        tasks.append(Task(name: name))
        tableView.reloadData()
    }
    
    func changeButton(checked: Bool, index: Int?) {
        tasks[index!].checked = checked
        tableView.reloadData()
    }
    
    //about button
    @IBAction func aboutButton(_ sender: Any) {
        let alertController = UIAlertController(title: "To-Do List", message: "Keeping a to-do list helps you to not only keep your tasks organized, but it also helps you to stay productive.", preferredStyle: UIAlertController.Style.alert)
                let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }

    //help button
    @IBAction func helpButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Help", message: "Tap '+' add a new task. Swipe left on the task to delete it. Tap on the checkbox when you have completed a task.", preferredStyle: UIAlertController.Style.alert)
                         let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                         alertController.addAction(defaultAction)
                         present(alertController, animated: true, completion: nil)
    }
    
    //wallpaper
    func assignbackground(){
        let background = UIImage(named: "beach2.jpg")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
    }
    
}

class Task {
    var name = ""
    var checked = false
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

