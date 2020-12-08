//
//  IndirectRegisterComparer.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

protocol IndirectRegisterComparer: RegisterComparer {
}

extension IndirectRegisterComparer {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        let value = memory[operand]
        updateFlags(registerValue: getRegisterValue(registers), operand: value, status: registers.status)
    }
}
