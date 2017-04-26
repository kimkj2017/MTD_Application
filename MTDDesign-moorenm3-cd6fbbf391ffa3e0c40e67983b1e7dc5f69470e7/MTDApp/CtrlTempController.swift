//
//  CtrlTempController.swift
//  MTDApp
//
//  Created by Kim, Kwangju on 4/26/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import UIKit

class CtrlTempController: UIViewController {
    @IBOutlet weak var ctrlLabel = UITextField()
    var textField = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ctrlLabel?.text = textField
    }
}
