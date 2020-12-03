//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class EORTests: NoProcessorTestCase {
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
        registers.a = 0x0f
        execute(a: 0xff, negative: true, zero: false, instruction: EOR.Immediate.self, operands: 0xf0)
        registers.a = 0x0f
        execute(a: 0x00, negative: false, zero: true, instruction: EOR.Immediate.self, operands: 0x0f)
        registers.a = 0x0f
        execute(a: 0x8e, negative: true, zero: false, instruction: EOR.Immediate.self, operands: 0x81)
    }

    func testZeroPage() throws {
        registers.a = 0x0f
        memory[0x60] = 0xf0
        execute(a: 0xff, negative: true, zero: false, instruction: EOR.ZeroPage.self, operands: 0x60)
        registers.a = 0x0f
        memory[0x60] = 0x0f
        execute(a: 0x00, negative: false, zero: true, instruction: EOR.ZeroPage.self, operands: 0x60)
        registers.a = 0x0f
        memory[0x60] = 0x81
        execute(a: 0x8e, negative: true, zero: false, instruction: EOR.ZeroPage.self, operands: 0x60)
    }

    func testZeroPageX() throws {
        registers.a = 0x0f
        registers.x = 0x20
        memory[0x80] = 0xf0
        execute(a: 0xff, negative: true, zero: false, instruction: EOR.ZeroPageX.self, operands: 0x60)
        registers.a = 0x0f
        memory[0x80] = 0x0f
        execute(a: 0x00, negative: false, zero: true, instruction: EOR.ZeroPageX.self, operands: 0x60)
        registers.a = 0x0f
        memory[0x80] = 0x81
        execute(a: 0x8e, negative: true, zero: false, instruction: EOR.ZeroPageX.self, operands: 0x60)
    }

    func testAbsolute() throws {
        registers.a = 0x0f
        memory[0x4060] = 0xf0
        execute(a: 0xff, negative: true, zero: false, instruction: EOR.Absolute.self, operands: 0x60, 0x40)
        registers.a = 0x0f
        memory[0x4060] = 0x0f
        execute(a: 0x00, negative: false, zero: true, instruction: EOR.Absolute.self, operands: 0x60, 0x40)
        registers.a = 0x0f
        memory[0x4060] = 0x81
        execute(a: 0x8e, negative: true, zero: false, instruction: EOR.Absolute.self, operands: 0x60, 0x40)
    }

    func testAbsoluteX() throws {
        registers.a = 0x0f
        registers.x = 0x10
        memory[0x4070] = 0xf0
        execute(a: 0xff, negative: true, zero: false, instruction: EOR.AbsoluteX.self, operands: 0x60, 0x40)
        registers.a = 0x0f
        memory[0x4070] = 0x0f
        execute(a: 0x00, negative: false, zero: true, instruction: EOR.AbsoluteX.self, operands: 0x60, 0x40)
        registers.a = 0x0f
        memory[0x4070] = 0x81
        execute(a: 0x8e, negative: true, zero: false, instruction: EOR.AbsoluteX.self, operands: 0x60, 0x40)
    }

    func testAbsoluteY() throws {
        registers.a = 0x0f
        registers.y = 0x10
        memory[0x4070] = 0xf0
        execute(a: 0xff, negative: true, zero: false, instruction: EOR.AbsoluteY.self, operands: 0x60, 0x40)
        registers.a = 0x0f
        memory[0x4070] = 0x0f
        execute(a: 0x00, negative: false, zero: true, instruction: EOR.AbsoluteY.self, operands: 0x60, 0x40)
        registers.a = 0x0f
        memory[0x4070] = 0x81
        execute(a: 0x8e, negative: true, zero: false, instruction: EOR.AbsoluteY.self, operands: 0x60, 0x40)
    }

    func testIndirectX() throws {
        registers.a = 0x0f
        registers.x = 0x10

        memory[0x80] = 0x70
        memory[0x81] = 0x40

        memory[0x4070] = 0xf0
        execute(a: 0xff, negative: true, zero: false, instruction: EOR.IndirectX.self, operands: 0x70)
        registers.a = 0x0f
        memory[0x4070] = 0x0f
        execute(a: 0x00, negative: false, zero: true, instruction: EOR.IndirectX.self, operands: 0x70)
        registers.a = 0x0f
        memory[0x4070] = 0x81
        execute(a: 0x8e, negative: true, zero: false, instruction: EOR.IndirectX.self, operands: 0x70)
    }

    func testIndirectY() throws {
        registers.a = 0x0f
        registers.y = 0x04

        memory[0x80] = 0x70
        memory[0x81] = 0x40

        memory[0x4074] = 0xf0
        execute(a: 0xff, negative: true, zero: false, instruction: EOR.IndirectY.self, operands: 0x80)
        registers.a = 0x0f
        memory[0x4074] = 0x0f
        execute(a: 0x00, negative: false, zero: true, instruction: EOR.IndirectY.self, operands: 0x80)
        registers.a = 0x0f
        memory[0x4074] = 0x81
        execute(a: 0x8e, negative: true, zero: false, instruction: EOR.IndirectY.self, operands: 0x80)
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
