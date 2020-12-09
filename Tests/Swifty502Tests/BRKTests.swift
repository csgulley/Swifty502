//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class BRKTests: XCTestCase {
    var processor: Processor!

    override func setUpWithError() throws {
        processor = Processor(memory: TestMemory())
        var shouldTerminate = false
        processor.brkHandler = { _,_ in
            // First break is to test behavior and second is to stop
            // execution
            if (!shouldTerminate) {
                shouldTerminate = true
                return false
            }
            return true
        }
    }

    func testBRK() throws {
        processor.memory[0] = LDA.Immediate.opcode
        processor.memory[1] = 0xaa
        processor.memory[2] = BRK.opcode

        processor.memory[0x2233] = PLA.opcode
        processor.memory[0x2234] = PHA.opcode
        processor.memory[0x2235] = STA.ZeroPage.opcode
        processor.memory[0x2236] = 0x40
        processor.memory[0x2237] = LDA.Immediate.opcode
        processor.memory[0x2238] = 0x33
        processor.memory[0x2239] = BRK.opcode

        processor.memory[0xfffe] = 0x33
        processor.memory[0xffff] = 0x22

        processor.memory.writeWord(address: 0xfffc, value: 0)
        try! processor.start()
        XCTAssertEqual(processor.a, 0x33)
        XCTAssertEqual(processor.pc, 0x223a)
        XCTAssertTrue(processor.memory[0x40] & 0x10 > 0)
    }

    static var allTests = [
        ("testBRK", testBRK)
    ]
}


