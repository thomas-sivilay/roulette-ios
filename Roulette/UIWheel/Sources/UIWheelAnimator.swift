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
    func animate(with duration: Double)
    func animate()
}

final class UIWheelDefaultAnimator: UIWheelAnimator {
    
    // MARK: - Nested
    
    struct Constants {
        static let rotationAnimationKey = "rotationAnimation"
        static let rotationAnimationKeyPath = "transform.rotation.z"
    }
    
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
        animate(with: 3)
    }
    
    func animate(with duration: Double) {
        let rotationAngle = getRandomAngle(with: choices)
        let currentAngle = animateLayer.value(forKeyPath: Constants.rotationAnimationKeyPath) as? Double
        let rotationAnimation = makeRotationAnimation(fromValue: currentAngle!, byValue: rotationAngle, duration: duration)
        animateLayer.setValue(currentAngle! + Double(rotationAngle), forKeyPath: Constants.rotationAnimationKeyPath)
        animateLayer.add(rotationAnimation, forKey: Constants.rotationAnimationKey)
    }
    
    // MARK: Private
    
    private func makeRotationAnimation(fromValue: Double, byValue: Double, duration: Double) -> CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: Constants.rotationAnimationKeyPath)
        
        rotationAnimation.fromValue = fromValue
        rotationAnimation.byValue = byValue
        rotationAnimation.duration = duration
        rotationAnimation.timingFunction =
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return rotationAnimation
    }
    
    private func getRandomAngle(with nbChoices: Int) -> Double {
        let angle = Double(360 / nbChoices)
        let radAngle = Double(angle * .pi / 180.0)
        let random = Double(randomInt(min: 10, max: 30))
        
        return radAngle * random
    }
    
    private func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}
