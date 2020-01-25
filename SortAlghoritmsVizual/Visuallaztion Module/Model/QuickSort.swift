//
//  QuickSort.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 26/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class QuickSort: QueueOperation, Algorithm {
    var swapCompletion: SwapCompletion?
    
    var sortCompleted: SortCompleted?
    
    func startSort(array: Array<Int>) {
        var items = array
        
        operationBlock(execute: { [unowned self] in
//            items.shuffle()
            
            self.sort(original: &items, low: 0, high: items.count - 1)
        }) { [unowned self] in
            self.sortCompleted?(true)
        }
    }
    
    private func sort(original: inout [Int], low: Int, high: Int) {
        
        if high <= low { return }
        
        let j = partition(original: &original , low: low, high: high)
        sort(original: &original, low: low, high: j - 1)
        sort(original: &original, low: j + 1, high: high)
    }
    
    private func partition(original: inout [Int], low: Int, high: Int) -> Int {
        var i = low
        var j = high + 1
        let v = original[low]
        
        while true {
            usleep(loopIterationDelay)
            i += 1
            while original[i] < v {
                i += 1
                if i == high {
                    break
                }
            }
            
            j -= 1
            while v < original[j] {
                j -= 1
                if j == low {
                    break
                }
            }
            
            if i >= j {
                break
            }
            
            original.swapItems(itemAtIndex: i, withItemAtIndex: j)
            swapCompletion?(i, j)
        }
        
        original.swapItems(itemAtIndex: low, withItemAtIndex: j)
        swapCompletion?(low, j)
        
        return j
    }
}
