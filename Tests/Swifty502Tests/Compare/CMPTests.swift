//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class CMPTests: NoProcessorTestCase {
    func execute(a: UInt8, negative: Bool, zero: Bool, carry: Bool, instruction: Instruction.Type, operands: UInt8...) {
        registers.a = a
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.status[.Carry], carry)
    }

    func testImmediate() throws {
        execute(a: 0x10, negative: false, zero: true, carry: true, instruction: CMP.Immediate.self, operands: 0x10)
        execute(a: 0x01, negative: false, zero: false, carry: false, instruction: CMP.Immediate.self, operands: 0xff)
        execute(a: 0x7f, negative: true, zero: false, carry: false, instruction: CMP.Immediate.self, operands: 0x80)
        execute(a: 0x80, negative: false, zero: false, carry: true, instruction: CMP.Immediate.self, operands: 0x7f)
    }

    func testZeroPage() throws {
        memory[0x80] = 0x10
        execute(a: 0x10, negative: false, zero: true, carry: true, instruction: CMP.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0xff
        execute(a: 0x01, negative: false, zero: false, carry: false, instruction: CMP.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x80
        execute(a: 0x7f, negative: true, zero: false, carry: false, instruction: CMP.ZeroPage.self, operands: 0x80)
        memory[0x80] = 0x7f
        execute(a: 0x80, negative: false, zero: false, carry: true, instruction: CMP.ZeroPage.self, operands: 0x80)
    }

    func testZeroPageX() throws {
        registers.x = 0x10
        memory[0x80] = 0x10
        execute(a: 0x10, negative: false, zero: true, carry: true, instruction: CMP.ZeroPageX.self, operands: 0x70)
        memory[0x80] = 0xff
        execute(a: 0x01, negative: false, zero: false, carry: false, instruction: CMP.ZeroPageX.self, operands: 0x70)
        memory[0x80] = 0x80
        execute(a: 0x7f, negative: true, zero: false, carry: false, instruction: CMP.ZeroPageX.self, operands: 0x70)
        memory[0x80] = 0x7f
        execute(a: 0x80, negative: false, zero: false, carry: true, instruction: CMP.ZeroPageX.self, operands: 0x70)
    }

    func testAbsolute() throws {
        memory[0x7000] = 0x10
        execute(a: 0x10, negative: false, zero: true, carry: true, instruction: CMP.Absolute.self, operands: 0x00, 0x70)
        memory[0x7000] = 0xff
        execute(a: 0x01, negative: false, zero: false, carry: false, instruction: CMP.Absolute.self, operands: 0x00, 0x70)
        memory[0x7000] = 0x80
        execute(a: 0x7f, negative: true, zero: false, carry: false, instruction: CMP.Absolute.self, operands: 0x00, 0x70)
        memory[0x7000] = 0x7f
        execute(a: 0x80, negative: false, zero: false, carry: true, instruction: CMP.Absolute.self, operands: 0x00, 0x70)
    }

    func testAbsoluteX() throws {
        registers.x = 0x20
        memory[0x7020] = 0x10
        execute(a: 0x10, negative: false, zero: true, carry: true, instruction: CMP.AbsoluteX.self, operands: 0x00, 0x70)
        memory[0x7020] = 0xff
        execute(a: 0x01, negative: false, zero: false, carry: false, instruction: CMP.AbsoluteX.self, operands: 0x00, 0x70)
        memory[0x7020] = 0x80
        execute(a: 0x7f, negative: true, zero: false, carry: false, instruction: CMP.AbsoluteX.self, operands: 0x00, 0x70)
        memory[0x7020] = 0x7f
        execute(a: 0x80, negative: false, zero: false, carry: true, instruction: CMP.AbsoluteX.self, operands: 0x00, 0x70)
    }

    func testAbsoluteY() throws {
        registers.y = 0x20
        memory[0x7020] = 0x10
        execute(a: 0x10, negative: false, zero: true, carry: true, instruction: CMP.AbsoluteY.self, operands: 0x00, 0x70)
        memory[0x7020] = 0xff
        execute(a: 0x01, negative: false, zero: false, carry: false, instruction: CMP.AbsoluteY.self, operands: 0x00, 0x70)
        memory[0x7020] = 0x80
        execute(a: 0x7f, negative: true, zero: false, carry: false, instruction: CMP.AbsoluteY.self, operands: 0x00, 0x70)
        memory[0x7020] = 0x7f
        execute(a: 0x80, negative: false, zero: false, carry: true, instruction: CMP.AbsoluteY.self, operands: 0x00, 0x70)
    }

    func testIndirectX() throws {
        registers.x = 0x20
        memory[0x50] = 0x20
        memory[0x51] = 0x70
        memory[0x7020] = 0x10
        execute(a: 0x10, negative: false, zero: true, carry: true, instruction: CMP.IndirectX.self, operands: 0x30)
        memory[0x7020] = 0xff
        execute(a: 0x01, negative: false, zero: false, carry: false, instruction: CMP.IndirectX.self, operands: 0x30)
        memory[0x7020] = 0x80
        execute(a: 0x7f, negative: true, zero: false, carry: false, instruction: CMP.IndirectX.self, operands: 0x30)
        memory[0x7020] = 0x7f
        execute(a: 0x80, negative: false, zero: false, carry: true, instruction: CMP.IndirectX.self, operands: 0x30)
    }

    func testIndirectY() throws {
        registers.y = 0x20
        memory[0x30] = 0x00
        memory[0x31] = 0x70
        memory[0x7020] = 0x10
        execute(a: 0x10, negative: false, zero: true, carry: true, instruction: CMP.IndirectY.self, operands: 0x30)
        memory[0x7020] = 0xff
        execute(a: 0x01, negative: false, zero: false, carry: false, instruction: CMP.IndirectY.self, operands: 0x30)
        memory[0x7020] = 0x80
        execute(a: 0x7f, negative: true, zero: false, carry: false, instruction: CMP.IndirectY.self, operands: 0x30)
        memory[0x7020] = 0x7f
        execute(a: 0x80, negative: false, zero: false, carry: true, instruction: CMP.IndirectY.self, operands: 0x30)
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

