//
//  ViewController.swift
//  Drawing
//
//  Created by Chengyue Gong on 2019/1/8.
//  Copyright © 2019 Chengyue Gong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PassColorProtocol {
    
    // Create a view for pop-up palette
    var popupViewController: PalettePopUpViewController?
    // Canvas for drawing
    @IBOutlet weak var canvas: LinesView!
    // the line that is being drawn
    var currentLine: Line?
    
    // Color buttons
    // Creative portion: user can switch between black and white via double click
    @IBOutlet weak var blackWhiteBtn: ColorButton!
    var blackOrWhite: UIColor = UIColor.black { // default: black
        didSet {
            blackWhiteBtn.backgroundColor = blackOrWhite
        }
    }
    // Five common colors
    @IBOutlet weak var redBtn: ColorButton!
    @IBOutlet weak var orangeBtn: ColorButton!
    @IBOutlet weak var yellowBtn: ColorButton!
    @IBOutlet weak var greenBtn: ColorButton!
    @IBOutlet weak var blueBtn: ColorButton!
    // Creative portion: add button for a custom color
    @IBOutlet weak var customBtn: ColorButton!
    var customColor: UIColor = UIColor.purple { // default: purple
        didSet {
            customBtn.backgroundColor = customColor
        }
    }
    
    // Functions for all outlets at the top of the canvas
    // Clear the canvas (remove all lines)
    @IBAction func clearCanvas(_ sender: UIButton) {
        canvas.theLine = nil
        canvas.lines = []
    }
    // Erase the previous line
    @IBAction func undo(_ sender: UIButton) {
        canvas.deletePreviousLine()
    }
    // Change different thickness through slider
    @IBAction func changeThickness(_ sender: UISlider) {
        canvas.penLineWidth = CGFloat(sender.value)
    }
    
    // Functions for all outlets at the bottom of the canvas
    // Set all buttons as an unselected state
    func unselectAllButtons() {
        blackWhiteBtn.unselect()
        redBtn.unselect()
        orangeBtn.unselect()
        yellowBtn.unselect()
        greenBtn.unselect()
        blueBtn.unselect()
        customBtn.unselect()
    }
    
    // Creative portion: users can switch between black and white via double click
    // Touch down
    @IBAction func set2BlackOrWhite(_ sender: ColorButton) {
        canvas.penColor = blackOrWhite
        unselectAllButtons()
        blackWhiteBtn.select()
    }
    // Touch down repeat
    @IBAction func switchBlackWhite(_ sender: ColorButton) {
        if (blackOrWhite == UIColor.black) {
            blackOrWhite = UIColor.white
        } else {
            blackOrWhite = UIColor.black
        }
        canvas.penColor = blackOrWhite
        unselectAllButtons()
        blackWhiteBtn.select()
    }
    
    // Functions for selecting 5 common colors
    @IBAction func set2Red(_ sender: ColorButton) {
        canvas.penColor = UIColor.red
        unselectAllButtons()
        redBtn.select()
    }
    @IBAction func set2Orange(_ sender: ColorButton) {
        canvas.penColor = UIColor.orange
        unselectAllButtons()
        orangeBtn.select()
    }
    @IBAction func set2Yellow(_ sender: ColorButton) {
        canvas.penColor = UIColor.yellow
        unselectAllButtons()
        yellowBtn.select()
    }
    @IBAction func set2Green(_ sender: ColorButton) {
        canvas.penColor = UIColor.green
        unselectAllButtons()
        greenBtn.select()
    }
    @IBAction func set2Blue(_ sender: ColorButton) {
        canvas.penColor = UIColor.blue
        unselectAllButtons()
        blueBtn.select()
    }
    
    // Creative portion: users can choose his or her own color using RGB value
    @IBAction func set2Custom(_ sender: ColorButton) {
        canvas.penColor = customColor
        unselectAllButtons()
        customBtn.select()
    }
    
    // Implements protocol PassValueProtocol
    func setColor(color: UIColor) {
        customColor = color
        if (customBtn.isSelected()) {
            canvas.penColor = customColor
        }
        canvas.penColor = customColor
        unselectAllButtons()
        customBtn.select()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // default color is black
        blackWhiteBtn.select() // default: black color
    }
    
    var prevPoint: CGPoint? // for making the line smoother
    
    // Drawing functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: canvas) else { return }
        // print("Begin drawing at \(touchPoint)")
        // Create a line using pen color and pen lineWidth
        currentLine = Line(beginAt: touchPoint, color: canvas.penColor, thickness: canvas.penLineWidth)
        canvas.theLine = currentLine
        prevPoint = touchPoint
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: canvas) else { return }
        // Append touchpoint to the points of current line
        if let point = prevPoint {
            if (Functions.farEnough(touchPoint, point)) {
                //                print("Drawing at \(touchPoint)")
                currentLine?.points.append(touchPoint)
                canvas.theLine = currentLine
                prevPoint = touchPoint
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // guard let touchPoint = touches.first?.location(in: canvas) else { return }
        // print("End drawing at \(touchPoint)")
        // Append currentline to the lines
        if let newLine = currentLine {
            canvas.lines.append(newLine)
            canvas.theLine = nil
        }
        prevPoint = nil
    }
    
    // Pass values of customColor to the pop-up palette view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        popupViewController = segue.destination as? PalettePopUpViewController
        if let popupVC = popupViewController {
            popupVC.myProtocol = self
            // Get RGB value for custom color
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            customColor.getRed(&r, green: &g, blue: &b, alpha: &a)
            // Set color for the pop-up palette
            popupVC.red = r
            popupVC.green = g
            popupVC.blue = b
        }
    }
}
