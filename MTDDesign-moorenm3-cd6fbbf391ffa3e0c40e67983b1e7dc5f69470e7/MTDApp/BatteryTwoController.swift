//
//  BatteryTwoController.swift
//  MTDApp
//
//  Created by Kim, Kwangju on 4/26/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import UIKit

class BatteryTwoController: UIViewController {
    @IBOutlet weak var batteryButton = UIButton()
    var color_ = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        batteryButton?.backgroundColor = color_
    }
}
