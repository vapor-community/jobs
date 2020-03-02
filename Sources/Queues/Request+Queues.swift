import Foundation
import Vapor
import NIO

extension Request {
    /// Deprecated `Jobs` object
    @available(*, unavailable, renamed: "queue")
    public var jobs: Queue {
        self.queue
    }

    /// The `JobsQueue` object
    public var queue: Queue {
        self.queues(.default)
    }
    
    /// A jobs queue for a specific queue name
    /// - Parameter queue: The queue name
    public func queues(_ queue: QueueName) -> Queue {
        self.application.queues.queue(
            queue,
            logger: self.logger,
            on: self.eventLoop
        )
    }
}
