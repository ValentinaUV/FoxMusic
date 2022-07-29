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
}

public class CircularSlider: UIControl {
  
  let options: CircularSliderOptions
  private var pointerPosition: CGPoint = CGPoint()
  private var canDrag = true
  
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
    let startAngle = CGPoint.degreesToRadians(options.startAngleDegrees)
    return startAngle
  }()
  
  private lazy var endAngle: CGFloat = {
    let endAngle = CGPoint.degreesToRadians(options.endAngleDegrees)
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
        let distance = firstTouch.preciseLocation(in: hitView).distanceToPoint(otherPoint: pointerPosition)
        canDrag = true
        guard distance < 30 else { return canDrag = false }
      }
    }
  }
  
  public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let firstTouch = touches.first {
      let hitView = self.hitTest(firstTouch.location(in: self), with: event)
      if hitView === self, canDrag == true {

        let touchPoint = firstTouch.preciseLocation(in: hitView)
        let arcLength = endAngle * radius
        let movePoint = CGPoint.closestPointOnCircle(center: centerPoint, point: touchPoint, radius: radius)

        let startArcPoint = CGPoint(x: centerPoint.x - radius, y: centerPoint.y)
        let angleInRadians = CGPoint.angleBetweenThreePoints(center: centerPoint, firstPoint: startArcPoint, secondPoint: movePoint)
        let newArcLength = CGFloat(angleInRadians) * radius
        let newPercentage = newArcLength/arcLength
        value = CGFloat(newPercentage) * maxValue!
        self.sendActions(for: .valueChanged)
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
  }
}


