//
//  TimerViewController.swift
//  Project1
//
//  Created by Arianna O'Neil on 4/19/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

/*
Authors: Arianna O'Neil, Samantha Silvia, Logan Teceno & Joshua Keif
*/

import UIKit

class TimerViewController: UIViewController {

    //countdown label
    @IBOutlet weak var countdown: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    var timerUserName: String = ""
    
    //variables
    var seconds = 60 // timer is set to 60 seconds
    var timer = Timer()
    var isTimerRunning = false //make sure only one timer is running at a time
    
    override func viewWillAppear(_ animated: Bool) {
        timerUserName = (presentingViewController as! ViewController).userName
        if timerUserName == "" {
            headerLabel.text = "Take a breath."
        }
        else {
            headerLabel.text = "Take a breath, \(timerUserName)."
        }
    }
    
    //start timer
    @IBAction func startTimer(_ sender: Any) {
        if seconds == 60 {
            runTimer()
        }
    }
    
    //run timer
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    //show seconds on app
    @objc func updateTimer() {
        let posOrZero = max(seconds, 0)
        
        seconds -= 1
        countdown.text = "\(posOrZero)"
        
        let finishAlertController = UIAlertController(title: "Meditation Complete", message: "Your minute of rest and relaxation is now complete. We hope you are refreshed. Now go out there and achieve your goals!", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        finishAlertController.addAction(defaultAction)
        if seconds == -1 {
            present(finishAlertController, animated: true, completion: nil)
            timer.invalidate()
        }
    }
    
    //reset timer
    @IBAction func resetTimer(_ sender: Any) {
        timer.invalidate()
        seconds = 60
        countdown.text = "\(seconds)"
    }
    
    
    @IBAction func aboutButton(_ sender: Any) {
        if seconds == 60 {
            timer.invalidate()
        }
        let aboutAlertController = UIAlertController(title: "Meditation Timer", message: "Just one minute of practicing meditation or mindfulness can improve your daily life.", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        aboutAlertController.addAction(defaultAction)
        present(aboutAlertController, animated: true, completion: nil)
    }
   
    @IBAction func helpButton(_ sender: Any) {
        if seconds == 60 {
            timer.invalidate()
        }
        let helpAlertController = UIAlertController(title: "Help", message: "Tap 'start' to begin the countdown. Tap 'reset' as needed.", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        helpAlertController.addAction(defaultAction)
        present(helpAlertController, animated: true, completion: nil)
    }
    

    //wallpaper
    func assignbackground(){
        let background = UIImage(named: "oceanview.jpg")

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
        /*
        let gradientLayer = CAGradientLayer()
        
        let colorTop = UIColor(red: 220.0 / 255.0, green: 80.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0).cgColor
        
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [colorBottom, colorTop]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        */
        
        assignbackground()

        // Do any additional setup after loading the view.
    }

}
