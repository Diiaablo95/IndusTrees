//
//  EmployeeMenuController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class EmployeeMenuController: UIViewController {
    
    
    @IBOutlet weak var firstView: UIImageView!
    @IBOutlet weak var secondView: UIImageView!
    @IBOutlet weak var thirdView: UIImageView!
    @IBOutlet weak var fourthView: UIImageView!
    @IBOutlet weak var fifthView: UIImageView!

    
    var menuViews: [UIImageView]!
    var project: Project!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)

        self.project = DataStore.employee(with: LoginManager.shared.userId!)?.teamLeader?.projectManager?.project
        
        self.menuViews = [firstView, secondView, thirdView, fourthView, fifthView]
        
        self.menuViews.forEach({
            $0.center = self.view.center
            $0.layer.cornerRadius = $0.frame.height/2
        })
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let circRadius: CGFloat = (UIScreen.main.bounds.width - self.menuViews.first!.bounds.width) / 2
        
        let firstPosition = CGPoint(
            x: self.view.center.x + (circRadius * CGFloat(cos(Double(11/10 * M_PI)))),
            y: self.view.center.y + (circRadius * CGFloat(sin(Double(11/10 * M_PI))))
        )
        
        self.animateView(to: firstPosition, with: circRadius)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let leader = (DataStore.projectManager.teamLeaders.first {
            $0.team.contains(DataStore.employee(with: LoginManager.shared.userId!)!)
        }) else { return }
        
        let team = leader.team.sorted { $0.0.bid < $0.1.bid }
        
        if segue.identifier == "showAchievements" {
            
            let achievementsVC = segue.destination as! EmployeeAchievmentsViewController
            achievementsVC.achievments = DataStore.achivements.enumerated().dropLast(10).map { $0.element }
        }
        
        if segue.identifier == "showTeam" {
            let destVC = segue.destination as! TLTeamController
            
            destVC.teamMembers = team
        }
        
        if segue.identifier == "showTasks" {
            let destVC = segue.destination as! EmployeeTaskController
            
            destVC.tasks = DataStore.tasks.enumerated().dropLast(4).map {$0.element}
        }
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
            
            let endAngle: CGFloat = CGFloat(11/10 * M_PI) + (CGFloat(2 * M_PI) * CGFloat(index) / CGFloat(self.menuViews.count))
            
//            let finalPosition = CGPoint(x: view.center.x + (circRadius * cos(endAngle)), y: view.center.y + (circRadius * sin(endAngle)))
            
            keyFrameAnimation.path = self.drawCircularPath(circRadius: circRadius, with: endAngle).cgPath
            keyFrameAnimation.duration = 1.3
            keyFrameAnimation.fillMode = kCAFillModeForwards
            keyFrameAnimation.isRemovedOnCompletion = false
            
            view.layer.add(keyFrameAnimation, forKey: "animation")

        }
    }
    
    private func drawCircularPath(circRadius: CGFloat, with endAngle: CGFloat) -> UIBezierPath {
        
        let circlePath = UIBezierPath(arcCenter: self.view.center, radius: circRadius, startAngle: CGFloat(M_PI * 11/10), endAngle: endAngle, clockwise: true)
        
        return circlePath
    }
}

