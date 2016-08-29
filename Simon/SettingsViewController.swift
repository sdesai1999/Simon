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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attr = NSDictionary(object: UIFont(name: "Avenir-Light", size: 13)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
        origBackgroundColorView.layer.cornerRadius = 13
        origBackgroundColorView.clipsToBounds = true
        origBackgroundColorView.layer.borderWidth = 2
        purpleBackgroundColorView.layer.cornerRadius = 13
        purpleBackgroundColorView.clipsToBounds = true
        purpleBackgroundColorView.layer.borderWidth = 2
        brownBackgroundColorView.layer.cornerRadius = 13
        brownBackgroundColorView.clipsToBounds = true
        brownBackgroundColorView.layer.borderWidth = 2
    }

}
