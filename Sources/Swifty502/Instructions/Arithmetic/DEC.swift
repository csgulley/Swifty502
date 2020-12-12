//
//  DEC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol DecrementOperator {
    static func cycles() -> Int
}

extension DecrementOperator {
    public static var mnemonic: String { "DEC" }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        memory[operand] &-= 1
        registers.status.updateFlags(memory[operand], .Zero, .Negative)
        return cycles()
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        execute(operand: operand, memory: memory, registers: registers, stack: stack)
    }
}

public struct DEC {
    public struct ZeroPage: ZeroPageMode, DecrementOperator {
        public static var opcode: UInt8 = 0xc6
        static func cycles() -> Int { 5 }
    }

    public struct ZeroPageX: ZeroPageXMode, DecrementOperator {
        public static var opcode: UInt8 = 0xd6
        static func cycles() -> Int { 6 }
    }

    public struct Absolute: AbsoluteMode, DecrementOperator {
        public static var opcode: UInt8 = 0xce
        static func cycles() -> Int { 6 }
    }

    public struct AbsoluteX: AbsoluteXMode, DecrementOperator {
        public static var opcode: UInt8 = 0xde
        static func cycles() -> Int { 7 }
    }
}
