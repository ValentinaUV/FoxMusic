//
//  CircularSlider.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 26.07.2022.
//

import UIKit

struct CircularSliderOptions {
  let startAngleDegrees: Double = 180.0
  let endAngleDegrees: Double = 360.0
  let barWidth: CGFloat = 5.0
  let trackingWidth: CGFloat = 5.0
  let barColor: UIColor = .darkGray
  let trackingColor: UIColor = .systemOrange
  let drawThumb: Bool = true
  let thumbWidth: CGFloat = 20
  let thumbColor: UIColor = .systemOrange
  let clockwise: Bool = false
  let drawTrackingGradient: Bool = true
  let trackingFirstColor: UIColor = .systemRed
  let trackingSecondColor: UIColor = .systemYellow
  
//  case thumbImage(UIImage?)
//  case maxValue(Float)
//  case minValue(Float)
//  case sliderEnabled(Bool)
//  case viewInset(CGFloat)
//  case minMaxSwitchTreshold(Float)
//  case thumbPosition(Float)
  
}

public class CircularSlider: UIView {
  
  let options: CircularSliderOptions
  
  init(frame: CGRect, options: CircularSliderOptions) {
    self.options = options
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var centerPoint: CGPoint = {
    let centerPoint = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    return centerPoint
  }()
  
  private lazy var radius: CGFloat = {
    let maxDim = max(bounds.width, bounds.height)
    let radius = maxDim/2 - options.barWidth/2
    return radius
  }()
  
  private lazy var startAngle: CGFloat = {
    let startAngle = CGFloat.degreesToRadians(options.startAngleDegrees)
    return startAngle
  }()
  
  private lazy var endAngle: CGFloat = {
    let endAngle = CGFloat.degreesToRadians(options.endAngleDegrees)
    return endAngle
  }()
  
  private lazy var outlineEndAngle: CGFloat = {
    let angleDiff: CGFloat = 2 * .pi + startAngle - endAngle
    let outlineEndAngle = startAngle - angleDiff * CGFloat(progress)
    return outlineEndAngle
  }()
  
  // PROGRESS: Indicates the percentage with a number between 0 and 1
  var progress: CGFloat = 0.99 {
    didSet {
      if !(0...1).contains(progress) {
        // clamp: if progress is over 1 or less than 0 give it a value between them
        progress = max(0, min(1, progress))
      }
//      setNeedsDisplay()
    }
  }

  // position to be set everytime the progress is updated
  public fileprivate(set) var pointerPosition: CGPoint = CGPoint()
  // boolean which chooses if the knob can be dragged or not
  var canDrag = true
  // variable that stores the lenght of the arc based on the last touch
  var oldLength : CGFloat = 30
  
  // TOUCHES BEGAN: if the touch is near thw pointer let it be possible to be dragged
  override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let firstTouch = touches.first {
      let hitView = self.hitTest(firstTouch.location(in: self), with: event)
      if hitView === self {
        // distance of touch from pointer
        let xDist = CGFloat(firstTouch.preciseLocation(in: hitView).x - pointerPosition.x)
        let yDist = CGFloat(firstTouch.preciseLocation(in: hitView).y - pointerPosition.y)
        let distance = CGFloat(sqrt((xDist * xDist) + (yDist * yDist)))
        canDrag = true
        guard distance < 30 else { return canDrag = false }
      }
    }
  }
  // TOUCHES MOVED: If touchesBegan says that the pointer can be dragged let it be dregged by the touch of the user
  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let firstTouch = touches.first {
      let hitView = self.hitTest(firstTouch.location(in: self), with: event)
      if hitView === self {
        if canDrag == true {
          
          // CONSTANTS TO BE USED
          let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
          let radiusBounds = max(bounds.width, bounds.height)
          let radius = radiusBounds/2 - options.barWidth/2
          let touchX = firstTouch.preciseLocation(in: hitView).x
          let touchY = firstTouch.preciseLocation(in: hitView).y
          
          // FIND THE NEAREST POINT TO THE CIRCLE FROM THE TOUCH POSITION
          let dividendx = pow(touchX, 2) + pow(center.x, 2) - (2 * touchX * center.x)
          let dividendy = pow(touchY, 2) + pow(center.y, 2) - (2 * touchY * center.y)
          let dividend = sqrt(abs(dividendx) + abs(dividendy))
          
          // POINT(x, y) FOUND
          let pointX = center.x + ((radius * (touchX - center.x)) / dividend)
          let pointY = center.y + ((radius * (touchY - center.y)) / dividend)
          
          // ARC LENGTH
          let arcAngle: CGFloat = (2 * .pi) + (.pi / 4) - (3 * .pi / 4)
          let arcLength =  arcAngle * radius
          
          // NEW ARC LENGTH
          let xForTheta = Double(pointX) - Double(center.x)
          let yForTheta = Double(pointY) - Double(center.y)
          var theta : Double = atan2(yForTheta, xForTheta) - (3 * .pi / 4)
          if theta < 0 {
            theta += 2 * .pi
          }
          var newArcLength =  CGFloat(theta) * radius
          
          // CHECK CONDITIONS OF THE POINTER'S POSITION
          if 480.0 ... 550.0 ~= newArcLength { newArcLength = 480 }
          else if 550.0 ... 630.0 ~= newArcLength { newArcLength = 0 }
          if oldLength == 480 && 0 ... 465 ~= newArcLength  { newArcLength = 480 }
          else if oldLength == 0 && 15 ... 480 ~= newArcLength { newArcLength = 0 }
          oldLength = newArcLength
          
          // PERCENTAGE TO BE ASSIGNED TO THE PROGRES VAR
          let newPercentage = newArcLength/arcLength
          progress = CGFloat(newPercentage)
        }
      }
    }
  }

  public override func draw(_ rect: CGRect) {
    
    // bar path
    let _ = drawPath(
      endAngle: endAngle,
      color: options.barColor,
      lineWidth: options.barWidth)
    
    let trackingPath = drawPath(
      endAngle: outlineEndAngle,
      color: options.trackingColor,
      lineWidth: options.trackingWidth)

    renderGradientOnPath(
      path: trackingPath.cgPath,
      pathWidth: options.trackingWidth,
      firstColor: options.trackingFirstColor.cgColor,
      secondColor: options.trackingSecondColor.cgColor,
      end: CGPoint(x: bounds.width, y: bounds.height))
    
    drawThumb(trackingPath: trackingPath)
  }
   
  private func drawPath(endAngle: CGFloat, color: UIColor, lineWidth: CGFloat) -> UIBezierPath {
    let path = UIBezierPath(
      arcCenter: centerPoint,
      radius: radius,
      startAngle: startAngle,
      endAngle: endAngle,
      clockwise: options.clockwise)
    
    //    path.lineCapStyle = .butt
    path.lineWidth = lineWidth
    color.setStroke()
    path.stroke()
    
    return path
  }
  
  private func drawThumb(trackingPath: UIBezierPath) {
    let thumbWidth = options.thumbWidth
    let thumbX = trackingPath.currentPoint.x - thumbWidth / 2
    let thumbY = trackingPath.currentPoint.y - thumbWidth / 2
    
    let pointerRect = CGRect(x: thumbX, y: thumbY, width: thumbWidth, height: thumbWidth)
    let pointer = UIBezierPath(ovalIn: pointerRect)
    options.thumbColor.setFill()
    pointer.fill()
    trackingPath.append(pointer)
    
    // set the position
    pointerPosition = CGPoint(x: thumbX, y: thumbY)
  }
}


