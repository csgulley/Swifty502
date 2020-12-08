//
//  CPX.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol XComparer: RegisterComparer {
}

extension XComparer {
    public static var mnemonic: String { "CPX" }

    static func getRegisterValue(_ registers: Registers) -> UInt8 {
        registers.x
    }
}

public struct CPX {
    public struct Immediate: ImmediateMode, ImmediateRegisterComparer, XComparer {
        public static var opcode: UInt8 = 0xe0
    }

    public struct ZeroPage: ZeroPageMode, IndirectRegisterComparer, XComparer {
        public static var opcode: UInt8 = 0xe4
    }

    public struct Absolute: AbsoluteMode, IndirectRegisterComparer, XComparer {
        public static var opcode: UInt8 = 0xec
    }
}
