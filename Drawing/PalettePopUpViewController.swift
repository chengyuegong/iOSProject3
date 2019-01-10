//
//  PalettePopUpViewController.swift
//  Drawing
//
//  Created by Chengyue Gong on 2019/1/10.
//  Copyright © 2019 Chengyue Gong. All rights reserved.
//

import UIKit

protocol PassColorProtocol {
    func setColor(color: UIColor)
}

class PalettePopUpViewController: UIViewController {
    
    // RGB value labels
    @IBOutlet weak var rValue: UILabel!
    @IBOutlet weak var gValue: UILabel!
    @IBOutlet weak var bValue: UILabel!
    // RGB value
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    // Showing color and RGB hex value
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorHex: UILabel!
    // Current color
    var color: UIColor?
    
    // For passing value to the main view
    var myProtocol: PassColorProtocol?
    
    // RGB sliders
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    
    // update slider value
    func updateSlider() {
        rSlider.value = Float(red)
        gSlider.value = Float(green)
        bSlider.value = Float(blue)
    }
    
    // update color, hex value and label value based on (red, green, blue)
    func update() {
        color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        colorLabel.backgroundColor = color
        colorHex.text = "#" + String(format: "%02X%02X%02X", Int(red*255), Int(green*255), Int(blue*255))
        rValue.text = String(Int(red*255))
        gValue.text = String(Int(green*255))
        bValue.text = String(Int(blue*255))
    }
    
    // Functions for the three sliders
    @IBAction func changeR(_ sender: UISlider) {
        red = CGFloat(sender.value)
        update()
    }
    
    @IBAction func changeG(_ sender: UISlider) {
        green = CGFloat(sender.value)
        update()
    }
    
    @IBAction func changeB(_ sender: UISlider) {
        blue = CGFloat(sender.value)
        update()
    }
    
    // Pass color to the main view
    @IBAction func ok(_ sender: UIButton) {
        dismiss(animated: true, completion: {
            if let ptcl = self.myProtocol, let color = self.color {
                ptcl.setColor(color: color)
            }
        })
    }
    
    // Do nothing
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        update()
        updateSlider()
    }
    
}
