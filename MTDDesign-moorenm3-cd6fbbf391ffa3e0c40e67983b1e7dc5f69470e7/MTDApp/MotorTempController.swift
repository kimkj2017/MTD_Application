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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mtLabel?.text = taxLabel
    }
}
