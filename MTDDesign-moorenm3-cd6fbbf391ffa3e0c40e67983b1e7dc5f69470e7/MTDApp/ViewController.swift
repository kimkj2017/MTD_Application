//
//  ViewController.swift
//  MTDApp
//
//  Created by Brown, Drew J. on 10/30/16.
//  Copyright © 2016 MTDGroup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var simpleBluetoothIO: SimpleBluetoothIO!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleBluetoothIO = SimpleBluetoothIO(serviceUUID: "6E400003-B5A3-F393-­E0A9-­E50E24DCCA9E", delegate: self)
    }
    
//    @IBAction func ledToggleButtonDown(_ sender: UIButton) {
//        simpleBluetoothIO.writeValue(value: 1)
//    }
    
//    @IBAction func ledToggleButtonUp(_ sender: UIButton) {
//        simpleBluetoothIO.writeValue(value: 0)
//    }

    
    /*
    // Swifty friend advised to comment this out
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */


}

extension ViewController: SimpleBluetoothIODelegate {
    func simpleBluetoothIO(simpleBluetoothIO: SimpleBluetoothIO, didReceiveValue value: Int8) {
        
        // What we want to do with the data
        if value > 0 {
            view.backgroundColor = UIColor.yellow
        } else {
            view.backgroundColor = UIColor.black
        }
    }
}
