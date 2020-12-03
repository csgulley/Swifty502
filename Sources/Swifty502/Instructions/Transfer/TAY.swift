//
//  TAY.swift
//  Swifty502
//
//  Created by Casey McGuire on 11/24/20.
//

struct TAY: ImpliedMode {
    static var opcode: UInt8 = 0xa8
    static var mnemonic = "TAY"

    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.y = registers.a
        registers.status.updateFlags(registers.y, .Zero, .Negative)
    }
}
