//
//  InsertionSort.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class InsertionSort: QueueOperation, Algorithm {
    
    var swapCompletion: SwapCompletion?
    
    var sortCompleted: SortCompleted?
    
    func startSort(array: Array<Int>) {
        var items = array
        let length = items.count
        
        operationBlock(execute: { [unowned self] in
            
            for i in 1..<length {
                
                for j in stride(from: i, to: 0, by: -1) {
                    usleep(loopIterationDelay)
                    if items[j] < items[j - 1] {
                        items.swapItems(itemAtIndex: j, withItemAtIndex: j - 1)
                        self.swapCompletion?(j, j - 1)
                    } else {
                        break
                    }
                }
            }
        }) { [unowned self] in
            self.sortCompleted?(true)
        }
    }
}
