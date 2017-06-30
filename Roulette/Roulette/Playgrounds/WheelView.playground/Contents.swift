import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.backgroundColor = .white

let wheelBackground = UIView(frame: CGRect(x: 20, y: 20, width: 460, height: 460))
view.addSubview(wheelBackground)
wheelBackground.backgroundColor = .red
wheelBackground.clipsToBounds = true
wheelBackground.layer.cornerRadius = 460 / 2

let choices = [1,2,3,4,5]
let nbChoices = choices.count

let r: Double = 460
let deuxpiR = r * Double.pi
let middleCoordinate = CGPoint(x: wheelBackground.frame.width / 2 + wheelBackground.frame.minX, y: wheelBackground.frame.height / 2 + wheelBackground.frame.minY)



print(view.frame)
print(wheelBackground.frame)

PlaygroundPage.current.liveView = view
//PlaygroundPage.current.needsIndefiniteExecution = true

