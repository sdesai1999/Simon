//
//  TwoByTwoViewController.swift
//  Simon
//
//  Created by Saurav Desai on 8/16/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit

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

class TwoByTwoViewController: UIViewController {
    
    @IBOutlet var squareViews: [UIView]!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var scoreCount: Int = 0
    var highScoreCount: Int = 0
    
    var currentPattern: [Color] = []
    var usersPattern: [Color] = []
    var timer: NSTimer = NSTimer()
    
    var squareToLightUp: UIView = UIView()
    var tappedSquare: UIView = UIView()
    var currentSquare: Int = 0
    
    var tapRecognizer0: UITapGestureRecognizer = UITapGestureRecognizer()
    var tapRecognizer1: UITapGestureRecognizer = UITapGestureRecognizer()
    var tapRecognizer2: UITapGestureRecognizer = UITapGestureRecognizer()
    var tapRecognizer3: UITapGestureRecognizer = UITapGestureRecognizer()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        scoreLabel.text = "Score: \(scoreCount)"
        if defaults.valueForKey("highScore") != nil{
            highScoreCount = defaults.valueForKey("highScore") as! Int
        }else{
            highScoreCount = 0
        }
        highScoreLabel.text = "High Score: \(highScoreCount)"
        tapRecognizer0 = UITapGestureRecognizer(target: self, action: #selector(TwoByTwoViewController.squareTappedByUser(_:)))
        tapRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(TwoByTwoViewController.squareTappedByUser(_:)))
        tapRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(TwoByTwoViewController.squareTappedByUser(_:)))
        tapRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(TwoByTwoViewController.squareTappedByUser(_:)))
        squareViews[0].addGestureRecognizer(tapRecognizer0)
        squareViews[1].addGestureRecognizer(tapRecognizer1)
        squareViews[2].addGestureRecognizer(tapRecognizer2)
        squareViews[3].addGestureRecognizer(tapRecognizer3)
        for square in squareViews{
            square.layer.cornerRadius = 10
            square.clipsToBounds = true
            square.userInteractionEnabled = false
        }
        resetButton.layer.cornerRadius = 7
        resetButton.clipsToBounds = true
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
            for square in squareViews{
                square.userInteractionEnabled = false
            }
            self.reset()
        }else{
            if usersPattern.count == currentPattern.count{
                usersPattern.removeAll()
                for square in squareViews{
                    square.userInteractionEnabled = false
                }
                scoreCount += 1
                scoreLabel.text = "Score: \(scoreCount)"
                self.addToAIPattern()
                self.setUpTimer()
            }
        }
    }
    
    func flashSquare(){
        if currentSquare == currentPattern.count{
            timer.invalidate()
            currentSquare = 0
            self.setUpGestureRecognizers()
        }else{
            //print(currentPattern[currentSquare].getColor())
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
    }
    
    func setUpGestureRecognizers(){
        for square in squareViews{
            square.userInteractionEnabled = true
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
    
    @IBAction func resetButtonTapped(sender: UIButton) {
        self.reset()
    }
    
}

















