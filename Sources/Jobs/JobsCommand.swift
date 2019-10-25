import Foundation
import Vapor

/// The command to start the Queue job
public final class JobsCommand: Command {
    /// See `Command.signature`
    public let signature = Signature()
    
    /// See `Command.Signature`
    public struct Signature: CommandSignature {
        public init() { }
        
        @Option(name: "queue", short: "Q", help: "Specifies a single queue to run")
        var queue: String?
        
        @Option(name: "scheduled", short: "S", help: "Runs the scheduled jobs")
        var scheduledJobs: Bool?
    }
    
    /// See `Command.help`
    public var help: String {
        return "Starts the Vapor Jobs worker"
    }
    
    private let application: Application
    private var workers: [JobsWorker]?
    private var scheduledWorkers: [ScheduledJobsWorker]?
    private let scheduled: Bool

    /// Create a new `JobsCommand`
    init(application: Application, scheduled: Bool = false) {
        self.application = application
        self.scheduled = scheduled
    }

    public func run(using context: CommandContext, signature: JobsCommand.Signature) throws {
        let signalQueue = DispatchQueue(label: "vapor.jobs.command.SignalHandlingQueue")
        
        //SIGTERM
        let termSignalSource = DispatchSource.makeSignalSource(signal: SIGTERM, queue: signalQueue)
        termSignalSource.setEventHandler {
            print("Shutting down remaining jobs.")
            self.shutdown()
            termSignalSource.cancel()
        }
        signal(SIGTERM, SIG_IGN)
        termSignalSource.resume()
        
        //SIGINT
        let intSignalSource = DispatchSource.makeSignalSource(signal: SIGINT, queue: signalQueue)
        intSignalSource.setEventHandler {
            print("Shutting down remaining jobs.")
            self.shutdown()
            intSignalSource.cancel()
        }
        signal(SIGINT, SIG_IGN)
        intSignalSource.resume()
        
        let isScheduledFromCli = signature.scheduledJobs ?? false
        
        // shutdown future
        let promise = self.application.make(EventLoopGroup.self).next().makePromise(of: Void.self)
        self.application.running = .start(using: promise)
        
        if isScheduledFromCli || self.scheduled {
            context.console.info("Starting scheduled jobs worker")
            try self.startScheduledWorker().cascade(to: promise)
        } else {
            let queue: JobsQueue = signature.queue
                .flatMap { .init(name: $0) } ?? .default
            context.console.info("Starting jobs worker")
            try self.startJobsWorker(on: queue).cascade(to: promise)
        }
    }
    
    private func startJobsWorker(on queue: JobsQueue) throws -> EventLoopFuture<Void> {
        let eventLoopGroup = self.application.make(EventLoopGroup.self)
        var workers: [JobsWorker] = []
        for eventLoop in eventLoopGroup.makeIterator() {
            let worker = JobsWorker(
                configuration: self.application.make(),
                driver: self.application.make(),
                logger: self.application.make(),
                on: eventLoop
            )
            worker.start(on: queue)
            workers.append(worker)
        }

        self.workers = workers
        return .andAllComplete(
            workers.map { $0.onShutdown },
            on: eventLoopGroup.next()
        )
    }
    
    private func startScheduledWorker() throws -> EventLoopFuture<Void> {
        let eventLoopGroup = self.application.make(EventLoopGroup.self)
        var scheduledWorkers: [ScheduledJobsWorker] = []
        for eventLoop in eventLoopGroup.makeIterator() {
            let worker = ScheduledJobsWorker(
                configuration: self.application.make(),
                logger: self.application.make(),
                on: eventLoop
            )
            try worker.start()
            scheduledWorkers.append(worker)
        }

        self.scheduledWorkers = scheduledWorkers
        return .andAllComplete(
            scheduledWorkers.map { $0.onShutdown },
            on: eventLoopGroup.next()
        )
    }

    private func shutdown() {
        if let workers = workers {
            workers.forEach { worker in
                worker.shutdown()
            }
        }
        
        if let scheduledWorkers = scheduledWorkers {
            scheduledWorkers.forEach { worker in
                worker.shutdown()
            }
        }
    }
}
