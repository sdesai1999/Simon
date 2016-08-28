//
//  InitialViewController.swift
//  Simon
//
//  Created by Saurav Desai on 8/15/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var twoByTwoButton: UIButton!
    @IBOutlet weak var threeByThreeButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        twoByTwoButton.layer.cornerRadius = 20
        twoByTwoButton.clipsToBounds = true
        threeByThreeButton.layer.cornerRadius = 20
        threeByThreeButton.clipsToBounds = true
        infoButton.layer.cornerRadius = 0.5 * infoButton.bounds.size.width
        infoButton.clipsToBounds = true
    }

}

