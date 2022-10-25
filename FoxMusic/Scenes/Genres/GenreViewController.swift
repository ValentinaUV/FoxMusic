//
//  GenreViewController.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import UIKit

class GenreViewController: UIViewController {

  var viewModel: GenreViewModel!
  var collectionView: UICollectionView!
  
  override func loadView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    layout.itemSize = CGSize(width: 180, height: 90)
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    self.view = collectionView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    title = Constants.genresScreen.title
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .systemOrange
    collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    genresLoaded()
    albumLoaded()
  }
  
  private func genresLoaded() {
    print("genresLoaded")
    viewModel?.genresLoaded = {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  private func albumLoaded() {
    print("albumLoaded")
    viewModel?.albumLoaded = {
      DispatchQueue.main.async {
        let vc = MusicPlayerViewController(album: self.viewModel.album)
        let backButton = UIBarButtonItem()
        backButton.title = Constants.playerScreen.backButtonTitle
        self.navigationItem.backBarButtonItem = backButton
        self.show(vc, sender: self)
      }
    }
  }
  
  private func genreWithSongsLoaded() {
//    viewModel?.genreWithSongsLoaded = {
//      DispatchQueue.main.async {
//        guard let genre = self.viewModel?.genreWithSongs else {return}
        
//        let vc = MusicPlayerViewController(musicCollection: genre)
//        let backButton = UIBarButtonItem()
//        backButton.title = Constants.playerScreen.backButtonTitle
//        self.navigationItem.backBarButtonItem = backButton
//        self.show(vc, sender: self)
//      }
//    }
  }
}

extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.getSongsByGenre(index: indexPath.row)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.getGenresCount() ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GenreCollectionViewCell
    else {
      return UICollectionViewCell()
    }
    
    let genre = viewModel?.getGenre(index: indexPath.row)
    cell.genre = genre
    return cell
  }
}
