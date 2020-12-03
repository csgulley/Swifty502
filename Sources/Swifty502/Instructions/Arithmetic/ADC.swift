//
//  ADC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/28/20.
//

fileprivate protocol AdcOperator {
}

extension AdcOperator {
    static var mnemonic: String {
        "ADC"
    }

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
    static func execute(operand: UInt8, memory: Memory, registers: Registers, stack: Stack) {
        add(value: operand, registers: registers)
    }
}

fileprivate protocol IndirectAdd: AdcOperator {
}

extension IndirectAdd {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        add(value: memory[operand], registers: registers)
    }
}

struct ADC {
    struct Immediate: ImmediateMode, ImmediateAdd {
        static var opcode: UInt8 = 0x69
    }

    struct ZeroPage: ZeroPageMode, IndirectAdd {
        static var opcode: UInt8 = 0x65
    }

    struct ZeroPageX: ZeroPageXMode, IndirectAdd {
        static var opcode: UInt8 = 0x75
    }

    struct Absolute: AbsoluteMode, IndirectAdd {
        static var opcode: UInt8 = 0x6d
    }

    struct AbsoluteX: AbsoluteXMode, IndirectAdd {
        static var opcode: UInt8 = 0x7d
    }

    struct AbsoluteY: AbsoluteYMode, IndirectAdd {
        static var opcode: UInt8 = 0x79
    }

    struct IndirectX: IndirectXMode, IndirectAdd {
        static var opcode: UInt8 = 0x61
    }

    struct IndirectY: IndirectYMode, IndirectAdd {
        static var opcode: UInt8 = 0x71
    }
}

