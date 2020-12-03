//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class DECTests: NoProcessorTestCase {
    func execute(address: UInt16, value: UInt8, negative: Bool, zero: Bool, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.status[.Negative], negative)
        XCTAssertEqual(registers.status[.Zero], zero)
        XCTAssertEqual(memory[address], value)
    }

    func testZeroPage() throws {
        memory[0xa0] = 0x01
        execute(address: 0xa0, value: 0x00, negative: false, zero: true, instruction: DEC.ZeroPage.self, operands: 0xa0)
        execute(address: 0xa0, value: 0xff, negative: true, zero: false, instruction: DEC.ZeroPage.self, operands: 0xa0)
    }

    func testZeroPageX() throws {
        registers.x = 0x0a
        memory[0xaa] = 0x01
        execute(address: 0xaa, value: 0x00, negative: false, zero: true, instruction: DEC.ZeroPageX.self, operands: 0xa0)
        execute(address: 0xaa, value: 0xff, negative: true, zero: false, instruction: DEC.ZeroPageX.self, operands: 0xa0)
    }

    func testAbsolute() throws {
        memory[0xbbaa] = 0x01
        execute(address: 0xbbaa, value: 0x00, negative: false, zero: true, instruction: DEC.Absolute.self, operands: 0xaa, 0xbb)
        execute(address: 0xbbaa, value: 0xff, negative: true, zero: false, instruction: DEC.Absolute.self, operands: 0xaa, 0xbb)
    }

    func testAbsoluteX() throws {
        registers.x = 0x05
        memory[0xbbaf] = 0x01
        execute(address: 0xbbaf, value: 0x00, negative: false, zero: true, instruction: DEC.AbsoluteX.self, operands: 0xaa, 0xbb)
        execute(address: 0xbbaf, value: 0xff, negative: true, zero: false, instruction: DEC.AbsoluteX.self, operands: 0xaa, 0xbb)
    }

    static var allTests = [
        ("testZeroPage", testZeroPage),
        ("testZeroPageX", testZeroPageX),
        ("testAbsolute", testAbsolute),
        ("testAbsoluteX", testAbsoluteX)
    ]
}

