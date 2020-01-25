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
    @IBOutlet weak var sortAnimationView: VisualazationAnimationView!
    @IBOutlet weak var aplyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
        
        viewsCountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        sortAnimationView.viewsCount = 20
        
        sortAnimationView.completion = { [unowned self] completed in
            self.isSorting = false
        }
        
        let insertionSort = AlgorithmFactory.getAlgorithm(of: .insertion)
        sortAnimationView.set(algorithm: insertionSort)
    }
    
    @IBAction func actionStartCancelSorting(_ sender: Any) {
        isSorting.toggle()
    }
    
    private func handleStartOrCancelSorting() {
        let buttonString = !isSorting ? "Отмена" : "Начать"
        startCancelButton.setTitle(buttonString, for: .normal)
        
        if !isSorting {
            presenter.startSorting()
        } else {
            presenter.cancelSorting()
        }
    }
    
    @IBAction func actionAplyViewCount(_ sender: Any) {
        guard let countText = viewsCountTextField.text,
                let viewsCount = Int(countText) else { return }
        
        presenter.setViewsCount(count: viewsCount)
    }
    
}

// MARK: - @objc selector observe

fileprivate extension VisualazationViewController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text == "0" || textField.text?.count ?? 0 > 4 {
            aplyButton.isEnabled = false
        }
        
        aplyButton.isEnabled = true
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }
    
}

// MARK: - View methods

extension VisualazationViewController: VisualzationView {
    
    func startSorting() {
        sortAnimationView.startSorting()
    }
    
    func cancelSorting() {
        sortAnimationView.cancel()
    }
    
    func setViewsCount(count: Int) {
        sortAnimationView.viewsCount = count
    }
    
}
