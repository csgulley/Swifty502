//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class ADCTests: NoProcessorTestCase {
    func execute(a: UInt8, negative: Bool, zero: Bool, carry: Bool, overflow: Bool, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(registers.status[.Carry], carry)
        XCTAssertEqual(registers.status[.Overflow], overflow)
        XCTAssertEqual(registers.a, a)
    }

    func testImmediate() throws {
        registers.status[.Carry] = false
        registers.a = 0x00
        execute(a: 0x00, negative: false, zero: true, carry: false, overflow: false, instruction: ADC.Immediate.self, operands: 0x00)

        registers.status[.Carry] = false
        registers.a = 0x01
        execute(a: 0x02, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.Immediate.self, operands: 0x01)

        registers.status[.Carry] = false
        registers.a = 0x01
        execute(a: 0x00, negative: false, zero: true, carry: true, overflow: false, instruction: ADC.Immediate.self, operands: 0xff)

        registers.status[.Carry] = false
        registers.a = 0x7f
        execute(a: 0x80, negative: true, zero: false, carry: false, overflow: true, instruction: ADC.Immediate.self, operands: 0x01)

        registers.status[.Carry] = false
        registers.a = 0x80
        execute(a: 0x7f, negative: false, zero: false, carry: true, overflow: true, instruction: ADC.Immediate.self, operands: 0xff)

        registers.status[.Carry] = true
        registers.a = 0x01
        execute(a: 0x03, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.Immediate.self, operands: 0x01)
    }

    func testZeroPage() throws {
        registers.status[.Carry] = false
        registers.a = 0x00
        memory[0x40] = 0x00
        execute(a: 0x00, negative: false, zero: true, carry: false, overflow: false, instruction: ADC.ZeroPage.self, operands: 0x40)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x40] = 0x01
        execute(a: 0x02, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.ZeroPage.self, operands: 0x40)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x40] = 0xff
        execute(a: 0x00, negative: false, zero: true, carry: true, overflow: false, instruction: ADC.ZeroPage.self, operands: 0x40)

        registers.status[.Carry] = false
        registers.a = 0x7f
        memory[0x40] = 0x01
        execute(a: 0x80, negative: true, zero: false, carry: false, overflow: true, instruction: ADC.ZeroPage.self, operands: 0x40)

        registers.status[.Carry] = false
        registers.a = 0x80
        memory[0x40] = 0xff
        execute(a: 0x7f, negative: false, zero: false, carry: true, overflow: true, instruction: ADC.ZeroPage.self, operands: 0x40)

        registers.status[.Carry] = true
        registers.a = 0x01
        memory[0x40] = 0x01
        execute(a: 0x03, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.ZeroPage.self, operands: 0x40)
    }

    func testZeroPageX() throws {
        registers.x = 0x10
        registers.status[.Carry] = false
        registers.a = 0x00
        memory[0x40] = 0x00
        execute(a: 0x00, negative: false, zero: true, carry: false, overflow: false, instruction: ADC.ZeroPageX.self, operands: 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x40] = 0x01
        execute(a: 0x02, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.ZeroPageX.self, operands: 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x40] = 0xff
        execute(a: 0x00, negative: false, zero: true, carry: true, overflow: false, instruction: ADC.ZeroPageX.self, operands: 0x30)

        registers.status[.Carry] = false
        registers.a = 0x7f
        memory[0x40] = 0x01
        execute(a: 0x80, negative: true, zero: false, carry: false, overflow: true, instruction: ADC.ZeroPageX.self, operands: 0x30)

        registers.status[.Carry] = false
        registers.a = 0x80
        memory[0x40] = 0xff
        execute(a: 0x7f, negative: false, zero: false, carry: true, overflow: true, instruction: ADC.ZeroPageX.self, operands: 0x30)

        registers.status[.Carry] = true
        registers.a = 0x01
        memory[0x40] = 0x01
        execute(a: 0x03, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.ZeroPageX.self, operands: 0x30)
    }

    func testAbsolute() throws {
        registers.x = 0x10
        registers.status[.Carry] = false
        registers.a = 0x00
        memory[0x3020] = 0x00
        execute(a: 0x00, negative: false, zero: true, carry: false, overflow: false, instruction: ADC.Absolute.self, operands: 0x20, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x3020] = 0x01
        execute(a: 0x02, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.Absolute.self, operands: 0x20, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x3020] = 0xff
        execute(a: 0x00, negative: false, zero: true, carry: true, overflow: false, instruction: ADC.Absolute.self, operands: 0x20, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x7f
        memory[0x3020] = 0x01
        execute(a: 0x80, negative: true, zero: false, carry: false, overflow: true, instruction: ADC.Absolute.self, operands: 0x20, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x80
        memory[0x3020] = 0xff
        execute(a: 0x7f, negative: false, zero: false, carry: true, overflow: true, instruction: ADC.Absolute.self, operands: 0x20, 0x30)

        registers.status[.Carry] = true
        registers.a = 0x01
        memory[0x3020] = 0x01
        execute(a: 0x03, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.Absolute.self, operands: 0x20, 0x30)
    }

    func testAbsoluteX() throws {
        registers.x = 0x10
        registers.status[.Carry] = false
        registers.a = 0x00
        memory[0x3020] = 0x00
        execute(a: 0x00, negative: false, zero: true, carry: false, overflow: false, instruction: ADC.AbsoluteX.self, operands: 0x10, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x3020] = 0x01
        execute(a: 0x02, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.AbsoluteX.self, operands: 0x10, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x3020] = 0xff
        execute(a: 0x00, negative: false, zero: true, carry: true, overflow: false, instruction: ADC.AbsoluteX.self, operands: 0x10, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x7f
        memory[0x3020] = 0x01
        execute(a: 0x80, negative: true, zero: false, carry: false, overflow: true, instruction: ADC.AbsoluteX.self, operands: 0x10, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x80
        memory[0x3020] = 0xff
        execute(a: 0x7f, negative: false, zero: false, carry: true, overflow: true, instruction: ADC.AbsoluteX.self, operands: 0x10, 0x30)

        registers.status[.Carry] = true
        registers.a = 0x01
        memory[0x3020] = 0x01
        execute(a: 0x03, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.AbsoluteX.self, operands: 0x10, 0x30)
    }

    func testAbsoluteY() throws {
        registers.y = 0x10
        registers.status[.Carry] = false
        registers.a = 0x00
        memory[0x3020] = 0x00
        execute(a: 0x00, negative: false, zero: true, carry: false, overflow: false, instruction: ADC.AbsoluteY.self, operands: 0x10, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x3020] = 0x01
        execute(a: 0x02, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.AbsoluteY.self, operands: 0x10, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x3020] = 0xff
        execute(a: 0x00, negative: false, zero: true, carry: true, overflow: false, instruction: ADC.AbsoluteY.self, operands: 0x10, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x7f
        memory[0x3020] = 0x01
        execute(a: 0x80, negative: true, zero: false, carry: false, overflow: true, instruction: ADC.AbsoluteY.self, operands: 0x10, 0x30)

        registers.status[.Carry] = false
        registers.a = 0x80
        memory[0x3020] = 0xff
        execute(a: 0x7f, negative: false, zero: false, carry: true, overflow: true, instruction: ADC.AbsoluteY.self, operands: 0x10, 0x30)

        registers.status[.Carry] = true
        registers.a = 0x01
        memory[0x3020] = 0x01
        execute(a: 0x03, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.AbsoluteY.self, operands: 0x10, 0x30)
    }

    func testIndirectX() throws {
        registers.x = 0x10
        memory[0x30] = 0x80
        memory[0x31] = 0x40

        registers.status[.Carry] = false
        registers.a = 0x00
        memory[0x4080] = 0x00
        execute(a: 0x00, negative: false, zero: true, carry: false, overflow: false, instruction: ADC.IndirectX.self, operands: 0x20)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x4080] = 0x01
        execute(a: 0x02, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.IndirectX.self, operands: 0x20)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x4080] = 0xff
        execute(a: 0x00, negative: false, zero: true, carry: true, overflow: false, instruction: ADC.IndirectX.self, operands: 0x20)

        registers.status[.Carry] = false
        registers.a = 0x7f
        memory[0x4080] = 0x01
        execute(a: 0x80, negative: true, zero: false, carry: false, overflow: true, instruction: ADC.IndirectX.self, operands: 0x20)

        registers.status[.Carry] = false
        registers.a = 0x80
        memory[0x4080] = 0xff
        execute(a: 0x7f, negative: false, zero: false, carry: true, overflow: true, instruction: ADC.IndirectX.self, operands: 0x20)

        registers.status[.Carry] = true
        registers.a = 0x01
        memory[0x4080] = 0x01
        execute(a: 0x03, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.IndirectX.self, operands: 0x20)
    }

    func testIndirectY() throws {
        registers.y = 0x10
        memory[0x30] = 0x70
        memory[0x31] = 0x40

        registers.status[.Carry] = false
        registers.a = 0x00
        memory[0x4080] = 0x00
        execute(a: 0x00, negative: false, zero: true, carry: false, overflow: false, instruction: ADC.IndirectY.self, operands: 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x4080] = 0x01
        execute(a: 0x02, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.IndirectY.self, operands: 0x30)

        registers.status[.Carry] = false
        registers.a = 0x01
        memory[0x4080] = 0xff
        execute(a: 0x00, negative: false, zero: true, carry: true, overflow: false, instruction: ADC.IndirectY.self, operands: 0x30)

        registers.status[.Carry] = false
        registers.a = 0x7f
        memory[0x4080] = 0x01
        execute(a: 0x80, negative: true, zero: false, carry: false, overflow: true, instruction: ADC.IndirectY.self, operands: 0x30)

        registers.status[.Carry] = false
        registers.a = 0x80
        memory[0x4080] = 0xff
        execute(a: 0x7f, negative: false, zero: false, carry: true, overflow: true, instruction: ADC.IndirectY.self, operands: 0x30)

        registers.status[.Carry] = true
        registers.a = 0x01
        memory[0x4080] = 0x01
        execute(a: 0x03, negative: false, zero: false, carry: false, overflow: false, instruction: ADC.IndirectY.self, operands: 0x30)
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

