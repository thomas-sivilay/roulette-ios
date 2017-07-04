//
//  UIWheel.swift
//  UIWheel
//
//  Created by Thomas Sivilay on 7/4/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public final class UIWheel: UIView {
    
    // MARK: - Properties
    
    public var choices: [String] {
        didSet {
            // draw
        }
    }
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        self.choices = ["1", "2", "3", "4"]
        super.init(frame: frame)
        setUp()
        drawSliceSublayers()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    // MARK: - Methods
    
    private func setUp() {
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
    }
    
    private func drawSliceSublayers() {
        let r: Double = Double(frame.width)
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        var coordinates: [CGPoint] = []
        var colors: [UIColor] = [.yellow, .blue, .green, .orange, .purple]
        
        for i in 0..<choices.count {
            let angle: Double = Double(i) * Double(360) / Double(choices.count)
            let radAngle = angle * .pi / 180.0
            var point = CGPoint.zero
            point.x = CGFloat(Double(center.x) + r * cos(radAngle))
            point.y = CGFloat(Double(center.y) + r * sin(radAngle))
            coordinates.append(point)
        }
        
        var startAngle = coordinates.first!
        var i = 0
        for coordinate in coordinates {
            let shape = CAShapeLayer()
            layer.addSublayer(shape)
            shape.opacity = 1
            shape.lineWidth = 2
            shape.lineJoin = kCALineJoinMiter
            shape.fillColor = colors[i].cgColor
            
            let path = UIBezierPath()
            path.move(to: startAngle)
            path.addLine(to: coordinate)
            path.addLine(to: center)
            path.close()
            
            shape.path = path.cgPath
            i = i + 1
            startAngle = coordinate
        }
    }
}
