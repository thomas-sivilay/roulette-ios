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
        drawSliceShapeLayers(with: computedPoints(for: choices), on: layer)
    }
    
    private func drawSliceShapeLayers(with points: [CGPoint], on layer: CALayer) {
        guard var lastPoint = points.last else {
            return
        }
        
        var colors: [UIColor] = [.blue, .cyan, .green, .orange, .purple, .magenta, .brown]
        let unrelativeCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        for (index, point) in points.enumerated() {
            let path = makeBezierPath(for: lastPoint, point, unrelativeCenter)
            let shape = makeShapeLayer(with: path.cgPath, of: colors[index].cgColor)
            layer.addSublayer(shape)
            lastPoint = point
        }
    }
    
    private func makeShapeLayer(with path: CGPath, of color: CGColor) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.opacity = 1
        shape.lineWidth = 1
        shape.lineJoin = kCALineJoinMiter
        shape.fillColor = color
        shape.path = path
        
        return shape
    }
    
    private func makeBezierPath(for points: CGPoint...) -> UIBezierPath {
        let path = UIBezierPath()
        
        guard let first = points.first else {
            return path
        }
        
        path.move(to: first)
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        path.close()
        
        return path
    }
    
    private func computedPoints(for choices: [String]) -> [CGPoint] {
        let r: Double = Double(frame.width)
        let unrelativeCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
        var points: [CGPoint] = []
        let shift = shiftAlignment.degrees()
        
        for i in 0..<choices.count {
            points.append(makePoint(at: i, outOf: choices.count, shift: shift, center: unrelativeCenter, r: r))
        }
        
        return points
    }
    
    private func makePoint(at index: Int, outOf: Int, shift: Int, center: CGPoint, r: Double) -> CGPoint {
        let angle: Double = Double(shift + (360 / outOf / 2) + (index * 360 / outOf))
        let radAngle = angle * .pi / 180.0
        
        return CGPoint(x: CGFloat(Double(center.x) + r * cos(radAngle)),
                       y: CGFloat(Double(center.y) + r * sin(radAngle)))
    }
    
    private func cleanSublayers() {
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
}
