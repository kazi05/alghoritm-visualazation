//
//  DispatchQueueOperation.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class QueueOperation {
    
    private lazy var operationQueue: OperationQueue = {
      var queue = OperationQueue()
      queue.name = "Sort loop queue"
      queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
      return queue
    }()
    
    private var operation: AsyncOperation?
    
    func operationBlock(execute block: @escaping () -> Void, completion: @escaping () -> Void) {
        operation = AsyncOperation(block)
        
        operation?.completionBlock = {
            DispatchQueue.main.async {
                completion()
            }
        }
        
        operationQueue.addOperation(operation!)
    }
    
}
