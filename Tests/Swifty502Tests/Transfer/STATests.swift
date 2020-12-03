//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class STATests: NoProcessorTestCase {
    func execute(value: UInt8, address: UInt16, instruction: Instruction.Type, operands: UInt8...) {
        for (i, op) in operands.enumerated() {
            memory[registers.pc + UInt16(i)] = op
        }
        instruction.execute(memory: memory, registers: registers, stack: stack, executor: executor)
        XCTAssertEqual(memory[address], value)
    }

    func testZeroPage() throws {
        registers.a = 0xaa
        execute(value: 0xaa, address: 0x80, instruction: STA.ZeroPage.self, operands: 0x80)
    }

    func testZeroPageX() throws {
        registers.a = 0xbb
        registers.x = 0x08
        execute(value: 0xbb, address: 0x88, instruction: STA.ZeroPageX.self, operands: 0x80)
    }

    func testAbsolute() throws {
        registers.a = 0xcc
        execute(value: 0xcc, address: 0x8833, instruction: STA.Absolute.self, operands: 0x33, 0x88)
    }

    func testAbsoluteX() throws {
        registers.a = 0xdd
        registers.x = 0x04
        execute(value: 0xdd, address: 0x9944, instruction: STA.AbsoluteX.self, operands: 0x40, 0x99)
    }

    func testAbsoluteY() throws {
        registers.a = 0xdd
        registers.y = 0x04
        execute(value: 0xdd, address: 0x9944, instruction: STA.AbsoluteY.self, operands: 0x40, 0x99)
    }

    func testIndirectX() throws {
        registers.a = 0xdd
        registers.x = 0x03
        memory[0x33] = 0xbb
        memory[0x34] = 0xaa
        execute(value: 0xdd, address: 0xaabb, instruction: STA.IndirectX.self, operands: 0x30)
    }

    func testIndirectY() throws {
        registers.a = 0xdd
        registers.y = 0x0d
        memory[0x86] = 0xd0
        memory[0x87] = 0xcc
        execute(value: 0xdd, address: 0xccdd, instruction: STA.IndirectY.self, operands: 0x86)
    }

    static var allTests = [
        ("testZeroPage", testZeroPage),
        ("testZeroPageX", testZeroPageX),
        ("testAbsolute", testAbsolute),
        ("testAbsoluteX", testAbsoluteX),
        ("testAbsoluteY", testAbsoluteY),
        ("testIndirectX", testIndirectX),
        ("testIndirectY", testIndirectY)
    ]
}

