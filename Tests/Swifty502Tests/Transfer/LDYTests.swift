//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class LDYTests: NoProcessorTestCase {
    func execute(y: UInt8, negative: Bool, zero: Bool, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.y, y)
    }

    func testImmediate() throws {
        execute(y: 0x00, negative: false, zero: true, instruction: LDY.Immediate.self, operands: 0x00)
        execute(y: 0x7f, negative: false, zero: false, instruction: LDY.Immediate.self, operands: 0x7f)
        execute(y: 0x80, negative: true, zero: false, instruction: LDY.Immediate.self, operands: 0x80)
    }

    func testZeroPage() throws {
        memory[0x80] = 0x00
        execute(y: 0x00, negative: false, zero: true, instruction: LDY.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x7f
        execute(y: 0x7f, negative: false, zero: false, instruction: LDY.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x80
        execute(y: 0x80, negative: true, zero: false, instruction: LDY.ZeroPage.self, operands: 0x80)
    }

    func testZeroPageX() throws {
        registers.x = 0x08
        memory[0x88] = 0x00
        execute(y: 0x00, negative: false, zero: true, instruction: LDY.ZeroPageX.self, operands: 0x80)
        memory[0x88] = 0x7f
        execute(y: 0x7f, negative: false, zero: false, instruction: LDY.ZeroPageX.self, operands: 0x80)
        memory[0x88] = 0x80
        execute(y: 0x80, negative: true, zero: false, instruction: LDY.ZeroPageX.self, operands: 0x80)
    }

    func testZeroPageXWrapAround() throws {
        registers.x = 0x60
        memory[0x20] = 0x00
        execute(y: 0x00, negative: false, zero: true, instruction: LDY.ZeroPageX.self, operands: 0xc0)
        memory[0x20] = 0x7f
        execute(y: 0x7f, negative: false, zero: false, instruction: LDY.ZeroPageX.self, operands: 0xc0)
        memory[0x20] = 0x80
        execute(y: 0x80, negative: true, zero: false, instruction: LDY.ZeroPageX.self, operands: 0xc0)
    }

    func testAbsolute() throws {
        memory[0x7788] = 0x00
        execute(y: 0x00, negative: false, zero: true, instruction: LDY.Absolute.self, operands: 0x88, 0x77)
        memory[0x7788] = 0x7f
        execute(y: 0x7f, negative: false, zero: false, instruction: LDY.Absolute.self, operands: 0x88, 0x77)
        memory[0x7788] = 0x80
        execute(y: 0x80, negative: true, zero: false, instruction: LDY.Absolute.self, operands: 0x88, 0x77)
    }

    func testAbsoluteX() throws {
        registers.x = 0x08
        memory[0x7788] = 0x00
        execute(y: 0x00, negative: false, zero: true, instruction: LDY.AbsoluteX.self, operands: 0x80, 0x77)
        memory[0x7788] = 0x7f
        execute(y: 0x7f, negative: false, zero: false, instruction: LDY.AbsoluteX.self, operands: 0x80, 0x77)
        memory[0x7788] = 0x80
        execute(y: 0x80, negative: true, zero: false, instruction: LDY.AbsoluteX.self, operands: 0x80, 0x77)
    }

    static var allTests = [
        ("testImmediate", testImmediate),
        ("testZeroPage", testZeroPage),
        ("testZeroPageX", testZeroPageX),
        ("testZeroPageXWrapAround", testZeroPageXWrapAround),
        ("testAbsolute", testAbsolute),
        ("testAbsoluteX", testAbsoluteX)
    ]
}

