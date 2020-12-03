//
//  SBC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

fileprivate protocol SubtractOperator {
}

extension SubtractOperator {
    static var mnemonic: String {
        "SBC"
    }

    static func subtract(value: UInt8, registers: Registers) {
        if (registers.status[.Decimal]) {
            AddOperator.decimalSubtract(value: value, registers: registers)
        } else {
            AddOperator.binarySubtract(value: value, registers: registers)
        }
    }
}

fileprivate protocol ImmediateSubtract: SubtractOperator {
}

extension ImmediateSubtract {
    static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        subtract(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectSubtract: SubtractOperator {
}

extension IndirectSubtract {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        subtract(value: memory[operand], registers: registers)
    }
}

struct SBC {
    struct Immediate: ImmediateMode, ImmediateSubtract {
        static var opcode: UInt8 = 0xe9
    }

    struct ZeroPage: ZeroPageMode, IndirectSubtract {
        static var opcode: UInt8 = 0xe5
    }

    struct ZeroPageX: ZeroPageXMode, IndirectSubtract {
        static var opcode: UInt8 = 0xf5
    }

    struct Absolute: AbsoluteMode, IndirectSubtract {
        static var opcode: UInt8 = 0xed
    }

    struct AbsoluteX: AbsoluteXMode, IndirectSubtract {
        static var opcode: UInt8 = 0xfd
    }

    struct AbsoluteY: AbsoluteYMode, IndirectSubtract {
        static var opcode: UInt8 = 0xf9
    }

    struct IndirectX: IndirectXMode, IndirectSubtract {
        static var opcode: UInt8 = 0xe1
    }

    struct IndirectY: IndirectYMode, IndirectSubtract {
        static var opcode: UInt8 = 0xf1
    }
}

