//
//  ThreeByThreeViewController.swift
//  Simon
//
//  Created by Saurav Desai on 8/16/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit

class ThreeByThreeViewController: UIViewController {

    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
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
        
        finishButton.layer.cornerRadius = 7
        finishButton.clipsToBounds = true
    }

    @IBAction func finishButtonTapped(sender: UIButton) {
        self.performSegueWithIdentifier("3x3ToHomeScreen", sender: self)
    }
}
