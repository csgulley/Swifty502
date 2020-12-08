//
//  RTI.swift
//  Swifty502
//
//  Created by Chris Gulley on 12/1/20.
//

public struct RTI: ImpliedMode {
    public static var opcode: UInt8 = 0x40
    public static var mnemonic = "RTI"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.status.statusByte = stack.popByte()
        registers.pc = stack.popWord()
    }
}
