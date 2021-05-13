//
//  Breakout.swift
//  tictactoe
//
//  Created by period2 on 4/27/21.
//

import UIKit
import AVFoundation
// import Darwin

class Breakout: UIViewController, UICollisionBehaviorDelegate {


    @IBOutlet weak var ball: UIView!
    @IBOutlet weak var player: UIView!
    @IBOutlet weak var startButtonOutlet: UIButton!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var easyButtonOutlet: UIButton!
    @IBOutlet weak var mediumButtonOutlet: UIButton!
    @IBOutlet weak var hardButtonOutlet: UIButton!
    
    @IBOutlet weak var brick1: UIView!
    @IBOutlet weak var brick2: UIView!
    @IBOutlet weak var brick3: UIView!
    @IBOutlet weak var brick4: UIView!
    @IBOutlet weak var brick5: UIView!
    @IBOutlet weak var brick6: UIView!
    @IBOutlet weak var brick7: UIView!
    @IBOutlet weak var brick8: UIView!
    
    var dynamicAnimator: UIDynamicAnimator!
    var pushBehavior: UIPushBehavior!
    var collisionBehavior: UICollisionBehavior!
    var ballDynamicItem: UIDynamicItemBehavior!
    var playerDynamicItem: UIDynamicItemBehavior!
    var brickDynamicItem: UIDynamicItemBehavior!
    var bricks:[UIView]!
    var brickCount: Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Makes the ball a circle

        ball.layer.cornerRadius = ball.frame.size.width / 2
        
        // dynamicBehaviors()
        
        ball.isHidden = true
        player.isHidden = true
        difficultyLabel.isHidden = true
        easyButtonOutlet.isHidden = true
        mediumButtonOutlet.isHidden = true
        hardButtonOutlet.isHidden = true
        
        bricks = [brick1, brick2, brick3, brick4, brick5, brick6, brick7, brick8]
        brickCount = bricks.count
        
        for brick in bricks{
            brick.isHidden = true
        }
        
        let synth = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: "Hello, Lucas")
        
        
    }
    
    @IBAction func checkForMovement(_ sender: UIPanGestureRecognizer) {
        
        // moves paddle to x location, y stays the same
        
        player.center = CGPoint(x: sender.location(in: view).x, y: player.center.y)
        dynamicAnimator.updateItem(usingCurrentState: player)
    }
    
    func dynamicBehaviors(magn: CGFloat) {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        pushBehavior = UIPushBehavior(items: [ball], mode: .instantaneous)
        pushBehavior.active = true
        
        dynamicAnimator.updateItem(usingCurrentState: ball)
        pushBehavior.setAngle(60.0, magnitude: magn)

        dynamicAnimator.addBehavior(pushBehavior)
    
        collisionBehavior = UICollisionBehavior(items: [ball, player] + bricks)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .everything
        
        dynamicAnimator.addBehavior(collisionBehavior)
        
        collisionBehavior.collisionDelegate = self // view controller we are in
        
        ballDynamicItem = UIDynamicItemBehavior(items: [ball])
        ballDynamicItem.allowsRotation = true
        ballDynamicItem.elasticity = 1
        ballDynamicItem.friction = 0
        ballDynamicItem.resistance = 0
        
        dynamicAnimator.addBehavior(ballDynamicItem)
       
        playerDynamicItem = UIDynamicItemBehavior(items: [player])
        playerDynamicItem.allowsRotation = false
        playerDynamicItem.density = 1e9
        playerDynamicItem.elasticity = 1
        playerDynamicItem.friction = 0
        playerDynamicItem.resistance = 0
        
        dynamicAnimator.addBehavior(playerDynamicItem)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        if p.y > player.center.y {
            // exit(0)
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        
        for brick in bricks{
            if item1.isEqual(ball) && item2.isEqual(brick) {
                collisionBehavior.removeItem(brick)
                brick.isHidden = true
                brickCount -= 1
            }
        }
    }
    
    func startScreen() {
        
        player.isHidden = true
        ball.isHidden = true
        
        for brick in bricks{
            brick.isHidden = true
        }
        
        startButtonOutlet.isHidden = true
        difficultyLabel.isHidden = false
        easyButtonOutlet.isHidden = false
        mediumButtonOutlet.isHidden = false
        hardButtonOutlet.isHidden = false
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        startScreen()
    }
    
    
    func setup(d: CGFloat, color: UIColor) { // Hide buttons, change magnitutde
        
        difficultyLabel.isHidden = true
        easyButtonOutlet.isHidden = true
        mediumButtonOutlet.isHidden = true
        hardButtonOutlet.isHidden = true
        
        for brick in bricks{
            brick.isHidden = false
        }
        
        player.isHidden = false
        ball.isHidden = false
        
        dynamicBehaviors(magn: d)
        
        view.backgroundColor = color
    }
    
    @IBAction func easy(_ sender: UIButton) {
        setup(d: CGFloat(1.0), color: .green)
    }
    
    @IBAction func medium(_ sender: UIButton) {
        setup(d: CGFloat(2.0), color: .yellow)
    }
    
    @IBAction func hard(_ sender: UIButton) {
        setup(d: CGFloat(4.0), color: .red)
    }
    
    func setupAnimations() {
        let anim = UIView()
        anim.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        anim.frame = CGRect(x: 0, y: 0, width: 100, height: 500)
        
        view.addSubview(anim)
        
        
        UIView.animate(withDuration: 2) {
            anim.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        }
    }

}
