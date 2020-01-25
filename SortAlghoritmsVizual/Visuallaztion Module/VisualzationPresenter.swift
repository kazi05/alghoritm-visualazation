//
//  VisualzationPresenter.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import Foundation

class VisualzationPresenter {
    
    private weak var view: VisualzationView?
    
    private var sortTypes: [SortType] = [.insertion, .selection, .quick]
    
    func attach(view: VisualzationView) {
        self.view = view
    }
    
    func startSorting() {
        view?.startSorting()
    }
    
    func setViewsCount(count: Int) {
        view?.setViewsCount(count: count)
    }
    
    func getSortType(at index: Int) -> SortType {
        return sortTypes[index]
    }
    
    func getNumberOfTypes() -> Int {
        return sortTypes.count
    }
    
    func getSortTypeTitle(at index: Int) -> String {
        let type = sortTypes[index]
        return type.rawValue
    }
    
    func getSortTypeAlgorithm(at index: Int) -> Algorithm {
        let type = sortTypes[index]
        return type.type
    }
    
}
