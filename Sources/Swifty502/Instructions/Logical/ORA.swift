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
    static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        and(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectOr: OrOperator {
}

extension IndirectOr {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        and(value: memory[operand], registers: registers)
    }
}

struct ORA {
    struct Immediate: ImmediateMode, ImmediateOr {
        static var opcode: UInt8 = 0x09
        static var mnemonic = "AND"
    }

    struct ZeroPage: ZeroPageMode, IndirectOr {
        static var opcode: UInt8 = 0x05
        static var mnemonic = "AND"
    }

    struct ZeroPageX: ZeroPageXMode, IndirectOr {
        static var opcode: UInt8 = 0x15
        static var mnemonic = "AND"
    }

    struct Absolute: AbsoluteMode, IndirectOr {
        static var opcode: UInt8 = 0x0d
        static var mnemonic = "AND"
    }

    struct AbsoluteX: AbsoluteXMode, IndirectOr {
        static var opcode: UInt8 = 0x1d
        static var mnemonic = "AND"
    }

    struct AbsoluteY: AbsoluteYMode, IndirectOr {
        static var opcode: UInt8 = 0x19
        static var mnemonic = "AND"
    }

    struct IndirectX: IndirectXMode, IndirectOr {
        static var opcode: UInt8 = 0x01
        static var mnemonic = "AND"
    }

    struct IndirectY: IndirectYMode, IndirectOr {
        static var opcode: UInt8 = 0x11
        static var mnemonic = "AND"
    }

}
