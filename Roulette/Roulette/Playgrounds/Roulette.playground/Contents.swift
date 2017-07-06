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
    var tap: UIGestureRecognizer?
    
    func setUp() {
        view.backgroundColor = .white
        
        wheelView.backgroundColor = .black
        wheelView.choices = ["1", "2", "3", "4", "5", "6"]
        view.addSubview(wheelView)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.sampleTapGestureTapped(recognizer:)))
        wheelView.addGestureRecognizer(tap!)
    }
    
    @objc
    func sampleTapGestureTapped(recognizer: UITapGestureRecognizer) {
        wheelView.animate()
    }
}

let viewController = ViewController()
PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true
