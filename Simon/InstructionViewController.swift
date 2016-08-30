//
//  InstructionViewController.swift
//  Simon
//
//  Created by Saurav Desai on 8/16/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var instructionString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.view.backgroundColor = currentBackgroundColor
        backButton.layer.cornerRadius = 7
        backButton.clipsToBounds = true
        instructionString += "This is the classic game of Simon. The goal is to remember "
        instructionString += "the light pattern for as long as you can. "
        instructionString += "In this game, there are 2 different modes: 2x2 and 3x3. "
        instructionString += "They have 4 buttons and 9 buttons respectively. Good luck!"
        instructionLabel.text = instructionString
    }
}
