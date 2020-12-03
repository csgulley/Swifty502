//
//  CPY.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol YComparer: RegisterComparer {
}

extension YComparer {
    static func getRegisterValue(_ registers: Registers) -> UInt8 {
        registers.y
    }
}

struct CPY {
    struct Immediate: ImmediateMode, ImmediateRegisterComparer, YComparer {
        static var opcode: UInt8 = 0xc0
        static var mnemonic = "CPY"
    }

    struct ZeroPage: ZeroPageMode, IndirectRegisterComparer, YComparer {
        static var opcode: UInt8 = 0xc4
        static var mnemonic = "CPY"
    }

    struct Absolute: AbsoluteMode, IndirectRegisterComparer, YComparer {
        static var opcode: UInt8 = 0xcc
        static var mnemonic = "CPY"
    }
}

