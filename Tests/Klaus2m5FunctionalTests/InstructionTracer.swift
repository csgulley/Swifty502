//
//  InstructionLogger.swift
//  Swifty502
//
//  Created by Chris Gulley on 11/25/20.
//

import Swifty502

class InstructionTracer: InstructionInterceptor {
    private func formatOperand(operand: UInt16, addressMode: AddressMode, processor: Processor) -> String {
        let formatted: String
        switch addressMode {
        case .Absolute, .Relative:
            formatted = String(format: "$%04x", operand)
        case .AbsoluteX:
            let address = operand + UInt16(processor.x)
            formatted = String(format: "$%04x,X $%04x", operand, address)
        case .Indirect:
            let address = processor.memory.readWord(operand)
            formatted = String(format: "($%04x) $%04x", operand, address)
        case .Immediate:
            formatted = String(format: "#$%02x", operand)
        case .ZeroPage:
            formatted = String(format: "$%02x", operand)
        default:
            formatted = ""
        }
        return formatted
    }
    
    private func getOperand(address: UInt16, instruction: Instruction.Type, memory: Memory) -> UInt16 {
        let operand: UInt16
        switch instruction.addressMode {
        case .Absolute, .AbsoluteX, .Indirect:
            operand = memory.readWord(address + 1)
        case .Immediate, .ZeroPage:
            operand = UInt16(memory[address + 1])
        case .Relative:
            let target = Int(address + 2) + Int(memory[address + 1])
            operand = UInt16(target)
        default:
            operand = 0
        }
        return operand
    }
    
    func onInstruction(address: UInt16, instruction: Instruction.Type, processor: Processor) {
        let operand = getOperand(address: address, instruction: instruction, memory: processor.memory)
        let formattedAddress = String(format: "%04x", address)
        let formattedOperand = formatOperand(operand: operand, addressMode: instruction.addressMode, processor: processor)
        print("\(formattedAddress) \(instruction.mnemonic) \(formattedOperand)")
    }
}
