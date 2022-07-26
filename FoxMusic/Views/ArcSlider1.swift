//
//  ArcSlider1.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 20.07.2022.
//


import UIKit

final class ArcSlider1: UISlider {
  
  private let baseLayer = CALayer()
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    setup()
  }
  
  private func setup() {
    clear()
    createBaseLayer()
  }
  
  private func clear() {
    tintColor = .clear
    maximumTrackTintColor = .clear
    backgroundColor = .clear
    thumbTintColor = .clear
  }
  
  private func createBaseLayer() {
    baseLayer.borderWidth = 1
    baseLayer.borderColor = UIColor.lightGray.cgColor
    baseLayer.masksToBounds = true
    baseLayer.backgroundColor = UIColor.white.cgColor
    baseLayer.frame = .init(x: 0,
                            y: frame.height / 4,
                            width: frame.width,
                            height: frame.height / 2)
    baseLayer.cornerRadius = baseLayer.frame.height / 2
    
//    baseLayer.
    
//    let view = renderArc(width: UIScreen.main.bounds.width * 0.6)
    layer.insertSublayer(baseLayer, at: 0)
    
    
  }
  
  private func renderArc(width: Double) -> UIView {
    
    let lineWidth = 5.0
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: width + 2, height: width/2))
    let image = renderer.image { ctx in
      ctx.cgContext.setFillColor(UIColor.black.withAlphaComponent(0.0).cgColor)
      ctx.cgContext.setStrokeColor(UIColor(named: "orange")?.cgColor ?? UIColor.systemOrange.cgColor)
      ctx.cgContext.setLineWidth(lineWidth)
      
      let rectangle = CGRect(x: lineWidth, y: lineWidth, width: width, height: width)
      ctx.cgContext.addEllipse(in: rectangle)
      ctx.cgContext.drawPath(using: .fillStroke)
    }
    
    let view = UIImageView(image: image)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }
}
