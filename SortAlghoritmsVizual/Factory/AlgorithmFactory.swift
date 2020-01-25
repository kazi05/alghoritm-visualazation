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
    case selection = "Сортировка выбором"
    case quick = "Быстрая сортировка"
    
    var type: Algorithm {
        switch self {
        case .insertion: return InsertionSort()
        case .selection: return SelectionSort()
        case .quick: return QuickSort()
        }
    }
}

class AlgorithmFactory {
    
    public static func getAlgorithm(of type: SortType) -> Algorithm {
        
        switch type {
        case .insertion: return InsertionSort()
        case .selection: return SelectionSort()
        case .quick: return QuickSort()
        }
        
    }
    
}
