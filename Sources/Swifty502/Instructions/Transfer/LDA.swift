//
//  LDA.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

fileprivate protocol ALoader: RegisterLoader {
}

extension ALoader {
    static func setValue(value: UInt8, registers: Registers) {
        registers.a = value
    }
}

struct LDA {
    struct Immediate: ImmediateMode, ImmediateRegisterLoader, ALoader {
        static var opcode: UInt8 = 0xa9
        static var mnemonic = "LDA"
    }

    struct ZeroPage: ZeroPageMode, IndirectRegisterLoader, ALoader {
        static var opcode: UInt8 = 0xa5
        static var mnemonic = "LDA"
    }

    struct ZeroPageX: ZeroPageXMode, IndirectRegisterLoader, ALoader {
        static var opcode: UInt8 = 0xb5
        static var mnemonic = "LDA"
    }

    struct Absolute: AbsoluteMode, IndirectRegisterLoader, ALoader {
        static var opcode: UInt8 = 0xad
        static var mnemonic = "LDA"
    }

    struct AbsoluteX: AbsoluteXMode, IndirectRegisterLoader, ALoader {
        static var opcode: UInt8 = 0xbd
        static var mnemonic = "LDA"
    }

    struct AbsoluteY: AbsoluteYMode, IndirectRegisterLoader, ALoader {
        static var opcode: UInt8 = 0xb9
        static var mnemonic = "LDA"
    }

    struct IndirectX: IndirectXMode, IndirectRegisterLoader, ALoader {
        static var opcode: UInt8 = 0xa1
        static var mnemonic = "LDA"
    }

    struct IndirectY: IndirectYMode, IndirectRegisterLoader, ALoader {
        static var opcode: UInt8 = 0xb1
        static var mnemonic = "LDA"
    }
}
