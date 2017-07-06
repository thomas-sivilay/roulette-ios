import UIKit
import PlaygroundSupport
import UIWheel
import SpriteKit

class ViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    let wheelView = UIWheel(frame: CGRect(x: 20, y: 20, width: 320, height: 320))
    var tap: UITapGestureRecognizer?
    var pan: UIPanGestureRecognizer?
    
    func setUp() {
        view.backgroundColor = .white
        
        wheelView.backgroundColor = .black
        wheelView.choices = ["1", "2", "3", "4", "5", "6"]
        view.addSubview(wheelView)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGestureTapped(recognizer:)))
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGestureTapped(recognizer:)))
        
        wheelView.addGestureRecognizer(tap!)
        wheelView.addGestureRecognizer(pan!)
    }
    
    @objc
    func tapGestureTapped(recognizer: UITapGestureRecognizer) {
        wheelView.animate()
    }
    
    @objc
    func panGestureTapped(recognizer: UIPanGestureRecognizer) {
        let t = recognizer.velocity(in: self.view)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            let xPoints = wheelView.frame.width
            let velocityX = t.x
            let duration = Double(abs(xPoints / velocityX))
            print(duration)
            wheelView.animate(with: duration)
        }
    }
}

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
