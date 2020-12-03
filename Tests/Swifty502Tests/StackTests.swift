//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class StackTests: XCTestCase {
    var memory: Memory!
    var registers: Registers!
    var stack: Stack!

    override func setUpWithError() throws {
        memory = TestMemory()
        registers = Registers()
        stack = Stack(memory: memory, registers: registers)
    }

    func testBytes() throws {
        stack.pushByte(0xaa)
        stack.pushByte(0xbb)
        stack.pushByte(0xcc)
        XCTAssertEqual(stack.popByte(), 0xcc)
        XCTAssertEqual(stack.popByte(), 0xbb)
        XCTAssertEqual(stack.popByte(), 0xaa)
    }

    func testWords() throws {
        stack.pushWord(0xaabb)
        stack.pushWord(0xccdd)
        stack.pushWord(0xeeff)
        XCTAssertEqual(stack.popWord(), 0xeeff)
        XCTAssertEqual(stack.popWord(), 0xccdd)
        XCTAssertEqual(stack.popWord(), 0xaabb)
    }

    func testByteWrapAround() throws {
        memory[0x100] = 0xaa
        XCTAssertEqual(registers.sp, 0xff)
        XCTAssertEqual(stack.popByte(), 0xaa)
        stack.pushByte(0x11)
        stack.pushByte(0x22)
        XCTAssertEqual(memory[0x100], 0x11)
        XCTAssertEqual(memory[0x1ff], 0x22)

    }

    func testWordWrapAround() throws {
        memory[0x100] = 0xbb
        memory[0x101] = 0xaa
        XCTAssertEqual(registers.sp, 0xff)
        XCTAssertEqual(stack.popWord(), 0xaabb)
        stack.pushWord(0x1122)
        stack.pushWord(0x3344)
        XCTAssertEqual(memory[0x100], 0x22)
        XCTAssertEqual(memory[0x101], 0x11)
        XCTAssertEqual(memory[0x1fe], 0x44)
        XCTAssertEqual(memory[0x1ff], 0x33)

        // Split word on wrap around
        registers.sp = 0
        stack.pushWord(0xbeef)
        XCTAssertEqual(stack.popWord(), 0xbeef)
    }

    static var allTests = [
        ("testBytes", testBytes),
        ("testWords", testWords),
        ("testByteWrapAround", testByteWrapAround),
        ("testWordWrapAround", testWordWrapAround)
    ]
}

