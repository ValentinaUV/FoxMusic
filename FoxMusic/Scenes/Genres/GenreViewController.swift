//
//  GenreViewController.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import UIKit

class GenreViewController: UIViewController {

  var viewModel: GenreViewModel!
    
  private lazy var tableView: UITableView = {
    let table = UITableView()
    table.translatesAutoresizingMaskIntoConstraints = false
    table.delegate = self
    table.dataSource = self
    table.register(GenreTableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    viewModel?.genresLoaded = {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    
  }
  
  private func setupView() {
    title = Constants.genresScreen.title
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

extension GenreViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel?.getGenresCount() ?? 0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? GenreTableViewCell
    else {
      return UITableViewCell()
    }
      let genre = viewModel?.getGenre(index: indexPath.row)
      cell.genre = genre
//      cell.textLabel?.text = genre?.getName()
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
//    guard let genre = viewModel?.getGenre(index: indexPath.row) else {return}
//
//    let vc = MusicPlayerViewController(musicCollection: musicCollection)
//    tableView.deselectRow(at: indexPath, animated: true)
//    let backButton = UIBarButtonItem()
//    backButton.title = Constants.playerScreen.backButtonTitle
//    navigationItem.backBarButtonItem = backButton
//    show(vc, sender: self)
  }
}

