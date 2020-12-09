//
//  AddOperator.swift
//  Swifty502
//
//  Created by Chris Gulley on 12/1/20.
//

struct AddOperator {
    static func binaryAdd(value: UInt8, registers: Registers) {
        let addend1 = Int(registers.a)
        let addend2 = Int(value)
        let carry = registers.status[.Carry] ? 1 : 0
        let sum = addend1 + addend2 + carry
        let byteSum = UInt8(sum & 0xff)
        registers.status.updateFlags(byteSum, .Negative, .Zero)
        registers.status[.Carry] = sum > 0xff

        // From http://www.righto.com/2012/12/the-6502-overflow-flag-explained.html#:~:text=The%20definition%20of%20the%206502,fit%20into%20a%20signed%20byte.&text=The%20symptom%20of%20this%20is,and%20getting%20a%20positive%20result.
        registers.status[.Overflow] = (registers.a ^ byteSum) & (value ^ byteSum) & 0x80 > 0
        registers.a = byteSum
    }

    static func binarySubtract(value: UInt8, registers: Registers) {
        binaryAdd(value: ~value, registers: registers)
    }

    // Borrowed from KEGS indirectly via apple2js and modified for NMOS 6502 behavior
    static func decimalSubtract(value: UInt8, registers: Registers) {
        let term1 = Int(registers.a)
        let term2 = Int(~value)
        let carry = registers.status[.Carry] ? 1 : 0
        var difference = (term1 & 0x0f) + (term2 & 0x0f) + carry
        if (difference < 0x10) {
            difference = (difference - 0x06) & 0x0f;
        }
        difference = difference + (term1 & 0xf0) + (term2 & 0xf0)
        let overflow: Bool
        if (((term1 ^ term2) & 0x80) > 0) {
            overflow = false
        } else {
            overflow = (((difference >> 2) ^ (difference >> 1)) & 0x40) > 0
        }
        if (difference < 0x100) {
            difference = (difference + 0xa0) & 0xff
        }
        let byteDifference = UInt8(difference & 0xff)
        registers.status[.Overflow] = overflow
        registers.status[.Carry] = difference > 0xff
        let binaryResult = UInt8((term1 + term2 + carry) & 0xff)
        registers.status[.Zero] = binaryResult == 0
        registers.status[.Negative] = (binaryResult & 0x80) > 0
        registers.a = byteDifference
    }

    // Borrowed from KEGS indirectly via apple2js and modified for NMOS 6502 behavior
    static func decimalAdd(value: UInt8, registers: Registers) {
        let addend1 = Int(registers.a)
        let addend2 = Int(value)
        let carry = registers.status[.Carry] ? 1 : 0
        var sum = (addend1 & 0x0f) + (addend2 & 0x0f) + carry
        if (sum >= 0x0a) {
            sum = (sum - 0x0a) | 0x10
        }
        sum = sum + (addend1 & 0xf0) + (addend2 & 0xf0)
        registers.status[.Negative] = (sum & 0x80) > 0
        let overflow: Bool
        if (((addend1 ^ addend2) & 0x80) > 0) {
            overflow = false
        } else {
            overflow = (((sum >> 2) ^ (sum >> 1)) & 0x40) > 0
        }
        if (sum >= 0xa0) {
            sum += 0x60
        }
        let byteSum = UInt8(sum & 0xff)
        registers.status[.Overflow] = overflow
        registers.status[.Carry] = sum > 0xff
        registers.status[.Zero] = UInt8((addend1 + addend2 + carry) & 0xff) == 0
        registers.a = byteSum
    }


}
