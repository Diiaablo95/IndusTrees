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
        super.awakeFromNib()
        config()
    }
    
    private func config() {
        
        self.backgroundColor = .clear
        title.text = "title"
        intDescription.text = "description"
        badge = UIImageView(image: #imageLiteral(resourceName: "Trophy"))
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
