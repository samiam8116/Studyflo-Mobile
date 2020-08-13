//
//  TaskCell.swift
//  Project1
//
//  Created by Teceno, Logan on 4/28/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

/*
Authors: Arianna O'Neil, Samantha Silvia, Logan Teceno & Joshua Keif
*/

import UIKit

protocol ChangeButton {
    func changeButton(checked: Bool, index: Int?)
}

class TaskCell: UITableViewCell {
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if tasks![indexP!].checked {
            delegate?.changeButton(checked: false, index: indexP!)
        } else {
            delegate?.changeButton(checked: true, index: indexP!)
        }
    }
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    var delegate: ChangeButton?
    var indexP: Int?
    var tasks: [Task]?
}
