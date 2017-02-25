//
//  TeamMemberPlusCell.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 25/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import UIKit

class EmployeePlusCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.configureView()
    }
    
    private func configureView() {
        
        let colors = Colors()
        
        self.backgroundColor = .clear
        let backgroundLayer = colors.gl
        backgroundLayer.frame = self.frame
        self.layer.insertSublayer(backgroundLayer, at: 0)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
