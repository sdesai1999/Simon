//
//  TwoByTwoViewController.swift
//  Simon
//
//  Created by Saurav Desai on 8/16/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit

enum Color{
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
}

class TwoByTwoViewController: UIViewController {

    @IBOutlet var squareViews: [UIView]!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var scoreCount: Int = 0
    var highScoreCount: Int = 0
    var tapRecognizer0: UITapGestureRecognizer = UITapGestureRecognizer()
    var tapRecognizer1: UITapGestureRecognizer = UITapGestureRecognizer()
    var tapRecognizer2: UITapGestureRecognizer = UITapGestureRecognizer()
    var tapRecognizer3: UITapGestureRecognizer = UITapGestureRecognizer()
    var currentPattern: [Color] = []
    var timer: NSTimer = NSTimer()
    var squareToLightUp: UIView? = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        for square in squareViews{
            square.layer.cornerRadius = 10
            square.clipsToBounds = true
        }
        resetButton.layer.cornerRadius = 7
        resetButton.clipsToBounds = true
        finishButton.layer.cornerRadius = 7
        finishButton.clipsToBounds = true
        self.addToPattern()
        self.displayPattern()
    }
    
    func addToPattern(){
        let colorToAdd = Color()
        currentPattern.append(colorToAdd)
    }
    
    func displayPattern(){
        for current in currentPattern{
            switch current{
            case .Yellow:
                squareToLightUp = squareViews[0]
                squareToLightUp!.alpha = 1
            case .Blue:
                squareToLightUp = squareViews[1]
                squareToLightUp!.alpha = 1
            case .Red:
                squareToLightUp = squareViews[2]
                squareToLightUp!.alpha = 1
            case .Green:
                squareToLightUp = squareViews[3]
                squareToLightUp!.alpha = 1
            }
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TwoByTwoViewController.dimSquare), userInfo: nil, repeats: false)
        }
    }
    
    func dimSquare(){
        squareToLightUp!.alpha = 0.15
        squareToLightUp = nil
    }

}








