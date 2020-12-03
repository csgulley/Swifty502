//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class LDXTests: NoProcessorTestCase {
    func execute(x: UInt8, negative: Bool, zero: Bool, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.x, x)
    }

    func testImmediate() throws {
        execute(x: 0x00, negative: false, zero: true, instruction: LDX.Immediate.self, operands: 0x00)
        execute(x: 0x7f, negative: false, zero: false, instruction: LDX.Immediate.self, operands: 0x7f)
        execute(x: 0x80, negative: true, zero: false, instruction: LDX.Immediate.self, operands: 0x80)
    }

    func testZeroPage() throws {
        memory[0x80] = 0x00
        execute(x: 0x00, negative: false, zero: true, instruction: LDX.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x7f
        execute(x: 0x7f, negative: false, zero: false, instruction: LDX.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x80
        execute(x: 0x80, negative: true, zero: false, instruction: LDX.ZeroPage.self, operands: 0x80)
    }

    func testZeroPageY() throws {
        registers.y = 0x08
        memory[0x88] = 0x00
        execute(x: 0x00, negative: false, zero: true, instruction: LDX.ZeroPageY.self, operands: 0x80)
        memory[0x88] = 0x7f
        execute(x: 0x7f, negative: false, zero: false, instruction: LDX.ZeroPageY.self, operands: 0x80)
        memory[0x88] = 0x80
        execute(x: 0x80, negative: true, zero: false, instruction: LDX.ZeroPageY.self, operands: 0x80)
    }

    func testZeroPageYWrapAround() throws {
        registers.y = 0x60
        memory[0x20] = 0x00
        execute(x: 0x00, negative: false, zero: true, instruction: LDX.ZeroPageY.self, operands: 0xc0)
        memory[0x20] = 0x7f
        execute(x: 0x7f, negative: false, zero: false, instruction: LDX.ZeroPageY.self, operands: 0xc0)
        memory[0x20] = 0x80
        execute(x: 0x80, negative: true, zero: false, instruction: LDX.ZeroPageY.self, operands: 0xc0)
    }

    func testAbsolute() throws {
        memory[0x7788] = 0x00
        execute(x: 0x00, negative: false, zero: true, instruction: LDX.Absolute.self, operands: 0x88, 0x77)
        memory[0x7788] = 0x7f
        execute(x: 0x7f, negative: false, zero: false, instruction: LDX.Absolute.self, operands: 0x88, 0x77)
        memory[0x7788] = 0x80
        execute(x: 0x80, negative: true, zero: false, instruction: LDX.Absolute.self, operands: 0x88, 0x77)
    }

    func testAbsoluteY() throws {
        registers.y = 0x08
        memory[0x7788] = 0x00
        execute(x: 0x00, negative: false, zero: true, instruction: LDX.AbsoluteY.self, operands: 0x80, 0x77)
        memory[0x7788] = 0x7f
        execute(x: 0x7f, negative: false, zero: false, instruction: LDX.AbsoluteY.self, operands: 0x80, 0x77)
        memory[0x7788] = 0x80
        execute(x: 0x80, negative: true, zero: false, instruction: LDX.AbsoluteY.self, operands: 0x80, 0x77)
    }

    static var allTests = [
        ("testImmediate", testImmediate),
        ("testZeroPage", testZeroPage),
        ("testZeroPageY", testZeroPageY),
        ("testZeroPageYWrapAround", testZeroPageYWrapAround),
        ("testAbsolute", testAbsolute),
        ("testAbsoluteY", testAbsoluteY)
    ]
}

