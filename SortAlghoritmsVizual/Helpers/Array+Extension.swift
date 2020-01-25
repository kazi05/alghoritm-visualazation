//
//  Array+Extension.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

extension Array {
    
    public mutating func swapItems(itemAtIndex firstIndex: Index, withItemAtIndex secondIndex: Index) {
        
        if firstIndex != secondIndex {
            swapAt(firstIndex, secondIndex)
        }
    }
    
    public mutating func shuffle() {
        
        for i in 0..<count {
            self.swapItems(itemAtIndex: i, withItemAtIndex: Array.Index(arc4random_uniform(UInt32(count))))
        }
    }
}
