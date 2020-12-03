//
//  RegisterComparer.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

protocol RegisterComparer {
    static func getRegisterValue(_ registers: Registers) -> UInt8
}

extension RegisterComparer {
    static func updateFlags(registerValue: UInt8, operand: UInt8, status: StatusRegister) {
        status[.Zero] = registerValue == operand
        status[.Carry] = registerValue >= operand
        status[.Negative] = ((registerValue &- operand) & 0x80) > 0
    }
}

