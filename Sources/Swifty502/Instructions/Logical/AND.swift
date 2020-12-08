//
//  AND.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

fileprivate protocol AndOperator {
}

extension AndOperator {
    static func and(value: UInt8, registers: Registers) {
        registers.a &= value
        registers.status.updateFlags(registers.a, .Zero, .Negative)
    }
}

fileprivate protocol ImmediateAnd: AndOperator {
}

extension ImmediateAnd {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        and(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectAnd: AndOperator {
}

extension IndirectAnd {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        and(value: memory[operand], registers: registers)
    }
}

public struct AND {
    public struct Immediate: ImmediateMode, ImmediateAnd {
        public static var opcode: UInt8 = 0x29
        public static var mnemonic = "AND"
    }

    public struct ZeroPage: ZeroPageMode, IndirectAnd {
        public static var opcode: UInt8 = 0x25
        public static var mnemonic = "AND"
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectAnd {
        public static var opcode: UInt8 = 0x35
        public static var mnemonic = "AND"
    }

    public struct Absolute: AbsoluteMode, IndirectAnd {
        public static var opcode: UInt8 = 0x2d
        public static var mnemonic = "AND"
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectAnd {
        public static var opcode: UInt8 = 0x3d
        public static var mnemonic = "AND"
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectAnd {
        public static var opcode: UInt8 = 0x39
        public static var mnemonic = "AND"
    }

    public struct IndirectX: IndirectXMode, IndirectAnd {
        public static var opcode: UInt8 = 0x21
        public static var mnemonic = "AND"
    }

    public struct IndirectY: IndirectYMode, IndirectAnd {
        public static var opcode: UInt8 = 0x31
        public static var mnemonic = "AND"
    }

}
