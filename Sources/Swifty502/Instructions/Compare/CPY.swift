//
//  CPY.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/24/20.
//

fileprivate protocol YComparer: RegisterComparer {
}

extension YComparer {
    public static var mnemonic: String { "CPY" }

    static func getRegisterValue(_ registers: Registers) -> UInt8 {
        registers.y
    }
}

public struct CPY {
    public struct Immediate: ImmediateMode, ImmediateRegisterComparer, YComparer {
        public static var opcode: UInt8 = 0xc0
        static func cycles() -> Int { 2 }
    }

    public struct ZeroPage: ZeroPageMode, IndirectRegisterComparer, YComparer {
        public static var opcode: UInt8 = 0xc4
        static func cycles() -> Int { 3 }
    }

    public struct Absolute: AbsoluteMode, IndirectRegisterComparer, YComparer {
        public static var opcode: UInt8 = 0xcc
        static func cycles() -> Int { 4 }
    }
}

