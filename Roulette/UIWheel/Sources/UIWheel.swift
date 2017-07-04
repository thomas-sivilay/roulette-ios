//
//  UIWheel.swift
//  UIWheel
//
//  Created by Thomas Sivilay on 7/4/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public final class UIWheel: UIView {
    
    // MARK: - Nested
    
    public enum ShiftAlignment {
        case top
        case left
        case right
        case bottom
        case manual(degrees: Int)
        
        func degrees() -> Int {
            switch self {
            case .top:
                return 270
            case .left:
                return 180
            case .bottom:
                return 90
            case .right:
                return 0
            case let .manual(degrees):
                return degrees
            }
        }
    }
    
    // MARK: - Properties
    
    public var shiftAlignment: ShiftAlignment {
        didSet {
            drawSublayers()
        }
    }
    
    public var choices: [String] {
        didSet {
            drawSublayers()
        }
    }
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        self.choices = ["1", "2", "3", "4"]
        self.shiftAlignment = .bottom
        super.init(frame: frame)
        setUp()
        drawSublayers()
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
    
    private func drawSublayers() {
        cleanSublayers()
        drawSliceShapeLayers(with: computedPoints(for: choices))
    }
    
    private func drawSliceShapeLayers(with points: [CGPoint]) {
        guard let last = points.last else {
            return
        }
        
        var colors: [UIColor] = [.blue, .cyan, .green, .orange, .purple, .magenta, .brown]
        var startPoint = last
        var i = 0
        let unrelativeCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        for point in points {
            let shape = CAShapeLayer()
            layer.addSublayer(shape)
            shape.opacity = 1
            shape.lineWidth = 2
            shape.lineJoin = kCALineJoinMiter
            shape.fillColor = colors[i].cgColor
            
            let path = UIBezierPath()
            path.move(to: startPoint)
            path.addLine(to: point)
            path.addLine(to: unrelativeCenter)
            path.close()
            
            shape.path = path.cgPath
            i = i + 1
            startPoint = point
        }
    }
    
    private func computedPoints(for choices: [String]) -> [CGPoint] {
        let r: Double = Double(frame.width)
        let unrelativeCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
        var points: [CGPoint] = []
        
        for i in 0..<choices.count {
            let shift = shiftAlignment.degrees()
            let angle: Double = Double(shift + (360 / choices.count / 2) + (i * 360 / choices.count))
            let radAngle = angle * .pi / 180.0
            var point = CGPoint.zero
            point.x = CGFloat(Double(unrelativeCenter.x) + r * cos(radAngle))
            point.y = CGFloat(Double(unrelativeCenter.y) + r * sin(radAngle))
            points.append(point)
        }
        
        return points
    }
    
    private func cleanSublayers() {
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
}
