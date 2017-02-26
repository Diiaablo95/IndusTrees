//
//  PMMenuController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class TLMenuController: UIViewController {
    
    
    @IBOutlet weak var firstView: UIImageView!
    @IBOutlet weak var secondView: UIImageView!
    @IBOutlet weak var thirdView: UIImageView!
    @IBOutlet weak var fourthView: UIImageView!
    @IBOutlet weak var fifthView: UIImageView!
    @IBOutlet weak var sixthView: UIImageView!
    
    var menuViews: [UIImageView]!
    var project: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        self.configureImageView()

        self.menuViews = [firstView, secondView, thirdView, fourthView, fifthView, sixthView]
        
        self.menuViews.forEach({
            $0.center = self.view.center
            $0.layer.cornerRadius = $0.frame.height/2
        })
    }
    
    func configureImageView() {
       
        self.sixthView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showTeam(_:))))
    }
    
    func showTeam(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "showTeam", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTeam" {
            let destVC = segue.destination as! TLTeamController
            var members: [Employee] = []
            self.project.manager.teamLeaders.forEach({ leader in
                members.append(contentsOf: leader.team)
            })
            destVC.teamMembers = members
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let circRadius: CGFloat = (UIScreen.main.bounds.width - self.menuViews.first!.bounds.width) / 2
        
        let firstPosition = CGPoint(
            x: self.view.center.x + (circRadius * CGFloat(cos(Double(7/6 * M_PI)))),
            y: self.view.center.y + (circRadius * CGFloat(sin(Double(7/6 * M_PI))))
        )
        
        
        self.animateView(to: firstPosition, with: circRadius)
    }
    
    private func animateView(to firstPosition: CGPoint, with circRadius: CGFloat) {

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            
            self.menuViews.forEach({
                $0.center = firstPosition
            })
            
        }, completion: { _ in
            
            self.animateViewCircular(circRadius: circRadius)
        })
    }
    
    private func animateViewCircular(circRadius: CGFloat) {
        
        for (index, view) in self.menuViews.enumerated().reversed() {
            
            let keyFrameAnimation = CAKeyframeAnimation(keyPath:"position")
        
            let endAngle: CGFloat = CGFloat(7/6 * M_PI) + (CGFloat(2 * M_PI) * CGFloat(index) / CGFloat(self.menuViews.count))
            
            keyFrameAnimation.path = self.drawCircularPath(circRadius: circRadius, with: endAngle).cgPath
            keyFrameAnimation.duration = 1.3
            keyFrameAnimation.fillMode = kCAFillModeForwards
            keyFrameAnimation.isRemovedOnCompletion = false
            
            if index == 0 {
                keyFrameAnimation.delegate = self
            }
            
            view.layer.add(keyFrameAnimation, forKey: nil)
        }
        
    }
    
    private func drawCircularPath(circRadius: CGFloat, with endPosition: CGFloat) -> UIBezierPath {
        
        let circlePath = UIBezierPath(arcCenter: self.view.center, radius: circRadius, startAngle: CGFloat(M_PI * 7/6), endAngle: endPosition, clockwise: true)
        
        return circlePath
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = circlePath.cgPath
//        
//        //Customize here
//        
//        view.layer.addSublayer(shapeLayer)
    }
}

extension TLMenuController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.menuViews.forEach({
            $0.frame = $0.layer.frame
        })
    }
    
}
