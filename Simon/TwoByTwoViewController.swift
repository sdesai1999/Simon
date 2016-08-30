//
//  TwoByTwoViewController.swift
//  Simon
//
//  Created by Saurav Desai on 8/16/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

class TwoByTwoViewController: UIViewController {
    
    enum Color { // 4 colors for the uiviews
        case Yellow
        case Blue
        case Red
        case Green
        
        init(){
            let randNum = Int(arc4random_uniform(4))
            switch randNum{
            case 0: self = .Yellow
            case 1: self = .Blue
            case 2: self = .Red
            default: self = .Green
            }
        }
        
        func getColor() -> String{
            switch self{
            case .Yellow: return "Yellow"
            case .Blue: return "Blue"
            case .Red: return "Red"
            case .Green: return "Green"
            }
        }
    }
    
    @IBOutlet var squareViews: [UIView]!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    
    var scoreCount: Int = 0
    var highScoreCount: Int = 0
    
    var currentPattern: [Color] = []
    var usersPattern: [Color] = []
    var timer: NSTimer = NSTimer()
    
    var squareToLightUp: UIView = UIView()
    var tappedSquare: UIView = UIView()
    var currentSquare: Int = 0
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.view.backgroundColor = currentBackgroundColor
        incorrectLabel.hidden = true
        scoreLabel.text = "Score: \(scoreCount)"
        if defaults.valueForKey("highScore") != nil{
            highScoreCount = defaults.valueForKey("highScore") as! Int
        }else{
            highScoreCount = 0
        }
        highScoreLabel.text = "High Score: \(highScoreCount)"
        for square in squareViews{
            square.layer.cornerRadius = 10
            square.clipsToBounds = true
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(TwoByTwoViewController.squareTappedByUser(_:)))
            square.addGestureRecognizer(tapRecognizer)
        }
        self.disableGestureRecognizers()
        finishButton.layer.cornerRadius = 7
        finishButton.clipsToBounds = true
        self.addToAIPattern()
        self.setUpTimer()
    }
    
    func addToAIPattern(){
        let colorToAdd = Color()
        currentPattern.append(colorToAdd)
    }
    
    func addToUsersPattern(color: Color){
        usersPattern.append(color)
        if usersPattern[usersPattern.count-1] != currentPattern[usersPattern.count-1]{
            usersPattern.removeAll()
            self.disableGestureRecognizers()
            self.vibrateDevice()
            incorrectLabel.hidden = false
            self.reset()
        }else{
            if usersPattern.count == currentPattern.count{
                usersPattern.removeAll()
                self.disableGestureRecognizers()
                scoreCount += 1
                scoreLabel.text = "Score: \(scoreCount)"
                self.addToAIPattern()
                self.setUpTimer()
            }
        }
    }
    
    func flashSquare(){
        incorrectLabel.hidden = true
        if currentSquare == currentPattern.count{
            timer.invalidate()
            currentSquare = 0
            self.enableGestureRecognizers()
        }else{
            switch currentPattern[currentSquare]{
            case .Yellow:
                squareToLightUp = squareViews[0]
                squareToLightUp.alpha = 1
            case .Blue:
                squareToLightUp = squareViews[1]
                squareToLightUp.alpha = 1
            case .Red:
                squareToLightUp = squareViews[2]
                squareToLightUp.alpha = 1
            case .Green:
                squareToLightUp = squareViews[3]
                squareToLightUp.alpha = 1
            }
            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            currentSquare += 1
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.squareToLightUp.alpha = 0.15
            })
        }
    }
    
    func setUpTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(TwoByTwoViewController.flashSquare), userInfo: nil, repeats: true)
    }
    
    func squareTappedByUser(recognizer: UITapGestureRecognizer){
        self.disableGestureRecognizers()
        tappedSquare = recognizer.view!
        tappedSquare.alpha = 1
        timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(TwoByTwoViewController.dimSquare), userInfo: nil, repeats: false)
    }
    
    func dimSquare(){
        tappedSquare.alpha = 0.15
        var colorToAdd = Color()
        switch tappedSquare{
        case squareViews[0]: colorToAdd = .Yellow
        case squareViews[1]: colorToAdd = .Blue
        case squareViews[2]: colorToAdd = .Red
        default: colorToAdd = .Green
        }
        self.addToUsersPattern(colorToAdd)
        self.enableGestureRecognizers()
        if usersPattern.count != currentPattern.count{
            self.enableGestureRecognizers()
        }
    }
    
    func enableGestureRecognizers(){
        for square in squareViews{
            square.userInteractionEnabled = true
        }
    }
    
    func disableGestureRecognizers(){
        for square in squareViews{
            square.userInteractionEnabled = false
        }
    }
    
    func reset(){
        if scoreCount > highScoreCount{
            highScoreCount = scoreCount
            highScoreLabel.text = "High Score: \(highScoreCount)"
            defaults.setInteger(highScoreCount, forKey: "highScore")
        }
        scoreCount = 0
        scoreLabel.text = "Score: \(scoreCount)"
        currentPattern.removeAll()
        usersPattern.removeAll()
        currentSquare = 0
        timer = NSTimer()
        timer.invalidate()
        self.addToAIPattern()
        self.setUpTimer()
    }
    
    func vibrateDevice(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    @IBAction func finishButtonTapped(sender: UIButton) {
        timer.invalidate()
        if scoreCount > highScoreCount{
            highScoreCount = scoreCount
            highScoreLabel.text = "High Score: \(highScoreCount)"
            defaults.setInteger(highScoreCount, forKey: "highScore")
        }
        scoreCount = 0
        scoreLabel.text = "Score: \(scoreCount)"
        self.performSegueWithIdentifier("2x2ToHomeScreen", sender: self)
    }
    
}

















