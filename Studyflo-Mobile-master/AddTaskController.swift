//
//  AddTaskController.swift
//  Project1
//
//  Created by Teceno, Logan on 4/28/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

/*
Authors: Arianna O'Neil, Samantha Silvia, Logan Teceno & Joshua Keif
*/

import UIKit

protocol AddTask {
    func addTask(name: String)
}

class AddTaskController: UIViewController {

    var newTaskUserName: String = ""
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        newTaskUserName = (presentingViewController as! ListViewController).todoUserName
        if newTaskUserName == "" {
            headerLabel.text = "What would you like to accomplish today?"
        }
        else {
            headerLabel.text = "What would you like to accomplish today, \(newTaskUserName)?"
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        if taskNameOutlet.text != "" {
            delegate?.addTask(name: taskNameOutlet.text!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func textboxGoAway(_ sender: Any) {
        taskNameOutlet.resignFirstResponder()
    }
    
    @IBOutlet weak var taskNameOutlet: UITextField!
    
    var delegate: AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        
        taskNameOutlet.becomeFirstResponder()
    }
    
    func assignbackground(){
        let background = UIImage(named: "beach.jpg")

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
