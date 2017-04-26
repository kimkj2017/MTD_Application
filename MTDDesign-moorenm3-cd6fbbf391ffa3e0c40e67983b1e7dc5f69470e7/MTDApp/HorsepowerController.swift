//
//  HorsepowerController.swift
//  MTDApp
//
//  Created by Kim, Kwangju on 4/26/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import UIKit

class HorsepowerController: UIViewController {
    @IBOutlet weak var hpLabel = UILabel()
    
    var textLabel = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hpLabel?.text = textLabel
    }
}
