//
//  File.swift
//  
//
//  Created by Chris Gulley on 12/7/20.
//

import XCTest
@testable import Swifty502

class TerminationCheck: InstructionInterceptor {
    var originalResetVector: UInt16?
    var last: UInt16 = 0xffff
    var isComplete = false
    func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
        if let o = originalResetVector {
            processor.memory.writeWord(address: 0xfffc, value: o)
            originalResetVector = nil
        }
        
        if (last == address && !isComplete) {
            let msg = String(format: "test trapped at %04x", address)
            print(msg)
            isComplete = true
            processor.memory[address] = BRK.opcode
        }
        last = address
    }
}

class FunctionalTests: XCTestCase {
    var processor: Processor!
    let filename = "/Users/csgulley/LocalProjects/6502_65C02_functional_tests/bin_files/6502_functional_test.bin"

    override func setUpWithError() throws {
        processor = Processor(memory: TestMemory())
        
        let data = NSData(contentsOfFile: filename)!
        for i in 0..<data.count {
            processor.memory[UInt16(i)] = data[i]
        }
    }

    func testInstructions() throws {
        let terminationCheck = TerminationCheck()
        processor.addDebugInterceptor(terminationCheck)
        
        let tracer = InstructionTracer()
        processor.addDebugInterceptor(tracer)
        
        // Test needs to start at 0x400
        terminationCheck.originalResetVector = processor.memory.readWord(0xfffc)
        processor.memory.writeWord(address: 0xfffc, value: 0x400)
        
        processor.brkHandler = { _,_ in
            // First break is to test behavior and second is to stop
            // execution
            terminationCheck.isComplete
        }
        try! processor.start()
    }
}
