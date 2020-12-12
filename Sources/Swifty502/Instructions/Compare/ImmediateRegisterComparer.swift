//
//  ImmediateRegisterComparer.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

protocol ImmediateRegisterComparer: RegisterComparer {
}

extension ImmediateRegisterComparer {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) -> Int {
        updateFlags(registerValue: getRegisterValue(registers), operand: operand, status: registers.status)
        return cycles()
    }
}
