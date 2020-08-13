//
//  QuoteViewController.swift
//  Project1
//
//  Created by Arianna O'Neil on 4/19/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

/*
Authors: Arianna O'Neil, Samantha Silvia, Logan Teceno & Joshua Keif
*/

import UIKit

class QuoteViewController: UIViewController {
    
    var quoteUserName: String = ""
    
    @IBOutlet weak var headerLabel: UILabel!
    
    
    @IBOutlet weak var quoteView: UILabel!
    // displays random quote from array
    @IBAction func randomQuote(_ sender: Any) {
        let quoteArray = ["Slow down, but don't stop.", "Perserverance, not perfection.", "Create, don't compete.", "And still, I rise.", "Catch a wave.", "Commit & succeed.", "The most important thing is to look ahead. The past is your anchor.", "Nothing can dim the light that shines from within.", "You can, you should, and if you're brave enough to start, you will."]
        quoteView.text = quoteArray.randomElement()
    }
    // about this page
    @IBAction func aboutButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Daily mantras", message: "The repetition of a mantra is thought to affirm its meaning to ourselves and change our thought process. It has the potential of cementing a belief into our core being.", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func helpButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Help", message: "Tap the heart to generate a new quote.", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    // updates name
    override func viewWillAppear(_ animated: Bool) {
        quoteUserName = (presentingViewController as! ViewController).userName
        if quoteUserName == "" {
            headerLabel.text = "How are you?"
        }
        else {
            headerLabel.text = "How are you, \(quoteUserName)?"
        }
    }
    
    func assignbackground(){
        let background = UIImage(named: "nightsky.jpg")

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()

        // Do any additional setup after loading the view.
    }

}
