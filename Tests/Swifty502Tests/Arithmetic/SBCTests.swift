//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class SBCTests: NoProcessorTestCase {
    func execute(a: UInt8, negative: Bool, zero: Bool, carry: Bool, overflow: Bool, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.status[.Carry], carry)
        XCTAssertEqual(registers.status[.Overflow], overflow)
        XCTAssertEqual(registers.a, a)
    }

    // Check that undocumented flags work similarly to NMOS 6502 (see http://www.6502.org/tutorials/decimal_mode.html#4.1)
    func testDecimal() throws {
        registers.status[.Decimal] = true
        registers.status[.Carry] = false
        registers.a = 0x10
        execute(a: 0x00, negative: false, zero: false, carry: true, overflow: false, instruction: SBC.Immediate.self, operands: 0x09)

        registers.status[.Carry] = true
        registers.a = 0x00
        execute(a: 0x79, negative: true, zero: false, carry: false, overflow: false, instruction: SBC.Immediate.self, operands: 0x21)
    }

    static var allTests = [
        ("testDecimal", testDecimal)
    ]
}

