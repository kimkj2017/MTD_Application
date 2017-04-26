//
//  MotorSpeedViewController.swift
//  MTDApp
//
//  Created by Kim, Kwangju on 4/26/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import UIKit

class MotorSpeedViewController: UIViewController {
    
    @IBOutlet weak var speedLabel = UILabel()
    
    var labelText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speedLabel?.text = labelText
    }
    
}
