import Foundation
import Vapor
import NIO

/// A `Service` used to dispatch `Jobs`
public struct QueueService {
    
    /// See `JobsProvider`.`refreshInterval`
    let refreshInterval: TimeAmount
    
    /// See `JobsProvider`.`persistenceLayer`
    let persistenceLayer: JobsPersistenceLayer
    
    /// See `JobsProvider`.`persistenceKey`
    let persistenceKey: String
    
    /// Dispatches a job to the queue for future execution
    ///
    /// - Parameters:
    ///   - jobData: The `JobData` to dispatch to the queue
    ///   - maxRetryCount: The number of retries to attempt upon error before calling `Job`.`error()`
    ///   - queue: The queue to run this job on
    ///   - delay: A date to execute the job after
    /// - Returns: A future `Void` value used to signify completion
    public func dispatch<J: JobData>(
        jobData: J,
        maxRetryCount: Int = 0,
        queue: QueueName = .default,
        delayUntil: Date? = nil
    ) throws -> EventLoopFuture<Void> {
        let data = try JSONEncoder().encode(jobData)
        let jobStorage = JobStorage(key: persistenceKey,
                                    data: data,
                                    maxRetryCount: maxRetryCount,
                                    id: UUID().uuidString,
                                    jobName: J.jobName,
                                    delayUntil: delayUntil)
        
        return persistenceLayer.set(key: queue.makeKey(with: persistenceKey), jobStorage: jobStorage).map({})
    }
}
