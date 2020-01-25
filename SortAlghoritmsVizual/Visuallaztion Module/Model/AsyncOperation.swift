//
//  AsyncOperation.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 26/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    
    private var operation: (() -> Void)?
    
    init(_ block: @escaping () -> Void) {
        self.operation = block
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        operation?()
    }
}
