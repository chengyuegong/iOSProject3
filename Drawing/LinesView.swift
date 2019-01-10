//
//  LinesView.swift
//  Drawing
//
//  Created by Chengyue Gong on 2019/1/10.
//  Copyright © 2019 Chengyue Gong. All rights reserved.
//

import UIKit

class LinesView: UIView {
    
    // current line
    var theLine: Line? {
        didSet {
            setNeedsDisplay()
        }
    }
    // lines
    var lines: [Line] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // pen color and linewidth for canvas
    var penColor: UIColor = UIColor.black // default: black
    var penLineWidth: CGFloat = 5.0 // default: 5.0
    
    // Store the deleted lines for future development (e.g. redo oepration)
    var deletedLines: [Line] = []
    
    // Erase the previous line
    func deletePreviousLine() {
        if let previousLine = lines.popLast() {
            deletedLines.append(previousLine)
        }
        setNeedsDisplay()
    }
    
    // Draw a point (circle at the point)
    private func drawPoint(_ point: CGPoint, _ color: UIColor, _ lineWidth: CGFloat) {
        let path = UIBezierPath()
        path.addArc(withCenter: point, radius: lineWidth/2, startAngle: 0, endAngle: CGFloat(2*Float.pi), clockwise: true)
        color.setFill()
        path.fill()
    }
    
    // Draw a smooth line
    private func drawLine(_ line: Line) {
        let path = createQuadPath(line: line)
        path.lineWidth = line.thickness
        line.color.setStroke()
        path.stroke()
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        for line in lines {
            drawLine(line)
        }
        if let currentLine = theLine {
            drawLine(currentLine)
        }
    }
    
    // return midpoint of two points
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        return CGPoint(x: (first.x+second.x)/2, y: (first.y+second.y)/2)
    }
    
    // The following function createQuadPath are based on codes in the Lab3.pdf
    func createQuadPath(line: Line) -> UIBezierPath {
        // Handling the condition for a single tap (draw a dot)
        if (line.points.count == 1) {
            drawPoint(line.points[0], line.color, line.thickness)
        }
        let path = UIBezierPath()
        if line.points.count < 2 { return path }
        let firstPoint = line.points[0]
        // Draw first point
        drawPoint(firstPoint, line.color, line.thickness)
        let secondPoint = line.points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< line.points.count-1 {
            let currentPoint = line.points[index]
            let nextPoint = line.points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
            // Make the line smoother
            drawPoint(midPoint, line.color, line.thickness)
        }
        guard let lastLocation = line.points.last else { return path }
        path.addLine(to: lastLocation)
        // Draw last point
        drawPoint(lastLocation, line.color, line.thickness)
        return path
    }
    
}
