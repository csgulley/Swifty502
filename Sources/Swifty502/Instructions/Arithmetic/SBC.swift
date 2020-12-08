//
//  SBC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

fileprivate protocol SubtractOperator {
}

extension SubtractOperator {
    public static var mnemonic: String {
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
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        subtract(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectSubtract: SubtractOperator {
}

extension IndirectSubtract {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        subtract(value: memory[operand], registers: registers)
    }
}

public struct SBC {
    public struct Immediate: ImmediateMode, ImmediateSubtract {
        public static var opcode: UInt8 = 0xe9
    }

    public struct ZeroPage: ZeroPageMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xe5
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xf5
    }

    public struct Absolute: AbsoluteMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xed
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xfd
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xf9
    }

    public struct IndirectX: IndirectXMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xe1
    }

    public struct IndirectY: IndirectYMode, IndirectSubtract {
        public static var opcode: UInt8 = 0xf1
    }
}

