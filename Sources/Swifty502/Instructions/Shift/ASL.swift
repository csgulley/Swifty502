//
//  ASL.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

fileprivate protocol Shifter {
}

extension Shifter {
    static func shift(value: UInt8, registers: Registers) -> UInt8 {
        registers.status[.Carry] = (value & 0x80) > 0
        let shifted = value << 1
        registers.status.updateFlags(shifted, .Zero, .Negative)
        return shifted
    }
}

fileprivate protocol AccumulatorShifter: Shifter {
}

extension AccumulatorShifter {
    static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.a = shift(value: registers.a, registers: registers)
    }
}

fileprivate protocol IndirectShifter: Shifter {
}

extension IndirectShifter {
    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = shift(value: memory[operand], registers: registers)
    }
}

struct ASL {
    struct Accumulator: AccumulatorMode, AccumulatorShifter {
        static var opcode: UInt8 = 0x0a
        static var mnemonic = "ASL"
    }

    struct ZeroPage: ZeroPageMode, IndirectShifter {
        static var opcode: UInt8 = 0x06
        static var mnemonic = "ASL"
    }

    struct ZeroPageX: ZeroPageXMode, IndirectShifter {
        static var opcode: UInt8 = 0x16
        static var mnemonic = "ASL"
    }

    struct Absolute: AbsoluteMode, IndirectShifter {
        static var opcode: UInt8 = 0x0e
        static var mnemonic = "ASL"
    }

    struct AbsoluteX: AbsoluteXMode, IndirectShifter {
        static var opcode: UInt8 = 0x1e
        static var mnemonic = "ASL"
    }
}
