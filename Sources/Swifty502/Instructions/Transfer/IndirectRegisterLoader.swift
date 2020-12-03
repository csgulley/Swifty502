//
//  IndirectRegisterLoader.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

protocol IndirectRegisterLoader: RegisterLoader {
}

extension IndirectRegisterLoader {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        let value = memory[operand]
        setValue(value: value, registers: registers)
        updateFlags(value: value, status: registers.status)
    }
}
