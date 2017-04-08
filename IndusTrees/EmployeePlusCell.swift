//
//  TeamMemberPlusCell.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class EmployeePlusCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonAchievement: UIButton!
    @IBOutlet weak var buttonTasks: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
