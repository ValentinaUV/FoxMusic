//
//  AlbumTableViewCell.swift
//  MusicApp
//
//  Created by Ungurean Valentina on 11.07.2022.
//

import UIKit

final class AlbumTableViewCell: UITableViewCell {
  var album: Album? {
    didSet {
      if let album = album {
        albumCover.image = UIImage(named: album.getImage())
        albumName.text = album.getName()
        songsCount.text = "\(album.getSongsCount()) Songs"
      }
    }
  }
  
  private lazy var albumCover: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleToFill
    view.clipsToBounds = true
    view.layer.cornerRadius = 25
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    return view
  }()
  
  private lazy var albumName: UILabel = {
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
  
  private func setupView() {
    [albumCover, albumName, songsCount].forEach{ (v) in
      stackLine.addSubview(v)
    }
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
      stackLine.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
    ])
    
    //album cover
    NSLayoutConstraint.activate([
      albumCover.leadingAnchor.constraint(equalTo: stackLine.leadingAnchor, constant: 16),
      albumCover.topAnchor.constraint(equalTo: stackLine.topAnchor, constant: 16),
      albumCover.widthAnchor.constraint(equalToConstant: 100),
      albumCover.heightAnchor.constraint(equalToConstant: 100),
      albumCover.bottomAnchor.constraint(lessThanOrEqualTo: stackLine.bottomAnchor, constant: -16)
    ])
    
    //album name
    NSLayoutConstraint.activate([
      albumName.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16),
      albumName.topAnchor.constraint(equalTo: stackLine.topAnchor, constant: 16),
      albumName.trailingAnchor.constraint(equalTo: stackLine.trailingAnchor, constant: -16)
    ])
    
    //songs count
    NSLayoutConstraint.activate([
      songsCount.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16),
      songsCount.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 8),
      songsCount.trailingAnchor.constraint(equalTo: stackLine.trailingAnchor, constant: -16),
      songsCount.bottomAnchor.constraint(lessThanOrEqualTo: stackLine.bottomAnchor, constant: -16)
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
