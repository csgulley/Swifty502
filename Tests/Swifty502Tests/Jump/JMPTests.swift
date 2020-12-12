//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class JMPTests: NoProcessorTestCase {
    func execute(instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
    }

    func testAbsolute() {
        registers.pc = 0x1000
        execute(instruction: JMP.Absolute.self, operands: 0x30, 0x20)
        XCTAssertEqual(registers.pc, 0x2030)
    }

    func testIndirect() {
        memory[0x2030] = 0xb0
        memory[0x2031] = 0xa0
        registers.pc = 0x1000
        execute(instruction: JMP.Indirect.self, operands: 0x30, 0x20)
        XCTAssertEqual(registers.pc, 0xa0b0)
    }

    static var allTests = [
        ("testAbsolute", testAbsolute),
        ("testIndirect", testIndirect)
    ]
}

