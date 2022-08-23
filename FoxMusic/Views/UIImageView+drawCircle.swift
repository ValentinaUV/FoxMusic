//
//  UIImageView+drawCircle.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 01.08.2022.
//

import UIKit
import CoreGraphics

extension UIImageView {
  
  func drawCircle(size: CGSize, fillColor: CGColor, strokeColor: CGColor, lineWidth: CGFloat, rectangle: CGRect, mode: CGPathDrawingMode) {
    let renderer = UIGraphicsImageRenderer(size: size)
    image = renderer.image { ctx in
      ctx.cgContext.setFillColor(fillColor)
      ctx.cgContext.setStrokeColor(strokeColor)
      ctx.cgContext.setLineWidth(lineWidth)
      ctx.cgContext.addEllipse(in: rectangle)
      ctx.cgContext.drawPath(using: mode)
    }
  }
}
