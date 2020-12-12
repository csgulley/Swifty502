//
//  RTS.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

public struct RTS: ImpliedMode {
    public static var opcode: UInt8 = 0x60
    public static var mnemonic = "RTS"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        let address = stack.popWord()
        registers.pc = address + 1
        return 6
    }
}
