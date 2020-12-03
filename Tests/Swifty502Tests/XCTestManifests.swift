import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(Swifty502Tests.allTests),
    ]
}
#endif
