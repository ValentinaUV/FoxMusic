//
//  MediaPlayer.swift
//  MusicApp
//
//  Created by Ungurean Valentina on 26.07.2022.
//


import UIKit

internal class Math {
    
    class func degreesToRadians(_ angle: Double) -> Double {
        return angle / 180 * Double.pi
    }
    
    class func pointFromAngle(_ frame: CGRect, angle: Double, radius: Double) -> CGPoint {
        let radian = degreesToRadians(angle)
        let x = Double(frame.midX) + cos(radian) * radius
        let y = Double(frame.midY) + sin(radian) * radius
        return CGPoint(x: x, y: y)
    }
    
    class func pointPairToBearingDegrees(_ startPoint: CGPoint, endPoint: CGPoint) -> Double {
        let originPoint = CGPoint(x: endPoint.x - startPoint.x, y: endPoint.y - startPoint.y)
        let bearingRadians = atan2(Double(originPoint.y), Double(originPoint.x))
        var bearingDegrees = bearingRadians * (180.0 / Double.pi)
        bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees))
        return bearingDegrees
    }
    
    class func adjustValue(_ startAngle: Double, degree: Double, maxValue: Float, minValue: Float) -> Double {
        let ratio = Double((maxValue - minValue) / 360)
        let ratioStart = ratio * startAngle
        let ratioDegree = ratio * degree
        let adjustValue: Double
        if startAngle < 0 {
            adjustValue = (360 + startAngle) > degree ? (ratioDegree - ratioStart) : (ratioDegree - ratioStart) - (360 * ratio)
        } else {
            adjustValue = (360 - (360 - startAngle)) < degree ? (ratioDegree - ratioStart) : (ratioDegree - ratioStart) + (360 * ratio)
        }
        return adjustValue + (Double(minValue))
    }
    
    class func adjustDegree(_ startAngle: Double, degree: Double) -> Double {
        return (360 + startAngle) > degree ? degree : -(360 - degree)
    }
    
    class func degreeFromValue(_ startAngle: Double, value: Float, maxValue: Float, minValue: Float) -> Double {
        let ratio = Double((maxValue - minValue) / 360)
        let angle = Double(value) / ratio
        return angle + startAngle - (Double(minValue) / ratio)
    }
}
