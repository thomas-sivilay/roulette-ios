//
//  UIWheelAnimatable.swift
//  UIWheel
//
//  Created by Thomas Sivilay on 7/6/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

protocol UIWheelAnimatable {
    var animator: UIWheelAnimator { get }
    func animate()
}
