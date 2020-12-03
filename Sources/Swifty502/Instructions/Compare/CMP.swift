//
//  CMP.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/23/20.
//

fileprivate protocol AComparer: RegisterComparer {
}

extension AComparer {
    static func getRegisterValue(_ registers: Registers) -> UInt8 {
        registers.a
    }
}

struct CMP {
    struct Immediate: ImmediateMode, ImmediateRegisterComparer, AComparer {
        static var opcode: UInt8 = 0xc9
        static var mnemonic = "CMP"
    }

    struct ZeroPage: ZeroPageMode, IndirectRegisterComparer, AComparer {
        static var opcode: UInt8 = 0xc5
        static var mnemonic = "CMP"
    }

    struct ZeroPageX: ZeroPageXMode, IndirectRegisterComparer, AComparer {
        static var opcode: UInt8 = 0xd5
        static var mnemonic = "CMP"
    }

    struct Absolute: AbsoluteMode, IndirectRegisterComparer, AComparer {
        static var opcode: UInt8 = 0xcd
        static var mnemonic = "CMP"
    }

    struct AbsoluteX: AbsoluteXMode, IndirectRegisterComparer, AComparer {
        static var opcode: UInt8 = 0xdd
        static var mnemonic = "CMP"
    }

    struct AbsoluteY: AbsoluteYMode, IndirectRegisterComparer, AComparer {
        static var opcode: UInt8 = 0xd9
        static var mnemonic = "CMP"
    }

    struct IndirectX: IndirectXMode, IndirectRegisterComparer, AComparer {
        static var opcode: UInt8 = 0xc1
        static var mnemonic = "CMP"
    }

    struct IndirectY: IndirectYMode, IndirectRegisterComparer, AComparer {
        static var opcode: UInt8 = 0xd1
        static var mnemonic = "CMP"
    }
}
