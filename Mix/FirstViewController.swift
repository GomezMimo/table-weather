//
//  FirstViewController.swift
//  Mix
//
//  Created by Juan Gomez on 30/06/15.
//  Copyright (c) 2015 Codes and Tags. All rights reserved.
//

import UIKit

var cities = [String]()

class FirstViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if NSUserDefaults.standardUserDefaults().objectForKey("cities") != nil{
            cities = NSUserDefaults.standardUserDefaults().objectForKey("cities") as! [String]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        table.reloadData()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            cities.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(cities, forKey: "cities")
            table.reloadData()
        }
    }


}

