//
//  File.swift
//  
//
//  Created by Chris Gulley on 12/7/20.
//

/*
 * Official instruction set for original 6502. Does not include undocumented instructions or
 * instructions added by 65C02.
 */
public struct Instructions6502: InstructionSet {
    public static var instructions: [Instruction.Type] {[
        ADC.Immediate.self,
        ADC.ZeroPage.self,
        ADC.ZeroPageX.self,
        ADC.Absolute.self,
        ADC.AbsoluteX.self,
        ADC.AbsoluteY.self,
        ADC.IndirectX.self,
        ADC.IndirectY.self,
        DEC.ZeroPage.self,
        DEC.ZeroPageX.self,
        DEC.Absolute.self,
        DEC.AbsoluteX.self,
        DEX.self,
        DEY.self,
        INC.ZeroPage.self,
        INC.ZeroPageX.self,
        INC.Absolute.self,
        INC.AbsoluteX.self,
        INX.self,
        INY.self,
        SBC.Immediate.self,
        SBC.ZeroPage.self,
        SBC.ZeroPageX.self,
        SBC.Absolute.self,
        SBC.AbsoluteX.self,
        SBC.AbsoluteY.self,
        SBC.IndirectX.self,
        SBC.IndirectY.self,
        
        CMP.Immediate.self,
        CMP.ZeroPage.self,
        CMP.ZeroPageX.self,
        CMP.Absolute.self,
        CMP.AbsoluteX.self,
        CMP.AbsoluteY.self,
        CMP.IndirectX.self,
        CMP.IndirectY.self,
        CPX.Immediate.self,
        CPX.ZeroPage.self,
        CPX.Absolute.self,
        CPY.Immediate.self,
        CPY.ZeroPage.self,
        CPY.Absolute.self,
        
        BCC.self,
        BCS.self,
        BEQ.self,
        BMI.self,
        BNE.self,
        BPL.self,
        BVC.self,
        BVS.self,
       
        JMP.Absolute.self,
        JMP.Indirect.self,
        JSR.self,
        
        AND.Immediate.self,
        AND.ZeroPage.self,
        AND.ZeroPageX.self,
        AND.Absolute.self,
        AND.AbsoluteX.self,
        AND.AbsoluteY.self,
        AND.IndirectX.self,
        AND.IndirectY.self,
        BIT.ZeroPage.self,
        BIT.Absolute.self,
        EOR.Immediate.self,
        EOR.ZeroPage.self,
        EOR.ZeroPageX.self,
        EOR.Absolute.self,
        EOR.AbsoluteX.self,
        EOR.AbsoluteY.self,
        EOR.IndirectX.self,
        EOR.IndirectY.self,
        ORA.Immediate.self,
        ORA.ZeroPage.self,
        ORA.ZeroPageX.self,
        ORA.Absolute.self,
        ORA.AbsoluteX.self,
        ORA.AbsoluteY.self,
        ORA.IndirectX.self,
        ORA.IndirectY.self,
        
        RTI.self,
        RTS.self,
        
        ASL.Accumulator.self,
        ASL.ZeroPage.self,
        ASL.ZeroPageX.self,
        ASL.Absolute.self,
        ASL.AbsoluteX.self,
        LSR.Accumulator.self,
        LSR.ZeroPage.self,
        LSR.ZeroPageX.self,
        LSR.Absolute.self,
        LSR.AbsoluteX.self,
        ROL.Accumulator.self,
        ROL.ZeroPage.self,
        ROL.ZeroPageX.self,
        ROL.Absolute.self,
        ROL.AbsoluteX.self,
        ROR.Accumulator.self,
        ROR.ZeroPage.self,
        ROR.ZeroPageX.self,
        ROR.Absolute.self,
        ROR.AbsoluteX.self,
        
        CLC.self,
        CLD.self,
        CLI.self,
        CLV.self,
        SEC.self,
        SED.self,
        SEI.self,
        
        LDA.Immediate.self,
        LDA.ZeroPage.self,
        LDA.ZeroPageX.self,
        LDA.Absolute.self,
        LDA.AbsoluteX.self,
        LDA.AbsoluteY.self,
        LDA.IndirectX.self,
        LDA.IndirectY.self,
        LDX.Immediate.self,
        LDX.ZeroPage.self,
        LDX.ZeroPageY.self,
        LDX.Absolute.self,
        LDX.AbsoluteY.self,
        LDY.Immediate.self,
        LDY.ZeroPage.self,
        LDY.ZeroPageX.self,
        LDY.Absolute.self,
        LDY.AbsoluteX.self,
        PHA.self,
        PHP.self,
        PLA.self,
        PLP.self,
        STA.ZeroPage.self,
        STA.ZeroPageX.self,
        STA.Absolute.self,
        STA.AbsoluteX.self,
        STA.AbsoluteY.self,
        STA.IndirectX.self,
        STA.IndirectY.self,
        STX.ZeroPage.self,
        STX.ZeroPageY.self,
        STX.Absolute.self,
        STY.ZeroPage.self,
        STY.ZeroPageX.self,
        STY.Absolute.self,
        
        TAX.self,
        TAY.self,
        TSX.self,
        TXA.self,
        TXS.self,
        TYA.self,

        BRK.self,
        NOP.self
    ]}
}
