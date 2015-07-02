//
//  SecondViewController.swift
//  Mix
//
//  Created by Juan Gomez on 30/06/15.
//  Copyright (c) 2015 Codes and Tags. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    func showError(){
        result.text = "The city hasn't been found"
    }
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var cityField: UITextField!
    @IBAction func searchButton(sender: AnyObject) {
        var myString = cityField.text
        var newString = myString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if newString.isEmpty{
            result.text = "Please fill the text field."
        }else{
            //Weather Part
            var weather = ""
            var urlError = false
            var url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityField.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
            if url != nil{
                var task = NSURLSession.sharedSession().dataTaskWithURL(url!){
                    (data, response, error) in
                    if error == nil{
                        var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                        var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                        if urlContentArray.count > 1 {
                            var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                            weather = weatherArray[0] as! String
                            weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        }else{
                            urlError = true
                        }
                        
                    }else{
                        urlError = true
                    }
                    dispatch_sync(dispatch_get_main_queue()){
                        if urlError == false {
                            self.result.text = "\(self.cityField.text.uppercaseString) \n\n" + weather
                            //table part
                            cities.append(self.cityField.text)
                            self.cityField.text = ""
                            println(cities)
                            NSUserDefaults.standardUserDefaults().setObject(cities, forKey: "cities")
                        }else{
                            self.showError()
                        }
                    }
                }
                task.resume()
            }else{
                showError()
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.cityField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        cityField.text = ""
        view.self.endEditing(true)
        cityField.text = ""
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var myString = cityField.text
        var newString = myString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if newString.isEmpty{
            result.text = "Please fill the text field."
        }else{
            cities.append(cityField.text)
            NSUserDefaults.standardUserDefaults().setObject(cities, forKey: "cities")
            cityField.text = ""
            result.text = ""
        }
        self.cityField.resignFirstResponder()
        return true
    }

}

