//
//  MotorTempController.swift
//  MTDApp
//
//  Created by Kim, Kwangju on 4/26/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import UIKit

class MotorTempController: UIViewController {
    @IBOutlet weak var mtLabel = UITextField()
    var taxLabel = String()
    
    @IBOutlet weak var segCtrl = UISegmentedControl()
    
    @IBOutlet weak var Unit: UILabel!
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        print(sender.isMomentary)
        print(sender.selectedSegmentIndex)
        switch (sender.selectedSegmentIndex) {
        case 0:
            mtLabel?.text = taxLabel
            Unit?.text = "°C"
            break
        case 1:
            let fahrenheit = UInt32(taxLabel)
            mtLabel?.text = String(UInt32(32.0 + 1.8 * Double(fahrenheit!)))
            Unit?.text = "°F"
            break
        default:
            mtLabel?.text = "Unexpected error occurred."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mtLabel?.text = taxLabel
        
    }
}
