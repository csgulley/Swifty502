//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class RORTests: NoProcessorTestCase {
    func execute(negative: Bool, zero: Bool, carry: Bool, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.status[.Carry], carry)
    }

    func testAccumulator() throws {
        registers.a = 0x04
        execute(negative: false, zero: false, carry: false, instruction: ROR.Accumulator.self)
        XCTAssertEqual(registers.a, 0x02)
        execute(negative: false, zero: false, carry: false, instruction: ROR.Accumulator.self)
        XCTAssertEqual(registers.a, 0x01)
        registers.status[.Carry] = true
        registers.a = 0x04
        execute(negative: true, zero: false, carry: false, instruction: ROR.Accumulator.self)
        XCTAssertEqual(registers.a, 0x82)
    }

    func testZeroPage() throws {
        memory[0x70] = 0x04
        execute(negative: false, zero: false, carry: false, instruction: ROR.ZeroPage.self, operands: 0x70)
        XCTAssertEqual(memory[0x70], 0x02)
        execute(negative: false, zero: false, carry: false, instruction: ROR.ZeroPage.self, operands: 0x70)
        XCTAssertEqual(memory[0x70], 0x01)
        registers.status[.Carry] = true
        memory[0x70] = 0x04
        execute(negative: true, zero: false, carry: false, instruction: ROR.ZeroPage.self, operands: 0x70)
        XCTAssertEqual(memory[0x70], 0x82)
    }

    func testZeroPageX() throws {
        registers.x = 0x07
        memory[0x77] = 0x04
        execute(negative: false, zero: false, carry: false, instruction: ROR.ZeroPageX.self, operands: 0x70)
        XCTAssertEqual(memory[0x77], 0x02)
        execute(negative: false, zero: false, carry: false, instruction: ROR.ZeroPageX.self, operands: 0x70)
        XCTAssertEqual(memory[0x77], 0x01)
        registers.status[.Carry] = true
        memory[0x77] = 0x04
        execute(negative: true, zero: false, carry: false, instruction: ROR.ZeroPageX.self, operands: 0x70)
        XCTAssertEqual(memory[0x77], 0x82)
    }

    func testAbsolute() throws {
        memory[0x5070] = 0x04
        execute(negative: false, zero: false, carry: false, instruction: ROR.Absolute.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5070], 0x02)
        execute(negative: false, zero: false, carry: false, instruction: ROR.Absolute.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5070], 0x01)
        registers.status[.Carry] = true
        memory[0x5070] = 0x04
        execute(negative: true, zero: false, carry: false, instruction: ROR.Absolute.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5070], 0x82)
    }

    func testAbsoluteX() throws {
        registers.x = 0x10
        memory[0x5080] = 0x04
        execute(negative: false, zero: false, carry: false, instruction: ROR.AbsoluteX.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5080], 0x02)
        execute(negative: false, zero: false, carry: false, instruction: ROR.AbsoluteX.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5080], 0x01)
        registers.status[.Carry] = true
        memory[0x5080] = 0x04
        execute(negative: true, zero: false, carry: false, instruction: ROR.AbsoluteX.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5080], 0x82)
    }

    static var allTests = [
        ("testAccumulator", testAccumulator),
        ("testZeroPage", testZeroPage),
        ("testZeroPageX", testZeroPageX),
        ("testAbsolute", testAbsolute),
        ("testAbsoluteX", testAbsoluteX)
    ]
}
