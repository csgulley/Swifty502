//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class ConditionalTests: NoProcessorTestCase {
    func execute(pc: UInt16, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        let _ = instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(registers.pc, pc)
    }

    func checkConditional(_ instruction: Instruction.Type, condition: (Bool) -> Void) {
        registers.pc = 0x010
        condition(true)
        execute(pc: 0x21, instruction: instruction, operands: 0x10)

        registers.pc = 0x10
        condition(false)
        execute(pc: 0x11, instruction: instruction, operands: 0x10)

        registers.pc = 0x10
        condition(true)
        execute(pc: 0x0b, instruction: instruction, operands: 0xfa)
    }

    func testBCC() throws {
        checkConditional(BCC.self) { registers.status[.Carry] = !$0 }
    }

    func testBCS() throws {
        checkConditional(BCS.self) { registers.status[.Carry] = $0 }
    }

    func testBEQ() throws {
        checkConditional(BEQ.self) { registers.status[.Zero] = $0 }
    }

    func testBNE() throws {
        checkConditional(BNE.self) { registers.status[.Zero] = !$0 }
    }

    func testBPL() throws {
        checkConditional(BPL.self) { registers.status[.Negative] = !$0 }
    }

    func testBMI() throws {
        checkConditional(BMI.self) { registers.status[.Negative] = $0 }
    }

    func testBVC() throws {
        checkConditional(BVC.self) { registers.status[.Overflow] = !$0 }
    }

    func testBVS() throws {
        checkConditional(BVS.self) { registers.status[.Overflow] = $0 }
    }

    static var allTests = [
        ("testBCC", testBCC),
        ("testBCS", testBCS),
        ("testBEQ", testBEQ),
        ("testBNE", testBNE),
        ("testBPL", testBPL),
        ("testBMI", testBMI),
        ("testBVC", testBVC),
        ("testBVS", testBVS)
    ]
}

