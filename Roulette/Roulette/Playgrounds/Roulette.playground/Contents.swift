import UIKit
import PlaygroundSupport
import UIWheel

let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.backgroundColor = .white

let wheelView = UIWheel(frame: CGRect(x: 20, y: 20, width: 460, height: 460))
wheelView.backgroundColor = .black
view.addSubview(wheelView)

let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
rotationAnimation.toValue = NSNumber(value: Double.pi * 2 * 10)
rotationAnimation.duration = 5
rotationAnimation.isCumulative = true
rotationAnimation.repeatCount = 1
rotationAnimation.timingFunction =
    CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
wheelView.layer.add(rotationAnimation, forKey: "rotationAnimation")

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
