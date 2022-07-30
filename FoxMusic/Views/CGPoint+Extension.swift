//
//  CGPoint+Extension.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 29.07.2022.
//

import UIKit

extension CGPoint {
  
  static func degreesToRadians(_ angle: Double) -> Double {
    return angle / 180 * Double.pi
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
  
  static func angleBetweenThreePoints(center: CGPoint, firstPoint: CGPoint, secondPoint: CGPoint) -> CGFloat {
    let firstAngle = atan2(firstPoint.y - center.y, firstPoint.x - center.x)
    let secondAngle = atan2(secondPoint.y - center.y, secondPoint.x - center.x)
    var radians = 2 * (firstAngle - secondAngle)
    while radians < 0 {
      radians += CGFloat(2 * Double.pi)
    }
    
    return radians
  }
}


