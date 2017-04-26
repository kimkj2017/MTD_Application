//
//  MowerDataStruct.swift
//  MTDApp
//
//  Created by Kim, Kwangju on 4/26/17.
//  Copyright © 2017 MTDGroup. All rights reserved.
//

import Foundation

struct MowerDataStruct {
    
    var battery1 = arc4random_uniform(100)
    var battery2 = arc4random_uniform(100)
    var motorTemp = arc4random_uniform(999)
    var ctrlTmp = arc4random_uniform(999)
    var hp = arc4random_uniform(999)
    var motorSpeed = arc4random_uniform(999)
    var current = arc4random_uniform(999)
    var savedAmount = arc4random_uniform(999)
    
    
    
}
