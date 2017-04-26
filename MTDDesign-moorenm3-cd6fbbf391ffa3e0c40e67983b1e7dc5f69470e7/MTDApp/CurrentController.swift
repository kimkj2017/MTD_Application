//
//  CurrentController.swift
//  MTDApp
//
//  Created by Kim, Kwangju on 4/26/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import UIKit

class CurrentController: UIViewController {
    @IBOutlet weak var curLabel = UILabel()
    
    var textLabel = String()
    
    override func viewDidLoad() {
        curLabel?.text = textLabel
    }
}
