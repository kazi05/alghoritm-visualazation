//
//  SelectionSort.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class SelectionSort: DispatchQueueOperation, Algorithm {
    
    var swapCompletion: SwapCompletion?
    
    var sortCompleted: SortCompleted?
    
    func startSort(array: Array<Int>) {
        
        workItem { [unowned self] in
            let length = array.count
            
            for i in 0..<length {
                self.dispatchGroup.enter()
                var minIndex = i
                for j in i+1..<length {
                    usleep(1000)
                    if array[j] < array[minIndex] {
                        minIndex = j
                    }
                }
                self.swapCompletion?(i, minIndex)
                self.dispatchGroup.leave()
                self.dispatchGroup.wait()
            }
            
            self.dispatchGroup.notify(queue: .main) {
                self.sortCompleted?(true)
            }
        }
    }
    
    func cancel() {
        cancelOperation()
    }
}
