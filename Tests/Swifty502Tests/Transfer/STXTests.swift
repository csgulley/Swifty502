//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class STXTests: NoProcessorTestCase {
    func execute(value: UInt8, address: UInt16, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(memory[address], value)
    }

    func testZeroPage() throws {
        registers.x = 0xaa
        execute(value: 0xaa, address: 0x80, instruction: STX.ZeroPage.self, operands: 0x80)
    }

    func testZeroPageY() throws {
        registers.x = 0xbb
        registers.y = 0x08
        execute(value: 0xbb, address: 0x88, instruction: STX.ZeroPageY.self, operands: 0x80)
    }

    func testAbsolute() throws {
        registers.x = 0xcc
        execute(value: 0xcc, address: 0x8833, instruction: STX.Absolute.self, operands: 0x33, 0x88)
    }

    static var allTests = [
        ("testZeroPage", testZeroPage),
        ("testZeroPageY", testZeroPageY),
        ("testAbsolute", testAbsolute)
    ]
}

