//
//  SelectionSort.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class SelectionSort: QueueOperation, Algorithm {
    
    var swapCompletion: SwapCompletion?
    
    var sortCompleted: SortCompleted?
    
    func startSort(array: Array<Int>) {
        var items = array
        let length = items.count
        
        operationBlock(execute: { [unowned self] in
            
            for i in 0..<length {
                usleep(loopIterationDelay)
                
                var minIndex = i
                for j in i+1..<length {
                    if items[j] < items[minIndex] {
                        minIndex = j
                    }
                }
                
                items.swapItems(itemAtIndex: i, withItemAtIndex: minIndex)
                self.swapCompletion?(minIndex, i)
            }
            
        }) { [unowned self] in
            self.sortCompleted?(true)
        }
    }
}
