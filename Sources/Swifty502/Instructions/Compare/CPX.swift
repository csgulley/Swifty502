//
//  CPX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol XComparer: RegisterComparer {
}

extension XComparer {
    static func getRegisterValue(_ registers: Registers) -> UInt8 {
        registers.x
    }
}

struct CPX {
    struct Immediate: ImmediateMode, ImmediateRegisterComparer, XComparer {
        static var opcode: UInt8 = 0xe0
        static var mnemonic = "CPX"
    }

    struct ZeroPage: ZeroPageMode, IndirectRegisterComparer, XComparer {
        static var opcode: UInt8 = 0xe4
        static var mnemonic = "CPX"
    }

    struct Absolute: AbsoluteMode, IndirectRegisterComparer, XComparer {
        static var opcode: UInt8 = 0xec
        static var mnemonic = "CPX"
    }
}
