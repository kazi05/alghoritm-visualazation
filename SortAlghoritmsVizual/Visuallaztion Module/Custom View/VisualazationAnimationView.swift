//
//  VisualazationAnimationView.swift
//  SortAlghoritmsVizual
//
//  Created by Kazim Gadjiev on 25/01/2020.
//  Copyright © 2020 Kazim Gadjiev. All rights reserved.
//

import UIKit

class VisualazationAnimationView: UIView {
    
    var viewsCount = 100 {
        didSet {
            setIndexes()
        }
    }
    
    private(set) var algorithm: Algorithm?
    
    private var indexesArray = [Int]()
    private var visualViews: [VisualView] = []
    private var sortCompleted = false
    private var sortProcessing = false
    
    override func draw(_ rect: CGRect) {
        if indexesArray.isEmpty && !sortCompleted {
            return
        }
        
        setIndexLayers(rect: rect)
    }
    
    func set(algorithm: Algorithm) {
        self.algorithm = algorithm
        
        self.algorithm?.swapCompletion = { [unowned self] (high, low) in
            self.indexesArray.swapItems(itemAtIndex: high, withItemAtIndex: low)
            self.visualViews.swapItems(itemAtIndex: high, withItemAtIndex: low)
            let lowLayer = self.visualViews[low]
            let highLayer = self.visualViews[high]
            self.swapLayers(firstLayer: lowLayer, secondLayer: highLayer)
        }
        
        self.algorithm?.sortCompleted = { [unowned self] completed in
            self.sortCompleted = completed
            self.sortProcessing = false
        }
    }
    
    func startSorting() {
        if sortProcessing {
            cancel()
            sortProcessing = false
            return
        }
        
        setIndexes()
        sortProcessing = true
        algorithm?.startSort(array: indexesArray)
    }
    
    private func cancel() {
        if !sortProcessing { return }
        
        algorithm?.cancel()
        setIndexes()
    }
    
    private func setIndexes() {
        indexesArray = []
        indexesArray = (1...viewsCount).shuffled()
        setNeedsDisplay()
    }
    
}

// MARK: - Cusstomizing from draw(_rect)

fileprivate extension VisualazationAnimationView {
    
    func setIndexLayers(rect: CGRect) {
        visualViews.forEach { $0.removeFromSuperlayer() }
        
        let minHeight = rect.height / CGFloat(viewsCount)
        let padding = 1
        let width = rect.width / CGFloat(viewsCount) - CGFloat(padding)
        
        var lastX: CGFloat = 0
        
        for (i, number) in indexesArray.enumerated() {
            
            let initialBound = CGRect(x: CGFloat(i * padding) + lastX, y: 0, width: width, height: 0)
            let finalBound = CGRect(x: CGFloat(i * padding) + lastX, y: rect.height - CGFloat(number) * minHeight, width: width, height: CGFloat(number) * minHeight)
            
            let layer = VisualView(index: number)
            layer.anchorPoint = CGPoint(x: 1, y: 1)
            layer.frame = finalBound
            layer.backgroundColor = UIColor.systemTeal.cgColor
            
            let animation = CABasicAnimation(keyPath: "bounds")
            animation.fromValue = initialBound
            animation.toValue = finalBound
            animation.duration = 0.5
            
            layer.add(animation, forKey: nil)
            visualViews.append(layer)
            self.layer.addSublayer(layer)
            
            lastX += width
            
        }
    }
    
}

// MARK: - CALayer methods

fileprivate extension VisualazationAnimationView {
    
    private func swapLayers(firstLayer: VisualView, secondLayer: VisualView) {
        let firstInitial = firstLayer.frame.origin.x
        let secondInitial = secondLayer.frame.origin.x
        print("Swap layers index: \(firstLayer.index) \(secondLayer.index)")
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        // create new animation
        let anim = CABasicAnimation(keyPath: "frame.origin.x")
        anim.fromValue = firstInitial
        anim.toValue = secondInitial
        anim.duration = 0.2
        anim.fillMode = .forwards
        anim.isRemovedOnCompletion = true
        firstLayer.add(anim, forKey: nil)
        
        //Create second Animation
        let anim2 = CABasicAnimation(keyPath: "frame.origin.x")
        anim2.fromValue = secondInitial
        anim2.toValue = firstInitial
        anim2.duration = 0.2
        anim2.fillMode = .forwards
        anim2.isRemovedOnCompletion = true
        secondLayer.add(anim2, forKey: nil)
        
        CATransaction.setCompletionBlock({
            firstLayer.frame.origin.x = secondInitial
            secondLayer.frame.origin.x = firstInitial
        })
        
        CATransaction.commit()
    }
    
}
