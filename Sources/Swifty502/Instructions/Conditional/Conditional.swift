//
//  Conditional.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

protocol Conditional {
    static func shouldBranch(registers: Registers) -> Bool
}

extension Conditional {
    public static func execute(offset: Int8, memory: Memory, registers: Registers, stack: Stack) {
        if (shouldBranch(registers: registers)) {
            let address = Int(registers.pc) + Int(offset)
            registers.pc = UInt16(address)
        }
    }
}
