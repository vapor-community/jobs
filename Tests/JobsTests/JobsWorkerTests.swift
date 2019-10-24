//
//  JobsWorkerTests.swift
//  Jobs
//
//  Created by Jimmy McDermott on 2019-08-05.
//

import XCTest
import NIO
import Logging
@testable import Jobs

final class JobsWorkerTests: XCTestCase {
    
    func testScheduledJob() throws {
        let elg = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let expectation = XCTestExpectation(description: "Waits for scheduled job to be completed")
        var config = JobsConfiguration()
        
        guard let minute = Date().minute() else { XCTFail("Can't get date minute"); return }
        
        config.schedule(DailyCleanupScheduledJob(expectation: expectation))
            .hourly()
            .at(.init(minute + 1))
        
        let context = JobContext(eventLoopGroup: elg, preference: .indifferent)
        let logger = Logger(label: "com.vapor.codes.jobs.tests")
        let worker = ScheduledJobsWorker(configuration: config,
                                         context: context,
                                         logger: logger,
                                         on: elg)
        try worker.start()
        
        XCTAssertEqual(worker.scheduledJobs.count, 1)
        wait(for: [expectation], timeout: 61)

        sleep(2)
        
        // Assert that the job gets rescheduled for next hour
        XCTAssertEqual(worker.scheduledJobs.count, 2)
        
        worker.shutdown()
    }
}

struct DailyCleanupScheduledJob: ScheduledJob {
    let expectation: XCTestExpectation
    
    func run(context: JobContext) -> EventLoopFuture<Void> {
        expectation.fulfill()
        return context.eventLoop.makeSucceededFuture(())
    }
}
