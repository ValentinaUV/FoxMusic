//
//  GenreHeader.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 18.11.2022.
//

import UIKit

class GenreHeader: UICollectionReusableView {
  
  var currentController: SegmentedViewControllerProtocol?
  var segmentedView: UISegmentedControl?

  let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor(named: "darkColor")
    addSubview(titleLabel)
    if let sView = getSegmentedController().segmentedControl {
      segmentedView = sView
      segmentedView?.translatesAutoresizingMaskIntoConstraints = false
      addSubview(sView)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    titleLabel.sizeToFit()
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
      titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20),
    ])
    
    if let sView = segmentedView {
      NSLayoutConstraint.activate([
        sView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        sView.bottomAnchor.constraint(equalTo: bottomAnchor),
        sView.heightAnchor.constraint(equalToConstant:80),
        sView.leftAnchor.constraint(equalTo: leftAnchor),
        sView.rightAnchor.constraint(equalTo: rightAnchor)
      ])
    }
  }
  
  func setupView() {
    segmentedView?.layer.cornerRadius = 0
  }
  
  func getSegmentedController() -> SegmentedViewController {
    
    var controllers: [SegmentedViewControllerProtocol] = []
    if let controller = currentController {
      if controller is GenreViewController {
        let albumsVC = AlbumViewController()
        albumsVC.title = "Albums"
        albumsVC.viewModel = AlbumViewModel(storage: AppleMusicStorage(), genre: nil)
        albumsVC.view.backgroundColor = .yellow
        controllers = [controller, albumsVC]
      } else {
        let genresVC = GenreViewController()
        genresVC.title = "Genres"
        genresVC.viewModel = GenreViewModel(storage: AppleMusicStorage())
        genresVC.view.backgroundColor = .orange
        controllers = [genresVC, controller]
      }
    } else {
      let genresVC = GenreViewController()
      genresVC.title = "Genres"
      genresVC.viewModel = GenreViewModel(storage: AppleMusicStorage())
      genresVC.view.backgroundColor = .orange
      let albumsVC = AlbumViewController()
      albumsVC.title = "Albums"
      albumsVC.viewModel = AlbumViewModel(storage: AppleMusicStorage(), genre: nil)
      albumsVC.view.backgroundColor = .yellow
      controllers = [genresVC, albumsVC]
    }
    
    return SegmentedViewController(controllers)
  }
}
