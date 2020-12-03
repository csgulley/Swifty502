//
//  LDY.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol YLoader: RegisterLoader {
}

extension YLoader {
    static func setValue(value: UInt8, registers: Registers) {
        registers.y = value
    }
}

struct LDY {
    struct Immediate: ImmediateMode, ImmediateRegisterLoader, YLoader {
        static var opcode: UInt8 = 0xa0
        static var mnemonic = "LDY"
    }

    struct ZeroPage: ZeroPageMode, IndirectRegisterLoader, YLoader {
        static var opcode: UInt8 = 0xa4
        static var mnemonic = "LDY"
    }

    struct ZeroPageX: ZeroPageXMode, IndirectRegisterLoader, YLoader {
        static var opcode: UInt8 = 0xb4
        static var mnemonic = "LDY"
    }

    struct Absolute: AbsoluteMode, IndirectRegisterLoader, YLoader {
        static var opcode: UInt8 = 0xac
        static var mnemonic = "LDY"
    }

    struct AbsoluteX: AbsoluteXMode, IndirectRegisterLoader, YLoader {
        static var opcode: UInt8 = 0xbc
        static var mnemonic = "LDY"
    }
}
