//
//  PHP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

public struct PHP: ImpliedMode {
    public static var opcode: UInt8 = 0x08
    public static var mnemonic = "PHP"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        stack.pushByte(registers.status.statusByte)
        return 3
    }
}
