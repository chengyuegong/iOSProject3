//
//  Functions.swift
//  Drawing
//
//  Created by Chengyue Gong on 2019/1/10.
//  Copyright © 2019 Chengyue Gong. All rights reserved.
//

import Foundation
import UIKit

class Functions {
    private static let minDistance: CGFloat = 1.0
    
    // Calculate the distance between two points
    static func distance(_ point1: CGPoint, _ point2: CGPoint) -> CGFloat {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
    
    // Decide whether two points are far enought to update the path
    static func farEnough(_ point1: CGPoint, _ point2: CGPoint) -> Bool {
        if distance(point1, point2) > minDistance {
            return true
        } else {
            return false
        }
    }
}
