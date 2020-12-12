//
//  CLC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

public struct CLC: ImpliedMode {
    public static var opcode: UInt8 = 0x18
    public static var mnemonic = "CLC"

    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) -> Int {
        registers.status[.Carry] = false
        return 2
    }
}
