//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class BITTests: NoProcessorTestCase {
    func execute(overflow: Bool, negative: Bool, zero: Bool, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Overflow], overflow)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
    }

    func testZeroPage() throws {
        registers.a = 0x7f
        memory[0x80] = 0x80
        execute(overflow: false, negative: true, zero: true, instruction: BIT.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x40
        execute(overflow: true, negative: false, zero: false, instruction: BIT.ZeroPage.self, operands: 0x80)
    }

    func testAbsolute() throws {
        registers.a = 0x7f
        memory[0x7080] = 0x80
        execute(overflow: false, negative: true, zero: true, instruction: BIT.Absolute.self, operands: 0x80, 0x70)
        memory[0x7080] = 0x40
        execute(overflow: true, negative: false, zero: false, instruction: BIT.Absolute.self, operands: 0x80, 0x70)
    }

    static var allTests = [
        ("testZeroPage", testZeroPage),
        ("testAbsolute", testAbsolute)
    ]
}
