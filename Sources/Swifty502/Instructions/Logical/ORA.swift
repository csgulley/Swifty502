//
//  ORA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/26/20.
//

fileprivate protocol OrOperator {
}

extension OrOperator {
    static func and(value: UInt8, registers: Registers) {
        registers.a |= value
        registers.status.updateFlags(registers.a, .Zero, .Negative)
    }
}

fileprivate protocol ImmediateOr: OrOperator {
}

extension ImmediateOr {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        and(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectOr: OrOperator {
}

extension IndirectOr {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        and(value: memory[operand], registers: registers)
    }
}

public struct ORA {
    public struct Immediate: ImmediateMode, ImmediateOr {
        public static var opcode: UInt8 = 0x09
        public static var mnemonic = "AND"
    }

    public struct ZeroPage: ZeroPageMode, IndirectOr {
        public static var opcode: UInt8 = 0x05
        public static var mnemonic = "AND"
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectOr {
        public static var opcode: UInt8 = 0x15
        public static var mnemonic = "AND"
    }

    public struct Absolute: AbsoluteMode, IndirectOr {
        public static var opcode: UInt8 = 0x0d
        public static var mnemonic = "AND"
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectOr {
        public static var opcode: UInt8 = 0x1d
        public static var mnemonic = "AND"
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectOr {
        public static var opcode: UInt8 = 0x19
        public static var mnemonic = "AND"
    }

    public struct IndirectX: IndirectXMode, IndirectOr {
        public static var opcode: UInt8 = 0x01
        public static var mnemonic = "AND"
    }

    public struct IndirectY: IndirectYMode, IndirectOr {
        public static var opcode: UInt8 = 0x11
        public static var mnemonic = "AND"
    }

}
