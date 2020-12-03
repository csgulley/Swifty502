//
//  RegisterLoader.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

protocol RegisterLoader {
    static func setValue(value: UInt8, registers: Registers)
}

extension RegisterLoader {
    static func updateFlags(value: UInt8, status: StatusRegister) {
        status.updateFlags(value, .Zero, .Negative)
    }
}
