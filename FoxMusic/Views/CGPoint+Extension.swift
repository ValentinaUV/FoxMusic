//
//  CGPoint+Extension.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 29.07.2022.
//

import UIKit

extension CGPoint {
  
  static func pointOnCircle(center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
    let x = center.x + radius * cos(angle)
    let y = center.y + radius * sin(angle)
    
    return CGPoint(x: x, y: y)
  }
  
  static func arcLength(radius: CGFloat, angleInRadians: CGFloat) -> CGFloat {
    return radius * angleInRadians
  }
  
  static func degreesToRadians(_ angle: CGFloat) -> CGFloat {
    return angle / 180 * CGFloat.pi
  }
  
  static func radiansToDegrees(_ radians: CGFloat) -> CGFloat {
    return radians * 180 / CGFloat.pi
  }
  
  func distanceToPoint(otherPoint: CGPoint) -> CGFloat {
    return sqrt(pow((otherPoint.x - x), 2) + pow((otherPoint.y - y), 2))
  }
  
  static func closestPointOnCircle(center: CGPoint, point: CGPoint, radius: CGFloat) -> CGPoint {
    let distance = center.distanceToPoint(otherPoint: point)
    let x = center.x + radius * (point.x - center.x) / distance
    let y = center.y + radius * (point.y - center.y) / distance
    
    return CGPoint(x: x, y: y)
  }
  
  static func angleBetweenThreePoints(center: CGPoint, firstPoint: CGPoint, secondPoint: CGPoint, clockwise: Bool) -> CGFloat {
    let firstAngle = atan2(firstPoint.y - center.y, firstPoint.x - center.x)
    let secondAngle = atan2(secondPoint.y - center.y, secondPoint.x - center.x)
    var radians = (firstAngle - secondAngle)
    if clockwise {
      if radians > 0 {
        radians -= 2 * .pi
      }
      return abs(radians)
    } else {
        if radians < 0 {
          radians += 2 * .pi
        }
    }
    
    return radians
  }
}


