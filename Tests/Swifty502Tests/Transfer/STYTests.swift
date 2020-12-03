//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class STYTests: NoProcessorTestCase {
    func execute(value: UInt8, address: UInt16, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(memory[address], value)
    }

    func testZeroPage() throws {
        registers.y = 0xaa
        execute(value: 0xaa, address: 0x80, instruction: STY.ZeroPage.self, operands: 0x80)
    }

    func testZeroPageX() throws {
        registers.y = 0xbb
        registers.x = 0x08
        execute(value: 0xbb, address: 0x88, instruction: STY.ZeroPageX.self, operands: 0x80)
    }

    func testAbsolute() throws {
        registers.y = 0xcc
        execute(value: 0xcc, address: 0x8833, instruction: STY.Absolute.self, operands: 0x33, 0x88)
    }

    static var allTests = [
        ("testZeroPage", testZeroPage),
        ("testZeroPageX", testZeroPageX),
        ("testAbsolute", testAbsolute)
    ]
}

