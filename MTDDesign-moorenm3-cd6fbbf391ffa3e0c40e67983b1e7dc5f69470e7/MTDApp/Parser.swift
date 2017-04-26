//
//  Parser.swift
//  MTDApp
//
//  Created by Sheffield, Gianna Marie Ms. on 4/25/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import Foundation

struct valueStruct {
    var alarmCode: Int
    var current: Int
    var voltage1: Int
    var voltage2: Int
    var motorTemp: Int
    var controlTemp: Int
    var motorSpeed: Int
    
    init(alarmCode: Int, current: Int, voltage1: Int, voltage2: Int, motorTemp: Int, controlTemp: Int, motorSpeed: Int) {
        self.alarmCode = alarmCode
        self.current = current
        self.voltage1 = voltage1
        self.voltage2 = voltage2
        self.motorTemp = motorTemp
        self.controlTemp = controlTemp
        self.motorSpeed = motorSpeed
        
        print("Alarm Code: \(alarmCode)\nCurrent: \(current)\nVoltage1: \(voltage1)\nVoltage2: \(voltage2)\n")
    }
    
}


func parse(data: String) -> valueStruct {
    let dataString = data
    let dataParsed = dataString.components(separatedBy: ",")
    
    //let acHex = UInt8(strtoul(dataParsed[1], nil, 16))
    //print(acHex)
    
    let ac = Int(dataParsed[1], radix: 16)
    let cur = Int(dataParsed[3], radix: 16)
    let v1 = Int(dataParsed[4], radix: 16)
    let v2 = Int(dataParsed[5], radix: 16)
    let mt = Int(dataParsed[13], radix: 16)
    let ct = Int(dataParsed[14], radix: 16)
    let ms = Int(dataParsed[18], radix: 16)
    let values = valueStruct(alarmCode: ac!, current: cur!, voltage1: v1!, voltage2: v2!, motorTemp: mt!, controlTemp: ct!, motorSpeed: ms!)
    return values
}





//var data = parse(data: "#0,00000,0000,0000,0000,0000,0,000,000,00,00,000,000,000,000,000,000,00000,00000,0000,0,0,00,0000,00000,0\n")

