//
//  InsertionSort.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class InsertionSort: Algorithm {
    
    var swapCompletion: SwapCompletion?
    
    var sortCompleted: SortCompleted?
    
    private let queue = DispatchQueue.global(qos: .userInitiated)
    private let group = DispatchGroup()
    private var workItem: DispatchWorkItem?
    
    func startSort(array: Array<Int>) {
        let length = array.count
        
        workItem = DispatchWorkItem(block: { [unowned self] in
            for i in 1..<length {
                self.group.enter()
                for j in stride(from: i, to: 0, by: -1) {
                    usleep(1000)
                    if array[j] < array[j - 1] {
                        self.swapCompletion?(j, j - 1)
                    } else {
                        break
                    }
                }
                self.group.leave()
                self.group.wait()
            }
            
            self.group.notify(queue: .main) { [unowned self] in
                self.sortCompleted?(true)
            }
        })
        
        guard let item = workItem else { return }
        
        queue.async(execute: item)
    }
    
    func cancel() {
        guard let item = workItem else { return }
        
        item.cancel()
        workItem = nil
    }
    
}
