//
//  UIWheelAnimator.swift
//  UIWheel
//
//  Created by Thomas Sivilay on 7/6/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import UIKit

protocol UIWheelAnimator {
    var animateLayer: CALayer { get }
    func animate()
}

final class UIWheelDefaultAnimator: UIWheelAnimator {
    
    // MARK: - Properties
    
    var animateLayer: CALayer
    var choices: Int
    
    // MARK: - Initializer
    
    init(animateLayer: CALayer, choices: Int) {
        self.animateLayer = animateLayer
        self.choices = choices
    }
    
    // MARK: - Methods
    
    func animate() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        let angle = Double(360 / choices)
        let radAngle = Double(angle * .pi / 180.0)
        let random = Double(randomInt(min: 10, max: 30))
        let value = radAngle * random
        
        rotationAnimation.toValue = NSNumber(value: value)
        rotationAnimation.duration = 4
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = 1
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.timingFunction =
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rotationAnimation.isRemovedOnCompletion = false
        animateLayer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    // MARK: Private
    
    private func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}
