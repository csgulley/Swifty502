//
//  StatusRegister.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/22/20.
//

class StatusRegister {
    private var flags = [ProcessorFlag: Bool]()

    var statusByte: UInt8 {
        get {
            ((self[.Negative] ? 1 : 0) << 7)
                    | ((self[.Overflow] ? 1 : 0) << 6)
                    | (1 << 5)
                    | (1 << 4)
                    | ((self[.Decimal] ? 1 : 0) << 3)
                    | ((self[.Interrupt] ? 1 : 0) << 2)
                    | ((self[.Zero] ? 1 : 0) << 1)
                    | ((self[.Carry] ? 1 : 0) << 0)
        }

        set(newValue) {
            self[.Negative] = (newValue & 0x80) > 0
            self[.Overflow] = (newValue & 0x40) > 0
            self[.Decimal] = (newValue & 0x08) > 0
            self[.Interrupt] = (newValue & 0x04) > 0
            self[.Zero] = (newValue & 0x02) > 0
            self[.Carry] = (newValue & 0x01) > 0
        }
    }

    subscript(index: ProcessorFlag) -> Bool {
        get {
            flags[index] ?? false
        }
        set(newValue) {
            flags[index] = newValue
        }
    }

    func updateFlags(_ value: UInt8, _ flags: ProcessorFlag...) {
        for flag in flags {
            updateFlag(value, flag)
        }
    }

    private func updateFlag(_ value: UInt8, _ flag: ProcessorFlag) {
        switch (flag) {
        case .Zero:
            flags[.Zero] = value == 0
        case .Negative:
            flags[.Negative] = (value & 0x80) > 0
        default:
            fatalError("Unimplemented flag \(flag)")
        }
    }
}
