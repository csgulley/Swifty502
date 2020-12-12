//
//  LDA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol AStoreOperator {
    static func cycles() -> Int
}

extension AStoreOperator {
    public static var mnemonic: String { "STA" }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        memory[operand] = registers.a
        return cycles()
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}

public struct STA {
    public struct ZeroPage: ZeroPageMode, AStoreOperator {
        public static var opcode: UInt8 = 0x85
        static func cycles() -> Int { 3 }
    }

    public struct ZeroPageX: ZeroPageXMode, AStoreOperator {
        public static var opcode: UInt8 = 0x95
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, AStoreOperator {
        public static var opcode: UInt8 = 0x8d
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteX: AbsoluteXMode, AStoreOperator {
        public static var opcode: UInt8 = 0x9d
        static func cycles() -> Int { 5 }
    }

    public struct AbsoluteY: AbsoluteYMode, AStoreOperator {
        public static var opcode: UInt8 = 0x99
        static func cycles() -> Int { 5 }
    }

    public struct IndirectX: IndirectXMode, AStoreOperator {
        public static var opcode: UInt8 = 0x81
        static func cycles() -> Int { 6 }
    }

    public struct IndirectY: IndirectYMode, AStoreOperator {
        public static var opcode: UInt8 = 0x91
        static func cycles() -> Int { 6 }
    }
}
