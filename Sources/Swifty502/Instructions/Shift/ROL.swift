//
//  ROL.swift
//  Swifty502
//
//  Created by Chris Gulley on 12/1/20.
//

fileprivate protocol RotateOperation {
}

extension RotateOperation {
    static func shift(value: UInt8, registers: Registers) -> UInt8 {
        let carryBitmask: UInt8 = registers.status[.Carry] ? 0x01 : 0x00
        registers.status[.Carry] = (value & 0x80) > 0
        let shifted = (value << 1) | carryBitmask
        registers.status.updateFlags(shifted, .Zero, .Negative)
        return shifted
    }

    public static var mnemonic: String {
        "ROL"
    }
}

fileprivate protocol AccumulatorRotate: RotateOperation {
}

extension AccumulatorRotate {
    public static func execute(memory: Memory, registers: Registers, stack: Stack, executor: Executor) {
        registers.a = shift(value: registers.a, registers: registers)
    }
}

fileprivate protocol IndirectRotate: RotateOperation {
}

extension IndirectRotate {
    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] = shift(value: memory[operand], registers: registers)
    }
}

public struct ROL {
    public struct Accumulator: AccumulatorMode, AccumulatorRotate {
        public static var opcode: UInt8 = 0x2a
    }

    public struct ZeroPage: ZeroPageMode, IndirectRotate {
        public static var opcode: UInt8 = 0x26
    }

    public struct ZeroPageX: ZeroPageXMode, IndirectRotate {
        public static var opcode: UInt8 = 0x36
    }

    public struct Absolute: AbsoluteMode, IndirectRotate {
        public static var opcode: UInt8 = 0x2e
    }

    public struct AbsoluteX: AbsoluteXMode, IndirectRotate {
        public static var opcode: UInt8 = 0x3e
    }
}

