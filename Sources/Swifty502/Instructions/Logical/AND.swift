//
//  AND.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

fileprivate protocol AndOperator {
    static func cycles() -> Int
}

extension AndOperator {
    public static var mnemonic: String { "AND" }

    static func and(value: UInt8, registers: Registers) -> Int {
        registers.a &= value
        registers.status.updateFlags(registers.a, .Zero, .Negative)
        return cycles()
    }
}

fileprivate protocol ImmediateAnd: AndOperator {
}

extension ImmediateAnd {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) -> Int {
        and(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectAnd: AndOperator {
}

extension IndirectAnd {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        and(value: memory[operand], registers: registers)
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        and(value: memory[operand], registers: registers) + (crossedPageBoundary ? 1 : 0)
    }
}

public struct AND {
    public struct Immediate: ImmediateMode, ImmediateAnd {
        public static var opcode: UInt8 = 0x29
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectAnd {
        public static var opcode: UInt8 = 0x25
        static func cycles() -> Int { 3 }
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectAnd {
        public static var opcode: UInt8 = 0x35
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, IndirectAnd {
        public static var opcode: UInt8 = 0x2d
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectAnd {
        public static var opcode: UInt8 = 0x3d
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectAnd {
        public static var opcode: UInt8 = 0x39
        static func cycles() -> Int { 4 }
    }

    public struct IndirectX: IndirectXMode, IndirectAnd {
        public static var opcode: UInt8 = 0x21
        static func cycles() -> Int { 6 }
    }

    public struct IndirectY: IndirectYMode, IndirectAnd {
        public static var opcode: UInt8 = 0x31
        static func cycles() -> Int { 5 }
    }

}
