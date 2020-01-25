//
//  InsertionSort.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class InsertionSort<T: Comparable>: Algorithm {
    
    typealias Array = T
    
    var swapCompletion: SwapCompletion?
    
    var sortCompleted: SortCompleted?
    
    func startSort(array: inout [T]) {
        var result = array
        
        let length = result.count
        
        for i in 1..<length {
            for j in stride(from: i, to: 0, by: -1) {
                if result[j] < result[j - 1] {
                    result.swapItems(itemAtIndex: j, withItemAtIndex: j - 1)
                } else {
                    break
                }
            }
        }
    }
    
}
