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
    @IBOutlet weak var algorithmsPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(view: self)
        
        viewsCountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        algorithmsPickerView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
        configureSortAnimationView()
    }
    
    @IBAction func actionStartCancelSorting(_ sender: Any) {
        isSorting.toggle()
    }
    
    private func handleStartOrCancelSorting() {
        startCancelButton.isEnabled = isSorting
        
        if !isSorting {
            presenter.startSorting()
        }
    }
    
    @IBAction func actionAplyViewCount(_ sender: Any) {
        guard let countText = viewsCountTextField.text,
                let viewsCount = Int(countText) else { return }
        aplyButton.isEnabled = false
        presenter.setViewsCount(count: viewsCount)
    }
    
}

// MARK: - @objc selector observe

fileprivate extension VisualazationViewController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let number = Int(textField.text!), number <= 5 || textField.text?.count ?? 0 > 4 {
            aplyButton.isEnabled = false
        }
        
        aplyButton.isEnabled = true
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
        aplyButton.isEnabled = false
    }
    
}

// MARK: - UIPickerView delegate and data source

extension VisualazationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.getNumberOfTypes()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.getSortTypeTitle(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sortAlgorithm = presenter.getSortTypeAlgorithm(at: row)
        sortAnimationView.set(algorithm: sortAlgorithm)
    }
    
}

// MARK: - VisualazationAnimationView config

fileprivate extension VisualazationViewController {
    
    func configureSortAnimationView() {
        sortAnimationView.viewsCount = 100
        
        sortAnimationView.completion = { [unowned self] completed in
            self.isSorting = false
        }
        
        let initialAlgorithm = presenter.getSortType(at: 0)
        let insertionSort = AlgorithmFactory.getAlgorithm(of: initialAlgorithm)
        sortAnimationView.set(algorithm: insertionSort)
    }
}

// MARK: - View methods

extension VisualazationViewController: VisualzationView {
    
    func startSorting() {
        sortAnimationView.startSorting()
    }
    
    func setViewsCount(count: Int) {
        sortAnimationView.viewsCount = count
    }
    
}
