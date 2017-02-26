//
//  Utilities.swift
//  IndusTrees
//
//  Created by Alberto Saltarelli on 26/02/2017.
//  Copyright © 2017 Saltarelli. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    let gl: CAGradientLayer
    
    init(colorTop: UIColor, colorBottom: UIColor) {
        gl = CAGradientLayer()
        gl.colors = [ colorTop, colorBottom]
        gl.locations = [ 0.0, 1.0]
    }
}
