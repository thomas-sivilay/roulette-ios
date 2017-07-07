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
        if recognizer.state == UIGestureRecognizerState.ended {
            let t = recognizer.velocity(in: self.view)
            let velocityX = Float(t.y) / 1000
            print(velocityX)
            wheelView.animate(velocity: velocityX)
        }
    }
}

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
