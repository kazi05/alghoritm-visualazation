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
    
    func attach(view: VisualzationView) {
        self.view = view
    }
    
}
