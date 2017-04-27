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
    
    private var battery1: Double
    private var battery2: Double
    private var motorTemp: Int
    private var ctrlTemp: Int
    private var hp: Int
    private var motorSpeed: Int
    private var current: Int
    private var saved: Int
    private var alarmcd: Int
    
    public init() {
        self.battery1 = 0
        self.battery2 = 0
        self.motorTemp = 0
        self.ctrlTemp = 0
        self.hp = 0
        self.motorSpeed = 0
        self.current = 0
        self.saved = 0
        self.alarmcd = 0
    }
    
    public init(battery1: Double, battery2: Double,
                 motorTemp: Int, ctrlTemp: Int,
                 hp: Int, motorSpeed: Int, current: Int,
                 saved: Int, alarmcd: Int) {
        self.battery1 = battery1
        self.battery2 = battery2
        self.motorTemp = motorTemp
        self.ctrlTemp = ctrlTemp
        self.hp = hp
        self.motorSpeed = motorSpeed
        self.current = current
        self.saved = saved
        self.alarmcd = alarmcd
    }
    
    private static var instance: MowerDataObject? = nil
    
    /*public static func getInstance() -> MowerDataObject {
        if (instance == nil) {
            let rTestVar = arc4random_uniform(5)
            switch (rTestVar) {
            case 0:
                self.instance = MowerDataObject(battery1: Int(SampleData1[0]),
                                                battery2: Int(SampleData1[1]),
                                                motorTemp: Int(SampleData1[2]),
                                                ctrlTemp: Int(SampleData1[3]),
                                                hp: Int(SampleData1[4]),
                                                motorSpeed: Int(SampleData1[5]),
                                                current: Int(SampleData1[6]),
                                                saved: Double(SampleData1[7]))
                break
            case 1:
                self.instance = MowerDataObject(battery1: Int(SampleData2[0]),
                                                battery2: Int(SampleData2[1]),
                                                motorTemp: Int(SampleData2[2]),
                                                ctrlTemp: Int(SampleData2[3]),
                                                hp: Int(SampleData2[4]),
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
    }*/
    
    public func recvData(battery1: Double, battery2: Double,
        motorTemp: Int, ctrlTemp: Int,
        hp: Int, motorSpeed: Int, current: Int,
        saved: Int, alaramcd: Int) {
        self.battery1 = battery1
        self.battery2 = battery2
        self.motorTemp = motorTemp
        self.ctrlTemp = ctrlTemp
        self.hp = hp
        self.motorSpeed = motorSpeed
        self.current = current
        self.saved = saved
    }
    
    /* Getters */
    
    public func getBatteryOne() -> Double {
        return self.battery1
    }
    
    public func getBatteryTwo() -> Double {
        return self.battery2
    }
    
    public func getMotorTemp() -> Int {
        return self.motorTemp
    }
    
    public func getCtrlTemp() -> Int {
        return self.ctrlTemp
    }
    
    public static func getFahrenheitTemperature(tmp: Int) -> Int {
        let newTmp: Double = Double(tmp) * 1.8 + 32.0
        return Int(newTmp)
    }
    
    public func getHP() -> Double {
        let hp = (self.battery1 * Double(self.current)) / 746.0

        let dbhp = String(format: "%.2f", hp)
        return Double(dbhp)!
    }
    
    public func getHPInWatt() -> Double {
        let hp = (self.battery1 * Double(self.current))
        let dbhp = String(format: "%.1f", hp)
        return Double(dbhp)!
    }
    
    public func getMotorSpeed() -> Int {
        return self.motorSpeed
    }
    
    public func getCurrent() -> Int {
        return self.current
    }
    
    public func getSaved() -> Int {
        return self.saved
    }
    public func getAlarmCode() -> Int {
        return self.alarmcd
    }
    
    
    /* Setters */
    
    public func setBatteryOne(bat1: Double)  {
        self.battery1 = bat1
    }
    
    public func setBatteryTwo(bat2: Double) {
        self.battery2 = bat2
    }
    
    public func setMotorTemp(mt: Int) {
        self.motorTemp = mt
    }
    
    public func setCtrlTemp(ct: Int) {
        self.ctrlTemp = ct
    }
    
    public func setMotorSpeed(ms: Int) {
        self.motorSpeed = ms
    }
    
    public func setCurrent(cur: Int) {
        self.current = cur
    }
    
    public func setAlarmCode(ac: Int) {
        self.alarmcd = ac
    }
}
