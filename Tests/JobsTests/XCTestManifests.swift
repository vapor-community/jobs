#if !canImport(ObjectiveC)
import XCTest

extension DateComponentRetrievalTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__DateComponentRetrievalTests = [
        ("testCalendarIdentifier", testCalendarIdentifier),
        ("testDateComponentRetrival", testDateComponentRetrival),
        ("testDayOfWeek", testDayOfWeek),
        ("testQuarters", testQuarters),
        ("testTimeZone", testTimeZone),
        ("testWeekOfMonth", testWeekOfMonth),
        ("testWeekOfYear", testWeekOfYear),
        ("testWeeksInYear", testWeeksInYear),
    ]
}

extension JobStorageTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__JobStorageTests = [
        ("testStringRepresentationIsValidJSON", testStringRepresentationIsValidJSON),
    ]
}

extension JobsConfigTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__JobsConfigTests = [
        ("testAddingAlreadyRegistratedJobsAreIgnored", testAddingAlreadyRegistratedJobsAreIgnored),
        ("testAddingJobs", testAddingJobs),
        ("testScheduledJob", testScheduledJob),
    ]
}

extension JobsTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__JobsTests = [
        ("testStub", testStub),
    ]
}

extension QueueNameTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__QueueNameTests = [
        ("testKeyIsGeneratedCorrectly", testKeyIsGeneratedCorrectly),
    ]
}

extension RecurrenceRuleConstraintTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RecurrenceRuleConstraintTests = [
        ("testRecurrenceRuleConstraintCreationRange", testRecurrenceRuleConstraintCreationRange),
        ("testRecurrenceRuleConstraintCreationSetMultipleValues", testRecurrenceRuleConstraintCreationSetMultipleValues),
        ("testRecurrenceRuleConstraintCreationSetSingleValue", testRecurrenceRuleConstraintCreationSetSingleValue),
        ("testRecurrenceRuleConstraintCreationStep", testRecurrenceRuleConstraintCreationStep),
    ]
}

extension RecurrenceRuleTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__RecurrenceRuleTests = [
        ("testLastDayOfMonth", testLastDayOfMonth),
        ("testLastDayOfMonthSimple", testLastDayOfMonthSimple),
        ("testNextDateWhere", testNextDateWhere),
        ("testNextDateWhereSimple", testNextDateWhereSimple),
        ("testReccurrenceRuleEvaluationSimple", testReccurrenceRuleEvaluationSimple),
        ("testReccurrenceRuleEvaluationStepNotDivisible", testReccurrenceRuleEvaluationStepNotDivisible),
        ("testReccurrenceRuleEvaluationStepSimple", testReccurrenceRuleEvaluationStepSimple),
        ("testReccurrenceRuleEvaluationTimezone", testReccurrenceRuleEvaluationTimezone),
        ("testResolveNextDateThatSatisfiesRule", testResolveNextDateThatSatisfiesRule),
        ("testResolveNextDateThatSatisfiesRuleImpossible", testResolveNextDateThatSatisfiesRuleImpossible),
        ("testResolveNextDateThatSatisfiesRuleLeapYear", testResolveNextDateThatSatisfiesRuleLeapYear),
    ]
}

extension SchedulerTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SchedulerTests = [
        ("testConfiguration", testConfiguration),
        ("testScheduleEvaluationDaily", testScheduleEvaluationDaily),
        ("testScheduleEvaluationHourly", testScheduleEvaluationHourly),
        ("testScheduleEvaluationMonthly", testScheduleEvaluationMonthly),
        ("testScheduleEvaluationWeekly", testScheduleEvaluationWeekly),
        ("testScheduleEvaluationYearly", testScheduleEvaluationYearly),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DateComponentRetrievalTests.__allTests__DateComponentRetrievalTests),
        testCase(JobStorageTests.__allTests__JobStorageTests),
        testCase(JobsConfigTests.__allTests__JobsConfigTests),
        testCase(JobsTests.__allTests__JobsTests),
        testCase(QueueNameTests.__allTests__QueueNameTests),
        testCase(RecurrenceRuleConstraintTests.__allTests__RecurrenceRuleConstraintTests),
        testCase(RecurrenceRuleTests.__allTests__RecurrenceRuleTests),
        testCase(SchedulerTests.__allTests__SchedulerTests),
    ]
}
#endif
