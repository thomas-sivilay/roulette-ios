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
let middleCoordinate = CGPoint(x: wheelBackground.frame.width / 2, y: wheelBackground.frame.height / 2)

var coordinates: [CGPoint] = []

for i in 0..<nbChoices {
    print(i)
    let angle: Double = Double(i) * Double(360) / Double(nbChoices)
    print (angle)
    let radAngle = angle * M_PI / 180.0
    var point = CGPoint.zero
    point.x = CGFloat(Double(middleCoordinate.x) + r * cos(radAngle))
    point.y = CGFloat(Double(middleCoordinate.y) + r * sin(radAngle))
    coordinates.append(point)
    print(point)
}

var colors: [UIColor] = [.yellow, .blue, .green, .orange, .purple]

let ctx = UIGraphicsGetCurrentContext();
var startAngle = coordinates.first!
var i = 0
for coordinate in coordinates {
    let shape = CAShapeLayer()
    wheelBackground.layer.addSublayer(shape)
    shape.opacity = 1
    shape.lineWidth = 2
    shape.lineJoin = kCALineJoinMiter
    shape.fillColor = colors[i].cgColor
    
    let path = UIBezierPath()
    path.move(to: startAngle)
    path.addLine(to: coordinate)
    path.addLine(to: middleCoordinate)
    path.close()
    
    shape.path = path.cgPath
    i = i + 1
    startAngle = coordinate
}

let fullRotation = CGFloat(Float.pi * 2)

UIView.animate(withDuration: 2.0, delay: 2.0, animations: {
    UIView.setAnimationRepeatCount(1000)
    wheelBackground.transform = CGAffineTransform(rotationAngle: 3.13)
})

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true

