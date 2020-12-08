//
//  Registers.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

final public class Registers {
    var pc: UInt16 = 0
    var a: UInt8 = 0
    var x: UInt8 = 0
    var y: UInt8 = 0
    var sp: UInt8 = 0
    var status = StatusRegister()
}
