//
//  PHA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

public struct PHA: ImpliedMode {
    public static var opcode: UInt8 = 0x48
    public static var mnemonic = "PHA"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        stack.pushByte(registers.a)
        return 3
    }
}
