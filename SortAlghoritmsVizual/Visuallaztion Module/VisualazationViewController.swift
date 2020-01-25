//
//  VisualazationViewController.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import UIKit

class VisualazationViewController: UIViewController {
    
    private let presenter = VisualzationPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
    }

}

// MARK: - View methods

extension VisualazationViewController: VisualzationView {
    
}
