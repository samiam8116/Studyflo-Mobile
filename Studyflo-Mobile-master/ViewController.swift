//
//  ViewController.swift
//  Project1
//
//  Created by Arianna O'Neil on 4/19/20.
//  Copyright © 2020 Arianna O'Neil. All rights reserved.
//

/*
 Authors: Arianna O'Neil, Samantha Silvia, Logan Teceno & Joshua Keif
 */

import UIKit
import Foundation

class ViewController: UIViewController {
    
    // on click, current weather info is displayed
    @IBAction func weatherDescrClick(_ sender: Any) {
        getWeatherDescr()
    }
    
    // on click, current temp info is displayed
    @IBAction func weatherBtnClick(_ sender: Any) {
       getWeather()
    }
    
    func getWeather(){
        // begin session
        let session = URLSession.shared
        // url to api content
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Boston,us?&units=imperial&APPID=f52c7e3b80332d1b01fffc4011795e3a")!
        // initialize datatask & begin traversing json content
        let dataTask = session.dataTask(with: weatherURL) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("An error occurred:\(error)")
            } else {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("All the weather data:\n\(dataString!)")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary {
                            if let temperature = mainDictionary.value(forKey: "temp") {
                                if let realfeel = mainDictionary.value(forKey: "feels_like"){
                                    DispatchQueue.main.async {
                                        // update weather label
                                        self.weatherLabel.text = "Boston Temperature: \(temperature)°F \n Feels like: \(realfeel)°F"
                                    }
                                }
                            }
                        }
                            // debugging statements
                        else {
                            print("Can't find temp in dictionary")
                        }
                    } else {
                        print("Unable to convert JSON")
                    }
                } else {
                    print("Request failed")
                }
            }
        }
    dataTask.resume()
    }
    
    @IBAction func locationBtn(_ sender: Any) {
        
    }
    
    
    func getWeatherDescr(){
        // begin session
        let session = URLSession.shared
        // url to api content
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Boston,us?&units=imperial&APPID=f52c7e3b80332d1b01fffc4011795e3a")!
        // initialize datatask & begin traversing api content
        let dataTask = session.dataTask(with: weatherURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("An error occurred.")
            } else {
                if let data =  data {
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        // since the weather descr is inside of an array, using swift types
                        guard let newValue = jsonResult as? [String: Any] else {
                            print("invalid format")
                            return
                        }
                        // checking for weather description inside of array
                        if let weather = newValue["weather"] as? [[String: Any]], let description = weather.first?["description"] as? String {
                            // posts to app
                            DispatchQueue.main.async {
                                // debugging statement
                            print(description)
                                // update weather label
                            self.weatherLabel.text = "Boston's weather at the moment: \n \(description)"
                        }
                        }
                    }catch {
                        print("An error occurred, JSON processing failed.")
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    var userName: String = ""
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBAction func userInfo(_ sender: Any) {
        let alert = UIAlertController(title: "About you!", message: "Enter your name!", preferredStyle: .alert)
        alert.addTextField {
            (textField) in textField.text = "Name"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
            
            if textField!.text! == "" {
                self.welcomeLabel.text = "Hey there!"
            }
            if textField!.text! != "" {
                self.userName = textField!.text!
                self.welcomeLabel.text = "Hey there, \(textField!.text!)!"
            }
        }))
 
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func aboutButton(_ sender: Any) {
        let alertController = UIAlertController(title: "About us", message: "Studyflo is based on a larger scale web application. This app was developed and modified by Ari, Sam, Logan, and Josh.", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func helpButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Help", message: "Check out the 'Click Me' button to enter your name and personalize your experience!", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //wallpaper
    func assignbackground(){
        let background = UIImage(named: "studyfloDesktop.jpg")

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
        // weather data
        getWeatherDescr()
        getWeather()
    }
}
