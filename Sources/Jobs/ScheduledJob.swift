//
//  ScheduledJob.swift
//  
//
//  Created by Jimmy McDermott on 6/11/19.
//

import Foundation
import Vapor

/// Describes a job that can be scheduled and repeated
public protocol ScheduledJob {
    
    /// The method called when the job is run
    /// - Parameter context: A `JobContext` that can be used
    func run(context: JobContext) -> EventLoopFuture<Void>
}
