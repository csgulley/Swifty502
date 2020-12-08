//
//  ImmediateRegisterLoader.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

protocol ImmediateRegisterLoader: RegisterLoader {
}

extension ImmediateRegisterLoader {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        setValue(value: operand, registers: registers)
        updateFlags(value: operand, status: registers.status)
    }
}
