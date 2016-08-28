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
        finishButton.layer.cornerRadius = 7
        finishButton.clipsToBounds = true
    }

    @IBAction func finishButtonTapped(sender: UIButton) {
        self.performSegueWithIdentifier("3x3ToHomeScreen", sender: self)
    }
}
