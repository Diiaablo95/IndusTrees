//
//  AchievmentCell.swift
//  IndusTrees
//
//  Created by Andrea Vultaggio on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class AchievmentCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var intDescription: UILabel!
    @IBOutlet weak var badge: UIImageView!
    
    override func awakeFromNib() {
        self.backgroundColor = .clear
    }
    
    func config(achievement: Achivement) {
        
        self.title.text = achievement.name
        self.intDescription.text = achievement.description
        self.badge.image = #imageLiteral(resourceName: "Trophy")
    }
}
