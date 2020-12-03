//
//  INC.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/30/20.
//

fileprivate protocol Incrementer {
}

extension Incrementer {
    static var mnemonic: String {
        "INC"
    }

    static func execute(operand: UInt16, memory: Memory, registers: Registers, stack: Stack) {
        memory[operand] &+= 1
        registers.status.updateFlags(memory[operand], .Zero, .Negative)
    }
}

struct INC {
    struct ZeroPage: ZeroPageMode, Incrementer {
        static var opcode: UInt8 = 0xe6
    }

    struct ZeroPageX: ZeroPageXMode, Incrementer {
        static var opcode: UInt8 = 0xf6
    }

    struct Absolute: AbsoluteMode, Incrementer {
        static var opcode: UInt8 = 0xee
    }

    struct AbsoluteX: AbsoluteXMode, Incrementer {
        static var opcode: UInt8 = 0xfe
    }
}

