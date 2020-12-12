//
//  STY.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol YStoreOperator {
    static func cycles() -> Int
}

extension YStoreOperator {
    public static var mnemonic: String { "STY" }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        memory[operand] = registers.y
        return cycles()
    }
}

public struct STY {
    public struct ZeroPage: ZeroPageMode, YStoreOperator {
        public static var opcode: UInt8 = 0x84
        static func cycles() -> Int { 3 }
    }

    public struct ZeroPageX: ZeroPageXMode, YStoreOperator {
        public static var opcode: UInt8 = 0x94
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, YStoreOperator {
        public static var opcode: UInt8 = 0x8c
        static func cycles() -> Int { 4 }
    }
}
