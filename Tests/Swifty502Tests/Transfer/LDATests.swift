//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class LDATests: NoProcessorTestCase {
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
        execute(a: 0x00, negative: false, zero: true, instruction: LDA.Immediate.self, operands: 0x00)
        execute(a: 0x7f, negative: false, zero: false, instruction: LDA.Immediate.self, operands: 0x7f)
        execute(a: 0x80, negative: true, zero: false, instruction: LDA.Immediate.self, operands: 0x80)
    }

    func testZeroPage() throws {
        memory[0x80] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: LDA.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: LDA.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: LDA.ZeroPage.self, operands: 0x80)
    }

    func testZeroPageX() throws {
        registers.x = 0x08
        memory[0x88] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: LDA.ZeroPageX.self, operands: 0x80)
        memory[0x88] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: LDA.ZeroPageX.self, operands: 0x80)
        memory[0x88] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: LDA.ZeroPageX.self, operands: 0x80)
    }

    func testZeroPageXWrapAround() throws {
        registers.x = 0x60
        memory[0x20] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: LDA.ZeroPageX.self, operands: 0xc0)
        memory[0x20] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: LDA.ZeroPageX.self, operands: 0xc0)
        memory[0x20] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: LDA.ZeroPageX.self, operands: 0xc0)
    }

    func testAbsolute() throws {
        memory[0x7788] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: LDA.Absolute.self, operands: 0x88, 0x77)
        memory[0x7788] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: LDA.Absolute.self, operands: 0x88, 0x77)
        memory[0x7788] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: LDA.Absolute.self, operands: 0x88, 0x77)
    }

    func testAbsoluteX() throws {
        registers.x = 0x08
        memory[0x7788] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: LDA.AbsoluteX.self, operands: 0x80, 0x77)
        memory[0x7788] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: LDA.AbsoluteX.self, operands: 0x80, 0x77)
        memory[0x7788] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: LDA.AbsoluteX.self, operands: 0x80, 0x77)
    }

    func testAbsoluteY() throws {
        registers.y = 0x08
        memory[0x7788] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: LDA.AbsoluteY.self, operands: 0x80, 0x77)
        memory[0x7788] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: LDA.AbsoluteY.self, operands: 0x80, 0x77)
        memory[0x7788] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: LDA.AbsoluteY.self, operands: 0x80, 0x77)
    }

    func testIndirectX() throws {
        registers.x = 0x04
        memory[0x24] = 0x88
        memory[0x25] = 0x77
        memory[0x7788] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: LDA.IndirectX.self, operands: 0x20)
        memory[0x7788] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: LDA.IndirectX.self, operands: 0x20)
        memory[0x7788] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: LDA.IndirectX.self, operands: 0x20)
    }

    func testIndirectY() throws {
        registers.y = 0x04
        memory[0x86] = 0x20
        memory[0x87] = 0x40
        memory[0x4024] = 0x00
        execute(a: 0x00, negative: false, zero: true, instruction: LDA.IndirectY.self, operands: 0x86)
        memory[0x4024] = 0x7f
        execute(a: 0x7f, negative: false, zero: false, instruction: LDA.IndirectY.self, operands: 0x86)
        memory[0x4024] = 0x80
        execute(a: 0x80, negative: true, zero: false, instruction: LDA.IndirectY.self, operands: 0x86)
    }

    static var allTests = [
        ("testImmediate", testImmediate),
        ("testZeroPage", testZeroPage),
        ("testZeroPageX", testZeroPageX),
        ("testZeroPageXWrapAround", testZeroPageXWrapAround),
        ("testAbsolute", testAbsolute),
        ("testAbsoluteX", testAbsoluteX),
        ("testAbsoluteY", testAbsoluteY),
        ("testIndirectX", testIndirectX),
        ("testIndirectY", testIndirectY)
    ]
}

