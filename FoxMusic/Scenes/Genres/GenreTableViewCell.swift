//
//  GenreTableViewCell.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import UIKit

final class GenreTableViewCell: UITableViewCell {
  var genre: Genre? {
    didSet {
      if let genre = genre {
        name.text = genre.getName()
      }
    }
  }
  
  private lazy var name: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    view.textColor = UIColor(named: "titleColor")
    return view
  }()
  
  private lazy var songsCount: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    view.textColor = UIColor(named: "subtitleColor")
    view.numberOfLines = 0
    return view
  }()
  
  private lazy var stackLine: UIStackView = {
    let view = UIStackView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(named: "darkColor")
    return view
  }()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    stackLine.addSubview(name)
    contentView.addSubview(stackLine)
    backgroundColor = UIColor(named: "blue")?.withAlphaComponent(0.0)
    setupConstraints()
  }
  
  private func setupConstraints() {
    
    //stackLine
    NSLayoutConstraint.activate([
      stackLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      stackLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      stackLine.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      stackLine.heightAnchor.constraint(equalToConstant: 55),
      stackLine.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
    ])
    
    //name
    NSLayoutConstraint.activate([
      name.leadingAnchor.constraint(equalTo: stackLine.leadingAnchor, constant: 16),
      name.topAnchor.constraint(equalTo: stackLine.topAnchor, constant: 16),
      name.trailingAnchor.constraint(equalTo: stackLine.trailingAnchor, constant: -16)
    ])
  }
}
