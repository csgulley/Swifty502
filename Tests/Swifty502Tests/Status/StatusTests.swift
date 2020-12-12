//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class StatusTests: NoProcessorTestCase {
    func testCLC() throws {
        registers.status[.Carry] = true
        XCTAssertTrue(registers.status[.Carry])
        let _ = CLC.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Carry])
        let _ = CLC.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Carry])
    }

    func testCLD() throws {
        registers.status[.Decimal] = true
        XCTAssertTrue(registers.status[.Decimal])
        let _ = CLD.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Decimal])
        let _ = CLD.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Decimal])
    }

    func testCLI() throws {
        registers.status[.InterruptDisable] = true
        XCTAssertTrue(registers.status[.InterruptDisable])
        let _ = CLI.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.InterruptDisable])
        let _ = CLI.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.InterruptDisable])
    }

    func testCLV() throws {
        registers.status[.Overflow] = true
        XCTAssertTrue(registers.status[.Overflow])
        let _ = CLV.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Overflow])
        let _ = CLV.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Overflow])
    }

    func testSEI() throws {
        registers.status[.InterruptDisable] = false
        XCTAssertFalse(registers.status[.InterruptDisable])
        let _ = SEI.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.InterruptDisable])
        let _ = SEI.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.InterruptDisable])
    }

    func testSEC() throws {
        registers.status[.Carry] = false
        XCTAssertFalse(registers.status[.Carry])
        let _ = SEC.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.Carry])
        let _ = SEC.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.Carry])
    }

    func testSED() throws {
        registers.status[.Decimal] = false
        XCTAssertFalse(registers.status[.Decimal])
        let _ = SED.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.Decimal])
        let _ = SED.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.Decimal])
    }

    static var allTests = [
        ("testCLC", testCLC),
        ("testCLD", testCLD),
        ("testCLI", testCLI),
        ("testCLV", testCLV),
        ("testSEI", testSEI),
        ("testSEC", testSEC),
        ("testSED", testSED)
    ]
}

