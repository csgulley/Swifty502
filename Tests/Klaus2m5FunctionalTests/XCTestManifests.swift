import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(FunctionalTest.allTests)
    ]
}
#endif
