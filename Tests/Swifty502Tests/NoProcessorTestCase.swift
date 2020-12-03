//
// Created by Chris Gulley on 12/3/20.
//

import XCTest
@testable import Swifty502

class NoProcessorTestCase: XCTestCase {
    var memory: Memory!
    var registers: Registers!
    var stack: Stack!
    var executor: Executor!

    override func setUpWithError() throws {
        memory = TestMemory()
        registers = Registers()
        stack = Stack(memory: memory, registers: registers)
        executor = Executor(memory: memory, registers: registers)
    }
}
