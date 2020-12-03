//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class StatusTests: NoProcessorTestCase {
    func testCLC() throws {
        registers.status[.Carry] = true
        XCTAssertTrue(registers.status[.Carry])
        CLC.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Carry])
        CLC.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Carry])
    }

    func testCLD() throws {
        registers.status[.Decimal] = true
        XCTAssertTrue(registers.status[.Decimal])
        CLD.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Decimal])
        CLD.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Decimal])
    }

    func testCLI() throws {
        registers.status[.Interrupt] = true
        XCTAssertTrue(registers.status[.Interrupt])
        CLI.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Interrupt])
        CLI.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Interrupt])
    }

    func testCLV() throws {
        registers.status[.Overflow] = true
        XCTAssertTrue(registers.status[.Overflow])
        CLV.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Overflow])
        CLV.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertFalse(registers.status[.Overflow])
    }

    func testSEI() throws {
        registers.status[.Interrupt] = false
        XCTAssertFalse(registers.status[.Interrupt])
        SEI.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.Interrupt])
        SEI.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.Interrupt])
    }

    func testSEC() throws {
        registers.status[.Carry] = false
        XCTAssertFalse(registers.status[.Carry])
        SEC.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.Carry])
        SEC.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.Carry])
    }

    func testSED() throws {
        registers.status[.Decimal] = false
        XCTAssertFalse(registers.status[.Decimal])
        SED.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertTrue(registers.status[.Decimal])
        SED.execute(memory: memory, registers: registers, stack: stack, executor: executor)
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

