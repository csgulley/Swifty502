//
//  File.swift
//  
//
//  Created by Chris Gulley on 12/28/20.
//

import XCTest
@testable import Swifty502

class CycleCountTests: XCTestCase {
    var processor: Processor!
    
    override func setUpWithError() throws {
        processor = Processor(memory: TestMemory())
    }
    
    func testNop() throws {
        let start = processor.cycle
        processor.memory[0x300] = NOP.opcode
        processor.memory[0x301] = NOP.opcode
        processor.memory[0x302] = NOP.opcode
        processor.memory[0x303] = BRK.opcode
        processor.memory.writeWord(address: 0xfffc, value: 0x300)
        processor.brkHandler = { _,_ in true }
        
        try! processor.start()
        XCTAssertEqual(6, processor.cycle - start)
    }
    
    func testBit() throws {
        let start = processor.cycle
        processor.memory[0x300] = BIT.ZeroPage.opcode
        processor.memory[0x301] = 0x80
        processor.memory[0x302] = BRK.opcode
        processor.memory.writeWord(address: 0xfffc, value: 0x300)
        processor.brkHandler = { _,_ in true }
        
        try! processor.start()
        XCTAssertEqual(3, processor.cycle - start)
    }
    
    static var allTests = [
        ("testNop", testNop),
        ("testBit", testBit)
    ]
}


