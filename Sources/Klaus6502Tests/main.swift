import Foundation
import Swifty502

 /**
 Configuration for running tests available here: https://github.com/amb5l/6502_65C02_functional_tests. The
 binaries are not included in this project and must be build from source project.
 */

class ArrayMemory: Memory {
    private var storage = Array<UInt8>(repeating: 0x00, count: Int(UInt16.max) + 1)
    subscript(address: UInt16) -> UInt8 {
        get { storage[Int(address)] }
        set(newValue) { storage[Int(address)] = newValue }
    }
}

func runFunctional() {
    let filename = "/Users/csgulley/LocalProjects/Swifty502/Sources/Klaus6502Tests/6502_functional_test.bin"
    
    /**
     Test ends in a tight loop on the same instruction which this code detects
     */
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
                let msg = String(format: "Functional test trapped at %04x", address)
                print(msg)
                isComplete = true
                processor.memory[address] = BRK.opcode
            }
            last = address
        }
    }
    
    let memory = ArrayMemory()
    let data = NSData(contentsOfFile: filename)!
    for i in 0..<data.count {
        memory[UInt16(i)] = data[i]
    }

    let terminationCheck = TerminationCheck()
    let processor = Processor(memory: memory)
    processor.addDebugInterceptor(terminationCheck)

    // Test needs to start at 0x400 so we replace the value the test stores in 0xfffc with that value
    terminationCheck.originalResetVector = processor.memory.readWord(0xfffc)
    processor.memory.writeWord(address: 0xfffc, value: 0x400)

    processor.brkHandler = { _,_ in
        // First break is to test behavior and second is to stop
        // execution
        terminationCheck.isComplete
    }
    
    try! processor.start()
}

func runDecimal() {
    let filename = "/Users/csgulley/LocalProjects/Swifty502/Sources/Klaus6502Tests/6502_decimal_test.bin"
    
    let memory = ArrayMemory()
    let data = NSData(contentsOfFile: filename)!
    for i in 0..<data.count {
        memory[UInt16(i)] = data[i]
    }

    // Helpful for understanding failed tests.
    class TestTracer: InstructionInterceptor {
        func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
            print("N1: \(String(format:"0x%02x", processor.memory[0x00]))", separator:"", terminator:"")
            print(" N2: \(String(format:"0x%02x", processor.memory[0x01]))", separator:"", terminator:"")
            print(" Y: \(String(format:"0x%02x", processor.y))")
            print("DA: \(String(format:"0x%04x", processor.memory[0x04]))", separator:"", terminator:"")
            print(" DNVZC: \(String(format:"0x%02x", processor.memory[0x05]))")
            print("AR: \(String(format:"0x%04x", processor.memory[0x06]))", separator:"", terminator:"")
            print(" NF: \(String(format:"0x%02x", processor.memory[0x07]))")
            
        }
    }

    let processor = Processor(memory: memory)
//    processor.addDebugInterceptor(TestTracer())
    processor.memory.writeWord(address: 0xfffc, value: 0x200)
    processor.brkHandler = { _,_ in
        // First break is to test behavior and second is to stop
        // execution
        true
    }
    
    try! processor.start()
    let result = processor.memory[0x0b]
    print("Decimal test ERROR: \(result)")
}

runFunctional()
runDecimal()
