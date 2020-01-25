//
//  AlgorithmFactory.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

enum SortType: String {
    case insertion = "Сортировка вставками"
}

class AlgorithmFactory {
    
    public static func getAlgorithm(of type: SortType) -> Algorithm {
        
        switch type {
        case .insertion: return InsertionSort()
        }
        
    }
    
}
