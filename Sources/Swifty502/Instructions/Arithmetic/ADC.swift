//
//  ADC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

fileprivate protocol AdcOperator {
}

extension AdcOperator {
    public static var mnemonic: String { "ADC" }

    static func add(value: UInt8, registers: Registers) {
        if (registers.status[.Decimal]) {
            AddOperator.decimalAdd(value: value, registers: registers)
        } else {
            AddOperator.binaryAdd(value: value, registers: registers)
        }
    }
}

fileprivate protocol ImmediateAdd: AdcOperator {
}

extension ImmediateAdd {
    public static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        add(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectAdd: AdcOperator {
}

extension IndirectAdd {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        add(value: memory[operand], registers: registers)
    }
}

public struct ADC {
    public struct Immediate: ImmediateMode, ImmediateAdd {
        public static var opcode: UInt8 = 0x69
    }

    public struct ZeroPage: ZeroPageMode, IndirectAdd {
        public static var opcode: UInt8 = 0x65
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectAdd {
        public static var opcode: UInt8 = 0x75
    }

    public struct Absolute: AbsoluteMode, IndirectAdd {
        public static var opcode: UInt8 = 0x6d
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectAdd {
        public static var opcode: UInt8 = 0x7d
    }

    public struct AbsoluteY: AbsoluteYMode, IndirectAdd {
        public static var opcode: UInt8 = 0x79
    }

    public struct IndirectX: IndirectXMode, IndirectAdd {
        public static var opcode: UInt8 = 0x61
    }

    public struct IndirectY: IndirectYMode, IndirectAdd {
        public static var opcode: UInt8 = 0x71
    }
}

