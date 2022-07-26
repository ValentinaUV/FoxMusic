//
//  CGFloat+degreesToRadians.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 26.07.2022.
//

import UIKit

extension CGFloat {
  static func degreesToRadians(_ angle: Double) -> Double {
    return angle / 180 * Double.pi
  }
}
