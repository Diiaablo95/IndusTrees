//
//  EmployeePlusAddCell.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class EmployeePlusAddCell: UITableViewCell {
    
    
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageToHidden: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
