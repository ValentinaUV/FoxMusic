//
//  ThemeConfigurator.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 23.08.2022.
//

import UIKit

final class ThemeConfigurator {
  
  static let standard = ThemeConfigurator()
  private init() {}
  
  func setUp() {
    let navigationBarAppearance = UINavigationBar.appearance()
    let appearance = UINavigationBarAppearance()
    let bgColor = UIColor(named: "darkColor") ?? .darkGray
    appearance.backgroundColor = bgColor
    appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]

    navigationBarAppearance.standardAppearance = appearance
    navigationBarAppearance.scrollEdgeAppearance = appearance
    
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: bgColor], for: .selected)
    UIBarButtonItem.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  }
}
