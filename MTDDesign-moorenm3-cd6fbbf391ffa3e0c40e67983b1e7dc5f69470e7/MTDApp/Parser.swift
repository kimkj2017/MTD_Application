//
//  Parser.swift
//  MTDApp
//
//  Created by Sheffield, Gianna Marie Ms. on 4/25/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//


func parse(data: String) {
    // Separate string by the commas
    let dataParsed = data.components(separatedBy: ",")
    
    print(data)
    
    // Check that the device is connected to a lawn mower
    if dataParsed[0] == "#4" {
        var ac = 0
        if let a = Int(dataParsed[1]) {
            ac = a
        }

        // Current 1 / 100
        var cur = 0.0
        if let c = Double(dataParsed[3]) {
            cur = c / 100
        }
        
        // Voltage 1 / 100
        var v1 = 0.0
        if let v = Double(dataParsed[5]) {
            v1 = v / 100
        }
    
        // Voltage 2 / 100
        var v2 = 0.0
        if let v = Double(dataParsed[6]) {
            v2 = v / 100
        }
    
        // Motor Temp / 11.5
        var mt = 0.0
        if let m = Double(dataParsed[14]) {
            mt = m / 11.5
        }
        
        // Control Temp / 11.5
        var ct = 0.0
        if let c = Double(dataParsed[15]) {
            ct = c / 11.5
        }
        
        var ms = 0
        if let m = Int(dataParsed[19]) {
            ms = m
        }
    
        print("Alarm Code: \(String(describing: ac))\nCurrent: \(String(describing: cur))\nVoltage1: \(String(describing: v1))\nVoltage2: \(String(describing: v2))\nMotorTemp: \(String(describing: mt))\nControlTemp: \(String(describing: ct))\nMotorSpeed: \(String(describing: ms))\n")
    }
}
