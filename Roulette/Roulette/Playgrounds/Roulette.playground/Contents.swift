import UIKit
import PlaygroundSupport

class UIWheelView: UIView {
    
    // MARK: - Properties
    
    var choices: [String]
    var pan: UIPanGestureRecognizer?
    var lastRotation: CGFloat = 0
    var dotView: UILabel
    
    // MARK: - Initializers
    
    public init(frame: CGRect, choices: [String]) {
        self.choices = choices
        self.dotView = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.dotView.font = UIFont.systemFont(ofSize: 10)
        self.dotView.backgroundColor = UIColor.cyan
        super.init(frame: frame)
        pan = UIPanGestureRecognizer(target: self, action: #selector(UIWheelView.panGestureTapped(recognizer:)))
        
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
        
        let color: [UIColor] = [.red, .blue, .yellow, .green, .black, .white, .blue, .red, .yellow]
        
        for i in 0..<choices.count {
            let view = makeView(with: center, angle: angle, r: frame.width / 2, color: color[i])
            view.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
            addSubview(view)
            print(view)
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Float(i) * angle))
        }
        
        addGestureRecognizer(pan!)
        addSubview(dotView)
    }
    
    @objc
    func panGestureTapped(recognizer: UIPanGestureRecognizer) {
        let t = recognizer.location(in: self)
        let tt = CGPoint(x: t.x - frame.width / 2, y: -(t.y - frame.height / 2))
        print(tt)
        let angleX = angle(for: tt, in: self)
        let direction = angleX - lastRotation
        let rdirection = Measurement(value: Double(angleX), unit: UnitAngle.radians)
            .converted(to: .degrees).value
        print("T: \(tt.x, tt.y) => \(angleX) - Gonna rotate to: \(rdirection)")
        
        switch recognizer.state {
        case .began:
//            print("BEGIN")
            break
        case .changed:
//            print(velocityX)
            dotView.frame.origin = t
            transform = transform.rotated(by: direction)
            dotView.text = "\(rdirection)"
            lastRotation = angleX
        case .ended:
//            print("END")
            break
        default:
            break
        }
    }
    
    private func angle(for touch: CGPoint, in view: UIView) -> CGFloat {
        var angle: CGFloat = 0
        
        switch (touch.x, touch.y) {
        case (_, 0) where touch.x > 0:
            angle = 0
        case (_, 0) where touch.x < 0:
            angle = CGFloat(Float.pi)
        case (0, _) where touch.y > 0:
            angle = CGFloat(Float.pi / 2)
        case (0, _) where touch.y < 0:
            angle = CGFloat(3 * Float.pi / 2)
        case _ where touch.x > 0 && touch.y > 0:
            angle = atan(touch.y / touch.x)
        case _ where touch.x < 0 && touch.y > 0:
            angle = atan(-touch.x / touch.y) + CGFloat(Float.pi / 2)
        case _ where touch.x < 0 && touch.y < 0:
            angle = atan(-touch.y / -touch.x) + CGFloat(Float.pi)
        case _ where touch.x > 0 && touch.y < 0:
            angle = atan(-touch.x / touch.y) + CGFloat((3 * Float.pi / 2))
        default:
            print("OOPS")
        }
        
        return angle
    }
    
    private func makeView(with center: CGPoint, angle: Float, r: CGFloat, color: UIColor) -> UIView {
        let p1 = makeP1(with: center, angle: angle, r: Float(r))
        let p2 = makeP2(with: center, p1: p1)
        let frame = CGRect(x: center.x / 2, y: p1.y, width: r, height: p2.y - p1.y)
        let view = UIView(frame: frame)
        let path = makeToto(for: frame, angle: angle, r: Float(r))
        let layer = CAShapeLayer()
        layer.fillColor = color.cgColor
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
    
    func setUp() {
        wheelView = UIWheelView(frame: CGRect(x: 0, y: 0, width: 372, height: 372), choices: ["1", "2", "3", "4", "5", "6"])
        
        wheelView.backgroundColor = .white
        view.addSubview(wheelView)
    }
}

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
