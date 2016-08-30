//
//  SettingsViewController.swift
//  Simon
//
//  Created by Saurav Desai on 8/29/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var vibrationSwitch: UISegmentedControl!
    @IBOutlet weak var soundSwitch: UISegmentedControl!
    @IBOutlet weak var origBackgroundColorView: UIView!
    @IBOutlet weak var purpleBackgroundColorView: UIView!
    @IBOutlet weak var brownBackgroundColorView: UIView!
    @IBOutlet weak var roundSquareView: UIView!
    @IBOutlet weak var perfectSquareView: UIView!
    @IBOutlet weak var perfectCircleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.view.backgroundColor = currentBackgroundColor
        let attr = NSDictionary(object: UIFont(name: "Avenir-Light", size: 13.0)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
        
        backButton.layer.cornerRadius = 7
        backButton.clipsToBounds = true
        
        origBackgroundColorView.layer.cornerRadius = 13
        origBackgroundColorView.clipsToBounds = true
        origBackgroundColorView.layer.borderWidth = 2
        origBackgroundColorView.backgroundColor = originalColor
        origBackgroundColorView.userInteractionEnabled = true
        
        purpleBackgroundColorView.layer.cornerRadius = 13
        purpleBackgroundColorView.clipsToBounds = true
        purpleBackgroundColorView.layer.borderWidth = 2
        purpleBackgroundColorView.backgroundColor = UIColor.purpleColor()
        purpleBackgroundColorView.userInteractionEnabled = true
        
        brownBackgroundColorView.layer.cornerRadius = 13
        brownBackgroundColorView.clipsToBounds = true
        brownBackgroundColorView.layer.borderWidth = 2
        brownBackgroundColorView.backgroundColor = UIColor.brownColor()
        brownBackgroundColorView.userInteractionEnabled = true
        
        roundSquareView.layer.cornerRadius = 13
        roundSquareView.clipsToBounds = true
        roundSquareView.layer.borderWidth = 2
        roundSquareView.layer.borderColor = UIColor.whiteColor().CGColor
        roundSquareView.backgroundColor = UIColor.whiteColor()
        roundSquareView.userInteractionEnabled = true
        
        perfectSquareView.layer.borderWidth = 2
        perfectSquareView.layer.borderColor = UIColor.whiteColor().CGColor
        perfectSquareView.backgroundColor = UIColor.clearColor()
        perfectSquareView.userInteractionEnabled = true
        
        perfectCircleView.layer.cornerRadius = 0.5 * perfectCircleView.bounds.size.width
        perfectCircleView.clipsToBounds = true
        perfectCircleView.layer.borderWidth = 2
        perfectCircleView.layer.borderColor = UIColor.whiteColor().CGColor
        perfectCircleView.backgroundColor = UIColor.clearColor()
        perfectCircleView.userInteractionEnabled = true
        
        switch currentBackgroundColor{
        case originalColor:
            origBackgroundColorView.layer.borderColor = UIColor.greenColor().CGColor
            purpleBackgroundColorView.layer.borderColor = UIColor.purpleColor().CGColor
            brownBackgroundColorView.layer.borderColor = UIColor.brownColor().CGColor
        case UIColor.purpleColor():
            origBackgroundColorView.layer.borderColor = originalColor.CGColor
            purpleBackgroundColorView.layer.borderColor = UIColor.greenColor().CGColor
            brownBackgroundColorView.layer.borderColor = UIColor.brownColor().CGColor
        default:
            origBackgroundColorView.layer.borderColor = originalColor.CGColor
            purpleBackgroundColorView.layer.borderColor = UIColor.purpleColor().CGColor
            brownBackgroundColorView.layer.borderColor = UIColor.greenColor().CGColor
        }
        
        let backgroundGestureRecognizer0 = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.backgroundViewTapped(_:)))
        let backgroundGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.backgroundViewTapped(_:)))
        let backgroundGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.backgroundViewTapped(_:)))
        origBackgroundColorView.addGestureRecognizer(backgroundGestureRecognizer0)
        purpleBackgroundColorView.addGestureRecognizer(backgroundGestureRecognizer1)
        brownBackgroundColorView.addGestureRecognizer(backgroundGestureRecognizer2)
    }
    
    func backgroundViewTapped(recognizer: UITapGestureRecognizer){
        let tappedSquare = recognizer.view!
        origBackgroundColorView.layer.borderColor = UIColor.clearColor().CGColor
        purpleBackgroundColorView.layer.borderColor = UIColor.clearColor().CGColor
        brownBackgroundColorView.layer.borderColor = UIColor.clearColor().CGColor
        tappedSquare.layer.borderColor = UIColor.greenColor().CGColor
        switch tappedSquare{
        case origBackgroundColorView:
            self.view.backgroundColor = originalColor
            currentBackgroundColor = originalColor
        case purpleBackgroundColorView:
            self.view.backgroundColor = UIColor.purpleColor()
            currentBackgroundColor = UIColor.purpleColor()
        default:
            self.view.backgroundColor = UIColor.brownColor()
            currentBackgroundColor = UIColor.brownColor()
        }
    }
    
    

}





















