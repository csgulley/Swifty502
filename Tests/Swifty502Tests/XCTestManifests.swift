import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(BRKTests.allTests),
        testCase(IndexedIndirectTests.allTests),
        testCase(ResetTests.allTests),
        testCase(StackTests.allTests),
        testCase(UnknownInstructionTests.allTests),
        testCase(CMPTests.allTests),
        testCase(CPXTests.allTests),
        testCase(CPYTests.allTests),
        testCase(ANDTests.allTests),
        testCase(ASLTests.allTests),
        testCase(BITTests.allTests),
        testCase(EORTests.allTests),
        testCase(LSRTests.allTests),
        testCase(ORATests.allTests),
        testCase(ROLTests.allTests),
        testCase(RORTests.allTests),
        testCase(ADCTests.allTests),
        testCase(SBCTests.allTests),
        testCase(DECTests.allTests),
        testCase(INCTests.allTests),
        testCase(DEXTests.allTests),
        testCase(DEYTests.allTests),
        testCase(INXTests.allTests),
        testCase(INYTests.allTests),
        testCase(ConditionalTests.allTests),
        testCase(JSRTests.allTests),
        testCase(JMPTests.allTests),
        testCase(RTITests.allTests),
        testCase(RTSTests.allTests),
        testCase(StatusTests.allTests),
        testCase(LDATests.allTests),
        testCase(LDXTests.allTests),
        testCase(LDYTests.allTests),
        testCase(PHATests.allTests),
        testCase(PHPTests.allTests),
        testCase(PLATests.allTests),
        testCase(STATests.allTests),
        testCase(STXTests.allTests),
        testCase(STYTests.allTests),
        testCase(TAXTests.allTests),
        testCase(TAYTests.allTests),
        testCase(TSXTests.allTests),
        testCase(TXATests.allTests),
        testCase(TXSTests.allTests),
        testCase(TYATests.allTests),
        testCase(InterruptTests.allTests),
        testCase(CycleCountTests.allTests),
        testCase(NonMaskablenterruptTests.allTests)
    ]
}
#endif
