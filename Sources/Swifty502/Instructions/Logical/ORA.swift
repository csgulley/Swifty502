//
//  ORA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/26/20.
//

fileprivate protocol OrOperator {
    static func cycles() -> Int
}

extension OrOperator {
    public static var mnemonic: String { "ORA" }

    static func or(value: UInt8, registers: Registers) -> Int {
        registers.a |= value
        registers.status.updateFlags(registers.a, .Zero, .Negative)
        return cycles()
    }
}

fileprivate protocol ImmediateOr: OrOperator {
}

extension ImmediateOr {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) -> Int {
        or(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectOr: OrOperator {
}

extension IndirectOr {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) -> Int {
        or(value: memory[operand], registers: registers)
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack, crossedPageBoundary: Bool) -> Int {
        or(value: memory[operand], registers: registers) + (crossedPageBoundary ? 1 : 0)
    }
}

public struct ORA {
    public struct Immediate: ImmediateMode, ImmediateOr {
        public static var opcode: UInt8 = 0x09
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectOr {
        public static var opcode: UInt8 = 0x05
        static func cycles() -> Int { 3 }
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectOr {
        public static var opcode: UInt8 = 0x15
        static func cycles() -> Int { 4 }
    }

    public struct Absolute: AbsoluteMode, IndirectOr {
        public static var opcode: UInt8 = 0x0d
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectOr {
        public static var opcode: UInt8 = 0x1d
        static func cycles() -> Int { 4 }
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectOr {
        public static var opcode: UInt8 = 0x19
        static func cycles() -> Int { 4 }
    }

    public struct IndirectX: IndirectXMode, IndirectOr {
        public static var opcode: UInt8 = 0x01
        static func cycles() -> Int { 6 }
    }

    public struct IndirectY: IndirectYMode, IndirectOr {
        public static var opcode: UInt8 = 0x11
        static func cycles() -> Int { 5 }
    }

}
