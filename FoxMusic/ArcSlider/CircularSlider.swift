//
//  CircularSlider.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 26.07.2022.
//

import UIKit

struct CircularSliderOptions {
  var startAngleDegrees: Double = 180.0
  var endAngleDegrees: Double = 360.0
  var barWidth: CGFloat = 5.0
  var trackingWidth: CGFloat = 5.0
  var barColor: UIColor = .darkGray
  var trackingColor: UIColor = .systemOrange
  var drawThumb: Bool = true
  var thumbWidth: CGFloat = 20
  var thumbColor: UIColor = .systemOrange
  var clockwise: Bool = false
  var drawTrackingGradient: Bool = true
  var trackingFirstColor: UIColor = .systemRed
  var trackingSecondColor: UIColor = .systemYellow
  
//  case thumbImage(UIImage?)
//  case maxValue(Float)
//  case minValue(Float)
//  case sliderEnabled(Bool)
//  case viewInset(CGFloat)
//  case minMaxSwitchTreshold(Float)
//  case thumbPosition(Float)
  
}

public class CircularSlider: UIControl {
  
  let options: CircularSliderOptions
  
  private lazy var centerPoint: CGPoint = {
    let centerPoint = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    return centerPoint
  }()
  
  private lazy var radius: CGFloat = {
    let maxDim = max(bounds.width, bounds.height)
    let radius = maxDim/2 - options.thumbWidth/2
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
  
  var value: CGFloat = 0.0 {
    didSet {
      if let max = maxValue {
        print("value: \(value)")
        progress = value / max
      }
    }
  }
  
  var maxValue: CGFloat? {
    didSet {
      progress = value / (maxValue ?? 1)
    }
  }
  
  var progress: CGFloat = 0.0 {
    didSet {
      if !(0...1).contains(progress) {
        // clamp: if progress is over 1 or less than 0 give it a value between them
        progress = max(0, min(1, progress))
      }
      updateOutlineEndAngle()
      setNeedsDisplay()
    }
  }

  private var pointerPosition: CGPoint = CGPoint()
  // boolean which chooses if the knob can be dragged or not
  var canDrag = true
  // variable that stores the lenght of the arc based on the last touch
  var oldLength : CGFloat = 30
  
  init(frame: CGRect, options: CircularSliderOptions) {
    self.options = options
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
  
  

  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let firstTouch = touches.first {
      let hitView = self.hitTest(firstTouch.location(in: self), with: event)
      if hitView === self {
//        if canDrag == true {
          
          // CONSTANTS TO BE USED
//          let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
//          let radiusBounds = max(bounds.width, bounds.height)
//          let radius = radiusBounds/2 - options.barWidth/2
          let touchX = firstTouch.preciseLocation(in: hitView).x
          let touchY = firstTouch.preciseLocation(in: hitView).y
        
        print("touchX: \(touchX)")
        print("touchY: \(touchY)")
          
          // FIND THE NEAREST POINT TO THE CIRCLE FROM THE TOUCH POSITION
          let dividendx = pow(touchX, 2) + pow(centerPoint.x, 2) - (2 * touchX * centerPoint.x)
          let dividendy = pow(touchY, 2) + pow(centerPoint.y, 2) - (2 * touchY * centerPoint.y)
          let dividend = sqrt(abs(dividendx) + abs(dividendy))
          
          // POINT(x, y) FOUND
          let pointX = centerPoint.x + ((radius * (touchX - centerPoint.x)) / dividend)
          let pointY = centerPoint.y + ((radius * (touchY - centerPoint.y)) / dividend)
          
          // ARC LENGTH
          let arcAngle: CGFloat = (2 * .pi) + (.pi / 4) - (3 * .pi / 4)
          let arcLength =  arcAngle * radius
          
          // NEW ARC LENGTH
          let xForTheta = Double(pointX) - Double(centerPoint.x)
          let yForTheta = Double(pointY) - Double(centerPoint.y)
//          var theta : Double = atan2(yForTheta, xForTheta) - (3 * .pi / 4)
          var theta : Double = (3 * .pi / 4) - atan2(yForTheta, xForTheta)

          if theta < 0 {
            theta += 2 * .pi
          }
          let newArcLength = CGFloat(theta) * radius
          
          // CHECK CONDITIONS OF THE POINTER'S POSITION
//          if 480.0 ... 550.0 ~= newArcLength { newArcLength = 480 }
//          else if 550.0 ... 630.0 ~= newArcLength { newArcLength = 0 }
//          if oldLength == 480 && 0 ... 465 ~= newArcLength  { newArcLength = 480 }
//          else if oldLength == 0 && 15 ... 480 ~= newArcLength { newArcLength = 0 }
          oldLength = newArcLength
          
          // PERCENTAGE TO BE ASSIGNED TO THE PROGRESS VAR
          let newPercentage = newArcLength/arcLength
//          progress = CGFloat(newPercentage)
          value = CGFloat(newPercentage) * maxValue!
          self.sendActions(for: .valueChanged)
//        }
      }
    }
  }
  
  public override func draw(_ rect: CGRect) {
    
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
  
  private func updateOutlineEndAngle() {
    let angleDiff: CGFloat = 2 * .pi + startAngle - endAngle
    outlineEndAngle = startAngle - angleDiff * CGFloat(progress)
  }
  
  private func drawThumb(trackingPath: UIBezierPath) {
    let thumbWidth = options.thumbWidth
    let thumbX = trackingPath.currentPoint.x - thumbWidth / 2
    let thumbY = trackingPath.currentPoint.y - thumbWidth / 2
    
    let pointerRect = CGRect(x: thumbX, y: thumbY, width: thumbWidth, height: thumbWidth)
    let thumb = UIBezierPath(ovalIn: pointerRect)
    options.thumbColor.setFill()
    thumb.fill()
    trackingPath.append(thumb)
    
    // set the position
    pointerPosition = CGPoint(x: thumbX, y: thumbY)
//    print("pointerPosition : \(pointerPosition)")
  }
}


