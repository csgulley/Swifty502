//
// Created by Chris Gulley on 12/3/20.
//

import Foundation

import XCTest
@testable import Swifty502

class IndexedIndirectTests: XCTestCase {
    var processor: Processor!

    override func setUpWithError() throws {
        processor = Processor(memory: TestMemory())
        processor.brkHandler = { _,_ in true }
    }

    func testWrapAround() throws {
        processor.memory[0] = LDX.Immediate.opcode
        processor.memory[1] = 0xfe
        processor.memory[2] = LDA.IndirectX.opcode
        processor.memory[3] = 0x20
        processor.memory[4] = BRK.opcode
        processor.memory[0x1e] = 0x88
        processor.memory[0x1f] = 0x77
        processor.memory[0x7788] = 0x55

        processor.memory.writeWord(address: 0xfffc, value: 0)
        try! processor.start()
        XCTAssertEqual(processor.a, 0x55)
    }

    static var allTests = [
        ("testWrapAround", testWrapAround)
    ]
}

