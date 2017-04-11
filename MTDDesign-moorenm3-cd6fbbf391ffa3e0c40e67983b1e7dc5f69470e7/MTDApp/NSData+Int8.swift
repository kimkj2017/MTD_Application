//
//  NSData+Int8.swift
//  MTDApp
//
//  Created by Sheffield, Gianna Marie Ms. on 4/11/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import Foundation

extension Data {
    static func dataWithValue(value: Int8) -> Data {
        var variableValue = value
        return Data(buffer: UnsafeBufferPointer(start: &variableValue, count: 1))
    }
    
    func int8Value() -> Int8 {
        return Int8(bitPattern: self[0])
    }
}
