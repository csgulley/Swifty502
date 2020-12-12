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
    public static func execute(offset: Int8, memory: Memory, registers: Registers, stack: Stack) -> Int {
        var cycles = 2
        if (shouldBranch(registers: registers)) {
            let previous = registers.pc
            let address = Int(registers.pc) + Int(offset)
            registers.pc = UInt16(address)
            let crossedPageBoundary = (previous & 0xff00) != (registers.pc & 0xff00)
            cycles += (crossedPageBoundary ? 2 : 1)
        }
        return cycles
    }
}
