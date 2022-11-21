//
//  AlbumViewController.swift
//  FoxMusic
//
//  Created by Ungurean Valentina on 11.07.2022.
//

import UIKit

class AlbumViewController: UIViewController, SegmentedViewControllerProtocol {

  var viewModel: AlbumViewModel!
  var headerTitle: String?
    
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
    title = Constants.albumsScreen.barTitle
    headerTitle = Constants.albumsScreen.title
    view.addSubview(tableView)
    setupConstraints()
    albumsLoaded()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func albumsLoaded() {
    viewModel?.albumsLoaded = {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
}

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel?.getAlbumsCount() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumTableViewCell
    else {
      return UITableViewCell()
    }
      let album = viewModel?.getAlbum(index: indexPath.row)
      cell.album = album
      cell.textLabel?.text = album?.getName()
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
//    guard let album = viewModel?.getAlbum(index: indexPath.row) else {return}
//    let vc = MusicPlayerViewController(musicCollection: album)
//    tableView.deselectRow(at: indexPath, animated: true)
//    let backButton = UIBarButtonItem()
//    backButton.title = Constants.playerScreen.backButtonTitle
//    navigationItem.backBarButtonItem = backButton
//    show(vc, sender: self)
  }
}
