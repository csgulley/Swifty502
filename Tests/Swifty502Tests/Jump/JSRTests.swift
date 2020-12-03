//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class JSRTests: NoProcessorTestCase {
    func execute(instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
    }

    func testJSR() {
        registers.pc = 0x1000
        execute(instruction: JSR.self, operands: 0x30, 0x20)
        XCTAssertEqual(registers.pc, 0x2030)
        XCTAssertEqual(stack.popByte(), 0x01)
        XCTAssertEqual(stack.popByte(), 0x10)
    }

    static var allTests = [
        ("testJSR", testJSR)
    ]
}

