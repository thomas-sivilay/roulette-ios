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
    func animate(duration: Float, velocity: Float)
    func animate(velocity: Float)
    func animate()
}

final class UIWheelDefaultAnimator: UIWheelAnimator {
    
    // MARK: - Nested
    
    struct Constants {
        static let defaultAnimationDuration: Float = 3
        static let defaultAnimationVelocity: Float = 10
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
        animate(duration: Constants.defaultAnimationDuration, velocity: Constants.defaultAnimationVelocity)
    }
    
    func animate(velocity: Float) {
        animate(duration: Constants.defaultAnimationDuration, velocity: velocity)
    }
    
    func animate(duration: Float, velocity: Float) {
        let rotationAngle = getRandomAngle(with: choices, velocity: velocity)
        let currentAngle = animateLayer.value(forKeyPath: Constants.rotationAnimationKeyPath) as? Double
        let rotationAnimation = makeRotationAnimation(fromValue: currentAngle!, byValue: rotationAngle, duration: duration)
        animateLayer.setValue(currentAngle! + Double(rotationAngle), forKeyPath: Constants.rotationAnimationKeyPath)
        animateLayer.add(rotationAnimation, forKey: Constants.rotationAnimationKey)
    }
    
    // MARK: Private
    
    private func makeRotationAnimation(fromValue: Double, byValue: Double, duration: Float) -> CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: Constants.rotationAnimationKeyPath)
        
        rotationAnimation.fromValue = fromValue
        rotationAnimation.byValue = byValue
        rotationAnimation.duration = Double(duration)
        rotationAnimation.timingFunction =
            CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        return rotationAnimation
    }
    
    private func getRandomAngle(with nbChoices: Int, velocity: Float) -> Double {
        let angle = Double(360 / nbChoices)
        let radAngle = Double(angle * .pi / 180.0)
        let random = Double(randomInt(min: nbChoices * 2, max: Int(Float(nbChoices * 2) + velocity)))
        
        return radAngle * random
    }
    
    private func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}
