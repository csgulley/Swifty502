//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class ROLTests: NoProcessorTestCase {
    func execute(negative: Bool, zero: Bool, carry: Bool, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
    }

    func testAccumulator() throws {
        registers.a = 0x20
        execute(negative: false, zero: false, carry: false, instruction: ROL.Accumulator.self)
        XCTAssertEqual(registers.a, 0x40)
        execute(negative: true, zero: false, carry: false, instruction: ROL.Accumulator.self)
        XCTAssertEqual(registers.a, 0x80)
        execute(negative: false, zero: true, carry: true, instruction: ROL.Accumulator.self)
        XCTAssertEqual(registers.a, 0x00)
        registers.a = 0x20
        registers.status[.Carry] = true
        execute(negative: false, zero: false, carry: false, instruction: ROL.Accumulator.self)
        XCTAssertEqual(registers.a, 0x41)
    }

    func testZeroPage() throws {
        memory[0x70] = 0x20
        execute(negative: false, zero: false, carry: false, instruction: ROL.ZeroPage.self, operands: 0x70)
        XCTAssertEqual(memory[0x70], 0x40)
        execute(negative: true, zero: false, carry: false, instruction: ROL.ZeroPage.self, operands: 0x70)
        XCTAssertEqual(memory[0x70], 0x80)
        execute(negative: false, zero: true, carry: true, instruction: ROL.ZeroPage.self, operands: 0x70)
        XCTAssertEqual(memory[0x70], 0x00)
        memory[0x70] = 0x20
        registers.status[.Carry] = true
        execute(negative: false, zero: false, carry: false, instruction: ROL.ZeroPage.self, operands: 0x70)
        XCTAssertEqual(memory[0x70], 0x41)
    }

    func testZeroPageX() throws {
        registers.x = 0x07
        memory[0x77] = 0x20
        execute(negative: false, zero: false, carry: false, instruction: ROL.ZeroPageX.self, operands: 0x70)
        XCTAssertEqual(memory[0x77], 0x40)
        execute(negative: true, zero: false, carry: false, instruction: ROL.ZeroPageX.self, operands: 0x70)
        XCTAssertEqual(memory[0x77], 0x80)
        execute(negative: false, zero: true, carry: true, instruction: ROL.ZeroPageX.self, operands: 0x70)
        XCTAssertEqual(memory[0x77], 0x00)
        memory[0x77] = 0x20
        registers.status[.Carry] = true
        execute(negative: false, zero: false, carry: false, instruction: ROL.ZeroPageX.self, operands: 0x70)
        XCTAssertEqual(memory[0x77], 0x41)
    }

    func testAbsolute() throws {
        memory[0x5070] = 0x20
        execute(negative: false, zero: false, carry: false, instruction: ROL.Absolute.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5070], 0x40)
        execute(negative: true, zero: false, carry: false, instruction: ROL.Absolute.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5070], 0x80)
        execute(negative: false, zero: true, carry: true, instruction: ROL.Absolute.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5070], 0x00)
        memory[0x5070] = 0x20
        registers.status[.Carry] = true
        execute(negative: false, zero: false, carry: false, instruction: ROL.Absolute.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5070], 0x41)
    }

    func testAbsoluteX() throws {
        registers.x = 0x10
        memory[0x5080] = 0x20
        execute(negative: false, zero: false, carry: false, instruction: ROL.AbsoluteX.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5080], 0x40)
        execute(negative: true, zero: false, carry: false, instruction: ROL.AbsoluteX.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5080], 0x80)
        execute(negative: false, zero: true, carry: true, instruction: ROL.AbsoluteX.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5080], 0x00)
        memory[0x5080] = 0x20
        registers.status[.Carry] = true
        execute(negative: false, zero: false, carry: false, instruction: ROL.AbsoluteX.self, operands: 0x70, 0x50)
        XCTAssertEqual(memory[0x5080], 0x41)
    }

    static var allTests = [
        ("testAccumulator", testAccumulator),
        ("testZeroPage", testZeroPage),
        ("testZeroPageX", testZeroPageX),
        ("testAbsolute", testAbsolute),
        ("testAbsoluteX", testAbsoluteX)
    ]
}
