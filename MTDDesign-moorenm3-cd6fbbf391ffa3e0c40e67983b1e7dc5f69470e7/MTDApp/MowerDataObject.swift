//
//  MowerDataObject.swift
//  MTDApp
//
//  Created by Kim, Kwangju on 4/26/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import Foundation

class MowerDataObject {
    
    static let SampleData1 = [1,1,1,1,1,1,1,1.01]
    static let SampleData2 = [99,37,4,2,55,36,245,24.24]
    static let SampleData3 = [35,79,62,34,16,47,24,35.10]
    static let SampleData4 = [99,99,99,99,99,99,99,99.99]
    static let RandomData = [arc4random_uniform(100),arc4random_uniform(100),
                             arc4random_uniform(100),arc4random_uniform(100),
                             arc4random_uniform(100),arc4random_uniform(100),
                             arc4random_uniform(100),arc4random_uniform(100)]
    
    private var battery1: UInt32
    private var battery2: UInt32
    private var motorTemp: UInt32
    private var ctrlTemp: UInt32
    private var hp: UInt32
    private var motorSpeed: UInt32
    private var current: UInt32
    private var saved: Double
    
    private init(battery1: UInt32, battery2: UInt32,
                 motorTemp: UInt32, ctrlTemp: UInt32,
                 hp: UInt32, motorSpeed: UInt32, current: UInt32,
                 saved: Double) {
        self.battery1 = battery1
        self.battery2 = battery2
        self.motorTemp = motorTemp
        self.ctrlTemp = ctrlTemp
        self.hp = hp
        self.motorSpeed = motorSpeed
        self.current = current
        self.saved = saved
    }
    
    private static var instance: MowerDataObject? = nil
    
    public static func getInstance() -> MowerDataObject {
        if (instance == nil) {
            let rTestVar = arc4random_uniform(5)
            switch (rTestVar) {
            case 0:
                self.instance = MowerDataObject(battery1: UInt32(SampleData1[0]),
                                                battery2: UInt32(SampleData1[1]),
                                                motorTemp: UInt32(SampleData1[2]),
                                                ctrlTemp: UInt32(SampleData1[3]),
                                                hp: UInt32(SampleData1[4]),
                                                motorSpeed: UInt32(SampleData1[5]),
                                                current: UInt32(SampleData1[6]),
                                                saved: Double(SampleData1[7]))
                break
            case 1:
                self.instance = MowerDataObject(battery1: UInt32(SampleData2[0]),
                                                battery2: UInt32(SampleData2[1]),
                                                motorTemp: UInt32(SampleData2[2]),
                                                ctrlTemp: UInt32(SampleData2[3]),
                                                hp: UInt32(SampleData2[4]),
                                                motorSpeed: UInt32(SampleData2[5]),
                                                current: UInt32(SampleData2[6]),
                                                saved: Double(SampleData2[7]))
                break
            case 2:
                self.instance = MowerDataObject(battery1: UInt32(SampleData3[0]),
                                                battery2: UInt32(SampleData3[1]),
                                                motorTemp: UInt32(SampleData3[2]),
                                                ctrlTemp: UInt32(SampleData3[3]),
                                                hp: UInt32(SampleData3[4]),
                                                motorSpeed: UInt32(SampleData3[5]),
                                                current: UInt32(SampleData3[6]),
                                                saved: Double(SampleData3[7]))
                break
            case 3:
                self.instance = MowerDataObject(battery1: UInt32(SampleData4[0]),
                                                battery2: UInt32(SampleData4[1]),
                                                motorTemp: UInt32(SampleData4[2]),
                                                ctrlTemp: UInt32(SampleData4[3]),
                                                hp: UInt32(SampleData4[4]),
                                                motorSpeed: UInt32(SampleData4[5]),
                                                current: UInt32(SampleData4[6]),
                                                saved: Double(SampleData4[7]))
                break
            default:
                self.instance = MowerDataObject(battery1: UInt32(RandomData[0]),
                                                battery2: UInt32(RandomData[1]),
                                                motorTemp: UInt32(RandomData[2]),
                                                ctrlTemp: UInt32(RandomData[3]),
                                                hp: UInt32(RandomData[4]),
                                                motorSpeed: UInt32(RandomData[5]),
                                                current: UInt32(RandomData[6]),
                                                saved: Double(RandomData[7]))
            }
        }
        return self.instance!
    }
    
    public func recvData(battery1: UInt32, battery2: UInt32,
        motorTemp: UInt32, ctrlTemp: UInt32,
        hp: UInt32, motorSpeed: UInt32, current: UInt32,
        saved: Double) {
        self.battery1 = battery1
        self.battery2 = battery2
        self.motorTemp = motorTemp
        self.ctrlTemp = ctrlTemp
        self.hp = hp
        self.motorSpeed = motorSpeed
        self.current = current
        self.saved = saved
    }
    
    public func getBatteryOne() -> UInt32 {
        return self.battery1
    }
    
    public func getBatteryTwo() -> UInt32 {
        return self.battery2
    }
    
    public func getMotorTemp() -> UInt32 {
        return self.motorTemp
    }
    
    public func getCtrlTemp() -> UInt32 {
        return self.ctrlTemp
    }
    
    public static func getFahrenheitTemperature(tmp: UInt32) -> UInt32 {
        let newTmp: Double = Double(tmp) * 1.8 + 32.0
        return UInt32(newTmp)
    }
    
    public func getHP() -> UInt32 {
        return self.hp
    }
    
    public func getHPInWatt() -> UInt32 {
        return UInt32(745.699872 * Double(self.hp))
    }
    
    public func getMotorSpeed() -> UInt32 {
        return self.motorSpeed
    }
    
    public func getCurrent() -> UInt32 {
        return self.current
    }
    
    public func getSaved() -> Double {
        return self.saved
    }
}
