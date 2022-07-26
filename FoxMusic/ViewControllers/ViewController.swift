//
//  ViewController.swift
//  MusicApp
//
//  Created by Ungurean Valentina on 11.07.2022.
//

import UIKit

class ViewController: UIViewController {

  private let albums = Album.get()
  
  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.delegate = self
    table.dataSource = self
    table.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cell")
    table.estimatedRowHeight = 132
    table.rowHeight = UITableView.automaticDimension
    table.backgroundColor = UIColor(named: "blue")
    var image = UIImageView(image: UIImage(named: "fox-screen"))
    image.contentMode = .scaleAspectFit
    table.backgroundView = image
    table.tableFooterView = UIView()
    return table
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    title = "My Music Player"
    view.addSubview(tableView)
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumTableViewCell
    else {
      return UITableViewCell()
    }
    cell.album = albums[indexPath.row]
    cell.textLabel?.text = albums[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = MusicPlayerViewController(album: albums[indexPath.row])
    tableView.deselectRow(at: indexPath, animated: true)
    show(vc, sender: self)
  }
}
