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
    
    private var isSorting = false {
        willSet {
            handleStartOrCancelSorting()
        }
    }
    
    @IBOutlet weak var viewsCountTextField: UITextField!
    @IBOutlet weak var startCancelButton: UIButton!
    @IBOutlet weak var sortAnimationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
    }
    
    @IBAction func actionStartCancelSorting(_ sender: Any) {
        
    }
    
    private func handleStartOrCancelSorting() {
        let buttonString = !isSorting ? "Отмена" : "Начать"
        startCancelButton.setTitle(buttonString, for: .normal)
        
        if !isSorting {
            sortAnimationView.
        }
    }
    

}

// MARK: - View methods

extension VisualazationViewController: VisualzationView {
    
}
