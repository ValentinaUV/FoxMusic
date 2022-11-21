//
//  SegmentedViewController.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 08.11.2022.
//

import UIKit

protocol SegmentedViewControllerProtocol: UIViewController {
  var headerTitle: String? {get set}
}

class SegmentedViewController: UIViewController {
  var segmentViewControllers: [SegmentedViewControllerProtocol] = []
  var segmentedControl: UISegmentedControl?
  
  var lastDisplayedSegmentViewControllerIndex: Int?
  
  public init(_ viewControllers: [SegmentedViewControllerProtocol]) {
    super.init(nibName: nil, bundle: nil)
    segmentViewControllers = viewControllers
    
    segmentedControl = UISegmentedControl(items: segmentTitles())
    segmentedControl?.backgroundColor = .systemOrange
    segmentedControl?.selectedSegmentIndex = 0
    segmentedControl?.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
    segmentedControl?.selectedSegmentTintColor = .systemOrange //button background color
    
    let normalText = [
      NSAttributedString.Key.foregroundColor: UIColor.gray,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
    ]
    let selectedText = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    segmentedControl?.setTitleTextAttributes(normalText, for: .normal)
    segmentedControl?.setTitleTextAttributes(selectedText, for: .selected)
    
//    displaySegmentViewController(0)
  }

  public required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func segmentTitles() -> [String] {
    var segmentTitles: [String] = []
    for viewController in segmentViewControllers {
      segmentTitles.append(viewController.headerTitle ?? "")
    }
    return segmentTitles
  }

  @objc func segmentSelected(_ segmentControl: UISegmentedControl) {
    var lastDisplayedIndex: Int? = nil

    if let i = lastDisplayedSegmentViewControllerIndex {
        lastDisplayedIndex = i
    }
//    displaySegmentViewController(segmentControl.selectedSegmentIndex)

    if let j = lastDisplayedIndex {
        hideSegmentViewController(j)
    }
  }
  
  private func displaySegmentViewController(_ segmentViewControllerIndex: Int) {
    let viewController = segmentViewControllers[segmentViewControllerIndex]
    addChild(viewController)
    view.addSubview(viewController.view)
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
//      viewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(200.0)),
      viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    viewController.didMove(toParent: self)
    lastDisplayedSegmentViewControllerIndex = segmentedControl?.selectedSegmentIndex
  }
  
  private func hideSegmentViewController(_ segmentViewControllerIndex: Int) {
    let viewController = segmentViewControllers[segmentViewControllerIndex]
    viewController.willMove(toParent: nil)
    viewController.view.removeFromSuperview()
    viewController.removeFromParent()
  }
}
