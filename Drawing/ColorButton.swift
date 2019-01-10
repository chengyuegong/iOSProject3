//
//  ColorButton.swift
//  Drawing
//
//  Created by Chengyue Gong on 2019/1/10.
//  Copyright © 2019 Chengyue Gong. All rights reserved.
//

import UIKit

class ColorButton: UIButton {
    
    // Using alpha to indicate whether the button is selected or not
    // selected: alpha = 1.0
    // unselected: alpha = 0.2
    private var myAlpha: CGFloat = 0.2
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Make it a circle button
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.layer.masksToBounds = true
        self.alpha = myAlpha
    }
    
    func unselect() {
        myAlpha = 0.2
        setNeedsDisplay()
    }
    
    func select() {
        myAlpha = 1.0
        setNeedsDisplay()
    }
    
    func isSelected() -> Bool {
        return myAlpha == 1.0
    }
    
}
