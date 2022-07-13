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
        albumCover.image = UIImage(named: album.image)
        albumName.text = album.name
        songsCount.text = "\(album.songs.count) Songs"
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
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  private func setupView() {
    [albumCover, albumName, songsCount].forEach{ (v) in
      contentView.addSubview(v)
    }
    setupConstraints()
  }
  
  private func setupConstraints() {
    //album cover
    NSLayoutConstraint.activate([
      albumCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      albumCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      albumCover.widthAnchor.constraint(equalToConstant: 100),
      albumCover.heightAnchor.constraint(equalToConstant: 100),
      albumCover.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
    ])
    
    //album name
    NSLayoutConstraint.activate([
      albumName.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16),
      albumName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      albumName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
    
    //songs count
    NSLayoutConstraint.activate([
      songsCount.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor, constant: 16),
      songsCount.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 8),
      songsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      songsCount.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
