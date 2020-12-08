//
//  ASL.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

fileprivate protocol Shifter {
}

extension Shifter {
    public static var mnemonic: String { "ASL" }
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
    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.a = shift(value: registers.a, registers: registers)
    }
}

fileprivate protocol IndirectShifter: Shifter {
}

extension IndirectShifter {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = shift(value: memory[operand], registers: registers)
    }
}

public struct ASL {
    public struct Accumulator: AccumulatorMode, AccumulatorShifter {
        public static var opcode: UInt8 = 0x0a
    }

    public struct ZeroPage: ZeroPageMode, IndirectShifter {
        public static var opcode: UInt8 = 0x06
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectShifter {
        public static var opcode: UInt8 = 0x16
    }

    public struct Absolute: AbsoluteMode, IndirectShifter {
        public static var opcode: UInt8 = 0x0e
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectShifter {
        public static var opcode: UInt8 = 0x1e
    }
}
