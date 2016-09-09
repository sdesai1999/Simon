//
//  InitialViewController.swift
//  Simon
//
//  Created by Saurav Desai on 8/15/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit

let originalColor = UIColor(red: 0.121569, green: 0.129412, blue: 0.141176, alpha: 1)
var currentBackgroundColor: String = String()
var shapeToUse: String = String()
let defaults = NSUserDefaults.standardUserDefaults()


class InitialViewController: UIViewController {

    @IBOutlet weak var twoByTwoButton: UIButton!
    @IBOutlet weak var threeByThreeButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        if defaults.valueForKey("backgroundColor") != nil{
            currentBackgroundColor = defaults.valueForKey("backgroundColor") as! String
        }else{
            currentBackgroundColor = "originalColor"
        }
        
        switch currentBackgroundColor{
        case "originalColor":
            self.view.backgroundColor = originalColor
        case "purple":
            self.view.backgroundColor = UIColor.purpleColor()
        default:
            self.view.backgroundColor = UIColor.brownColor()
        }
        
        if defaults.valueForKey("shape") != nil{
            shapeToUse = defaults.valueForKey("shape") as! String
        }else{
            shapeToUse = "round square"
        }
        
        twoByTwoButton.layer.cornerRadius = 20
        twoByTwoButton.clipsToBounds = true
        threeByThreeButton.layer.cornerRadius = 20
        threeByThreeButton.clipsToBounds = true
        infoButton.layer.cornerRadius = 0.5 * infoButton.bounds.size.width
        infoButton.clipsToBounds = true
        settingsButton.layer.cornerRadius = 7
        settingsButton.clipsToBounds = true
    }

}

