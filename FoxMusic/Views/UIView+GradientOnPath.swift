//
//  UIView+GradientOnPath.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 26.07.2022.
//
import UIKit

extension UIView {
  func renderGradientOnPath(path: CGPath, pathWidth: CGFloat, firstColor: CGColor, secondColor: CGColor, end: CGPoint) {
    let c = UIGraphicsGetCurrentContext()!
    c.saveGState()
    c.setLineWidth(pathWidth)
    c.addPath(path)
    //    c.setLineCap(.round)
    c.replacePathWithStrokedPath()
    c.clip()
    // Draw gradient
    let colors = [firstColor, secondColor]
    let offsets = [ CGFloat(0.0), CGFloat(1.0) ]
    let grad = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: offsets)
    let start = CGPoint(x: 0, y: 0)
    c.drawLinearGradient(grad!, start: start, end: end, options: [])
    c.restoreGState()
    
    let _ = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
  }
}
