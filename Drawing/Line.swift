//
//  Line.swift
//  Drawing
//
//  Created by Chengyue Gong on 2019/1/10.
//  Copyright © 2019 Chengyue Gong. All rights reserved.
//

import Foundation
import UIKit

class Line {
    
    var points: [CGPoint] // points in ths line
    var color: UIColor // line color
    var thickness: CGFloat // linewidth
    
    init(beginAt point: CGPoint, color: UIColor, thickness: CGFloat) {
        points = [point]
        self.color = color
        self.thickness = thickness
    }
}
