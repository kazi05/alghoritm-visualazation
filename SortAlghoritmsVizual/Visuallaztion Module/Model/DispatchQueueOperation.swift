//
//  DispatchQueueOperation.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class DispatchQueueOperation {
    
    private let queue = DispatchQueue.global(qos: .userInitiated)
    private var workItem: DispatchWorkItem?
    
    let dispatchGroup = DispatchGroup()
    
    func workItem(execute block: @escaping () -> Void) {
        workItem = DispatchWorkItem(block: block)
        
        guard let item = workItem else { return }
        
        queue.async(execute: item)
    }
    
    func cancelOperation() {
        guard let item = workItem else { return }
        
        item.cancel()
        workItem = nil
    }
    
}
