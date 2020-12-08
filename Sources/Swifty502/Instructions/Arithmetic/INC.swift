//
//  INC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

fileprivate protocol Incrementer {
}

extension Incrementer {
    public static var mnemonic: String {
        "INC"
    }

    public static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] &+= 1
        registers.status.updateFlags(memory[operand], .Zero, .Negative)
    }
}

public struct INC {
    public struct ZeroPage: ZeroPageMode, Incrementer {
        public static var opcode: UInt8 = 0xe6
    }

    public struct ZeroPageX: ZeroPageXMode, Incrementer {
        public static var opcode: UInt8 = 0xf6
    }

    public struct Absolute: AbsoluteMode, Incrementer {
        public static var opcode: UInt8 = 0xee
    }

    public struct AbsoluteX: AbsoluteXMode, Incrementer {
        public static var opcode: UInt8 = 0xfe
    }
}

