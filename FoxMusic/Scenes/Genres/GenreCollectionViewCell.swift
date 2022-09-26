//
//  GenreCollectionViewCell.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import UIKit

final class GenreCollectionViewCell: UICollectionViewCell {
  var genre: Genre? {
    didSet {
      if let genre = genre {
        name.text = genre.getName()
      }
    }
  }
  
  private lazy var name: UILabel = {
    let title = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    title.textAlignment = .center
    title.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    title.textColor = UIColor(named: "titleColor")
    return title
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    contentView.addSubview(name)
    backgroundColor = UIColor(named: "darkColor")
    setupConstraints()
  }
  
  private func setupConstraints() {

  }
}
