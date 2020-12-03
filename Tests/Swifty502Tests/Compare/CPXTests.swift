//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class CPXTests: NoProcessorTestCase {
    func execute(x: UInt8, negative: Bool, zero: Bool, carry: Bool, instruction: Instruction.Type, operands: UInt8...) {
        registers.x = x
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.status[.Carry], carry)
    }

    func testImmediate() throws {
        execute(x: 0x10, negative: false, zero: true, carry: true, instruction: CPX.Immediate.self, operands: 0x10)
        execute(x: 0x01, negative: false, zero: false, carry: false, instruction: CPX.Immediate.self, operands: 0xff)
        execute(x: 0x7f, negative: true, zero: false, carry: false, instruction: CPX.Immediate.self, operands: 0x80)
        execute(x: 0x80, negative: false, zero: false, carry: true, instruction: CPX.Immediate.self, operands: 0x7f)
    }

    func testZeroPage() throws {
        memory[0x80] = 0x10
        execute(x: 0x10, negative: false, zero: true, carry: true, instruction: CPX.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0xff
        execute(x: 0x01, negative: false, zero: false, carry: false, instruction: CPX.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x80
        execute(x: 0x7f, negative: true, zero: false, carry: false, instruction: CPX.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x7f
        execute(x: 0x80, negative: false, zero: false, carry: true, instruction: CPX.ZeroPage.self, operands: 0x80)
    }

    func testAbsolute() throws {
        memory[0x7000] = 0x10
        execute(x: 0x10, negative: false, zero: true, carry: true, instruction: CPX.Absolute.self, operands: 0x00, 0x70)
        memory[0x7000] = 0xff
        execute(x: 0x01, negative: false, zero: false, carry: false, instruction: CPX.Absolute.self, operands: 0x00, 0x70)
        memory[0x7000] = 0x80
        execute(x: 0x7f, negative: true, zero: false, carry: false, instruction: CPX.Absolute.self, operands: 0x00, 0x70)
        memory[0x7000] = 0x7f
        execute(x: 0x80, negative: false, zero: false, carry: true, instruction: CPX.Absolute.self, operands: 0x00, 0x70)
    }

    static var allTests = [
        ("testImmediate", testImmediate),
        ("testZeroPage", testZeroPage),
        ("testAbsolute", testAbsolute)
    ]
}

