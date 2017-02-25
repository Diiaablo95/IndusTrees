//
//  ViewController.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    fileprivate static let logoMinY: CGFloat = UIApplication.shared.statusBarFrame.height * 2
    
    @IBOutlet weak var viewLogo: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.animateView()
    }
    
    @IBAction func loginDidTap(_ sender: UIButton) {
        //instantiate MenuController according to privileges
    }
    
    private func configure() {
        self.viewLogo.center = self.view.center
    }
    
    private func animateView() {
    
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseIn, animations: {
            
            let logoScaledWidth: CGFloat = self.viewLogo.frame.width / 2

            self.viewLogo.bounds.size = CGSize(width: logoScaledWidth, height: logoScaledWidth)
            self.viewLogo.center.y = (logoScaledWidth / 2) + LoginController.logoMinY
        }, completion: { _ in
            
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                
                //AnimateTextField
            }, completion: nil)
        })
    }
    
    
}
