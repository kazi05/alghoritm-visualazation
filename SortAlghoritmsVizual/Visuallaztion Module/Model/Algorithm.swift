//
//  Alghoritm.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

typealias SwapCompletion = ((_ high: Int, _ low: Int) -> Void)
typealias SortCompleted = ((Bool) -> Void)

protocol Algorithm {
    var swapCompletion: SwapCompletion? { get set }
    var sortCompleted: SortCompleted? { get set }
    func startSort(array: Array<Int>)
}
