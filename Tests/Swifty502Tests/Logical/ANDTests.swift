//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class ANDTests: NoProcessorTestCase {
    func execute(a: UInt8, negative: Bool, zero: Bool, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.a, a)
    }

    func testImmediate() throws {
        registers.a = 0xff
        execute(a: 0x00, negative: false, zero: true, instruction: AND.Immediate.self, operands: 0x00)
        registers.a = 0xff
        execute(a: 0x80, negative: true, zero: false, instruction: AND.Immediate.self, operands: 0x80)
        registers.a = 0xff
        execute(a: 0x7f, negative: false, zero: false, instruction: AND.Immediate.self, operands: 0x7f)
    }

    func testZeroPage() throws {
        registers.a = 0xff
        memory[0x60] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: AND.ZeroPage.self, operands: 0x60)
        registers.a = 0xff
        memory[0x60] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: AND.ZeroPage.self, operands: 0x60)
        registers.a = 0xff
        memory[0x60] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: AND.ZeroPage.self, operands: 0x60)
    }

    func testZeroPageX() throws {
        registers.a = 0xff
        registers.x = 0x20
        memory[0x80] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: AND.ZeroPageX.self, operands: 0x60)
        registers.a = 0xff
        memory[0x80] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: AND.ZeroPageX.self, operands: 0x60)
        registers.a = 0xff
        memory[0x80] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: AND.ZeroPageX.self, operands: 0x60)
    }

    func testAbsolute() throws {
        registers.a = 0xff
        memory[0x4060] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: AND.Absolute.self, operands: 0x60, 0x40)
        registers.a = 0xff
        memory[0x4060] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: AND.Absolute.self, operands: 0x60, 0x40)
        registers.a = 0xff
        memory[0x4060] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: AND.Absolute.self, operands: 0x60, 0x40)
    }

    func testAbsoluteX() throws {
        registers.x = 0x10
        registers.a = 0xff
        memory[0x4070] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: AND.AbsoluteX.self, operands: 0x60, 0x40)
        registers.a = 0xff
        memory[0x4070] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: AND.AbsoluteX.self, operands: 0x60, 0x40)
        registers.a = 0xff
        memory[0x4070] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: AND.AbsoluteX.self, operands: 0x60, 0x40)
    }

    func testAbsoluteY() throws {
        registers.y = 0x10
        registers.a = 0xff
        memory[0x4070] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: AND.AbsoluteY.self, operands: 0x60, 0x40)
        registers.a = 0xff
        memory[0x4070] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: AND.AbsoluteY.self, operands: 0x60, 0x40)
        registers.a = 0xff
        memory[0x4070] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: AND.AbsoluteY.self, operands: 0x60, 0x40)
    }

    func testIndirectX() throws {
        registers.x = 0x10
        registers.a = 0xff
        memory[0x80] = 0x70
        memory[0x81] = 0x40

        memory[0x4070] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: AND.IndirectX.self, operands: 0x70)
        registers.a = 0xff
        memory[0x4070] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: AND.IndirectX.self, operands: 0x70)
        registers.a = 0xff
        memory[0x4070] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: AND.IndirectX.self, operands: 0x70)
    }

    func testIndirectY() throws {
        registers.y = 0x04
        registers.a = 0xff
        memory[0x80] = 0x70
        memory[0x81] = 0x40

        memory[0x4074] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: AND.IndirectY.self, operands: 0x80)
        registers.a = 0xff
        memory[0x4074] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: AND.IndirectY.self, operands: 0x80)
        registers.a = 0xff
        memory[0x4074] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: AND.IndirectY.self, operands: 0x80)
    }

    static var allTests = [
        ("testImmediate", testImmediate),
        ("testZeroPage", testZeroPage),
        ("testZeroPageX", testZeroPageX),
        ("testAbsolute", testAbsolute),
        ("testAbsoluteX", testAbsoluteX),
        ("testAbsoluteY", testAbsoluteY),
        ("testIndirectX", testIndirectX),
        ("testIndirectY", testIndirectY)
    ]
}
