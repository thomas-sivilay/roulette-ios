import UIKit
import PlaygroundSupport

class UIWheelView: UIView {
    
    // MARK: - Properties
    
    var choices: [String]
    
    // MARK: - Initializers
    
    public init(frame: CGRect, choices: [String]) {
        self.choices = choices
        super.init(frame: frame)
        setUp()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setUp() {
        print(frame)
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let angle = Float(360 / choices.count) * .pi / 180.0
        
        for i in 0..<choices.count {
            let view = makeView(with: center, angle: angle, r: frame.width / 2)
            view.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
            addSubview(view)
            print(view)
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Float(i) * angle))
        }
    }
    
    private func makeView(with center: CGPoint, angle: Float, r: CGFloat) -> UIView {
        let p1 = makeP1(with: center, angle: angle, r: Float(r))
        let p2 = makeP2(with: center, p1: p1)
        let frame = CGRect(x: center.x / 2, y: p1.y, width: r, height: p2.y - p1.y)
        let view = UIView(frame: frame)
        let path = makeToto(for: frame, angle: angle, r: Float(r))
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.green.cgColor
        layer.strokeColor = UIColor.red.cgColor
        layer.lineWidth = 1
        layer.frame = CGRect(origin: .zero, size: frame.size)
        layer.path = path.cgPath
        view.layer.addSublayer(layer)
        return view
    }
    
    private func makeP1(with center: CGPoint, angle: Float, r: Float) -> CGPoint {
        let x = Int(cos(angle / 2) * r) + Int(center.x)
        let y = Int(center.y) - Int(sin(angle / 2) * r)
        return CGPoint(x: x, y: y)
    }
    
    private func makeP2(with center: CGPoint, p1: CGPoint) -> CGPoint {
        return CGPoint(x: p1.x, y: center.y + (center.y - p1.y))
    }
    
    private func makeToto(for frame: CGRect, angle: Float, r: Float) -> UIBezierPath {
        let p0 = CGPoint(x: 0, y: frame.height / 2)
        let start = CGFloat(0 - angle / 2)
        let end = CGFloat(0 + angle / 2)
        
        let path = UIBezierPath()
        path.move(to: p0)
        path.addArc(withCenter: p0, radius: CGFloat(r), startAngle: start, endAngle: end, clockwise: true)
        path.addLine(to: p0)
        path.close()
        return path
    }
}

class ViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    var wheelView: UIWheelView!
    var tap: UITapGestureRecognizer?
    var pan: UIPanGestureRecognizer?
    
    func setUp() {
        wheelView = UIWheelView(frame: CGRect(x: 0, y: 0, width: 372, height: 372), choices: ["1", "2", "3", "4", "5", "6"])
        
        wheelView.backgroundColor = .white
        view.addSubview(wheelView)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGestureTapped(recognizer:)))
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGestureTapped(recognizer:)))
        
        wheelView.addGestureRecognizer(tap!)
        wheelView.addGestureRecognizer(pan!)
    }
    
    @objc
    func tapGestureTapped(recognizer: UITapGestureRecognizer) {
    }
    
    @objc
    func panGestureTapped(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
            let t = recognizer.velocity(in: self.view)
            let velocityX = Float(t.y) / 1000
            print(velocityX)
        }
    }
}

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
