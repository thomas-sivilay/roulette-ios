//
//  UIWheel.swift
//  UIWheel
//
//  Created by Thomas Sivilay on 7/4/17.
//  Copyright © 2017 Thomas Sivilay. All rights reserved.
//

import Foundation

public final class UIWheel: UIView, UIWheelAnimatable {
    
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
            animator = UIWheelDefaultAnimator(animateLayer: animatingLayer, choices: choices.count)
            drawSublayers()
        }
    }
    
    var animator: UIWheelAnimator
    var animatingLayer = CALayer()
    var fixedLayer = CALayer()
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        self.choices = ["1", "2", "3", "4"]
        self.shiftAlignment = .bottom
        self.animator = UIWheelDefaultAnimator(animateLayer: animatingLayer, choices: choices.count)
        super.init(frame: frame)
        setUp()
        drawSublayers()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    public func animate() {
        animator.animate()
    }
    
    // MARK: Private
        
    private func setUp() {
        let frame = CGRect(x: 0, y: 0, width: layer.frame.width, height: layer.frame.height)
        animatingLayer.frame = frame
        fixedLayer.frame = frame
        
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
    }
    
    private func addSublayers() {
        layer.addSublayer(animatingLayer)
        layer.addSublayer(fixedLayer)
    }
    
    private func drawSublayers() {
        cleanSublayers()
        addSublayers()
        drawSliceShapeLayers(with: computedPoints(for: choices), on: animatingLayer)
        drawCursorLayer(on: fixedLayer)
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
    
    private func drawCursorLayer(on layer: CALayer) {
        let height = frame.height / 10
        let width = frame.width / 10
        let top = CGPoint(x: frame.width / 2, y: frame.height - height)
        let bottomLeft = CGPoint(x: frame.width / 2 - width / 2, y: frame.height)
        let bottomRight = CGPoint(x: frame.width / 2 + width / 2, y: frame.height)
        let path = makeBezierPath(for: top, bottomLeft, bottomRight)
        let shape = makeShapeLayer(with: path.cgPath, of: UIColor.black.cgColor)
        layer.addSublayer(shape)
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
        let r = Double(frame.width)
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
