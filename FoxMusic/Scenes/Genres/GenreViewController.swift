//
//  GenreViewController.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import UIKit

class GenreViewController: UIViewController, SegmentedViewControllerProtocol {

  var viewModel: GenreViewModel!
  var collectionView: UICollectionView!
  var headerTitle: String?
  var headerView: GenreHeader?
  
//  private let barSize : CGFloat = 44.0
//  private let kCellReuse : String = "PackCell"
//  private let kCellheaderReuse : String = "PackHeader"
  
//  let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
//
//  // create header/footer item with the defined size
//  // elementKind: use a unique string for `elementKind`. e.g. if you want to add 3 different kinds of headers, then you should have 3 different elementKind strings
//  // alignment: use `.top` for headers, `.bottom` for footers
//  // absoluteOffset: gives you an opportunity to offset your header/footer, usually you only want to offset them on y axis if you are building a vertical collection view. Use a positive y value to move down, negative y to move up.
//  let layoutHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: "Header1", alignment: .top, absoluteOffset: CGPoint(x: 0, y: -60))
  
  
  override func loadView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: -20, left: 10, bottom: 0, right: 10)
    layout.itemSize = CGSize(width: 180, height: 90)
    
    layout.headerReferenceSize = CGSize(width: 0.0, height: 150.0)
    

    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor(named: "blue")
//    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    self.view = collectionView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    title = Constants.genresScreen.barTitle
    headerTitle = Constants.genresScreen.title
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.register(GenreHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "genresHeader")
    genresLoaded()
    
    NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
    ])
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if let header = headerView {
      collectionView.sendSubviewToBack(header)
      header.setupView()
    }
  }
  
  private func genresLoaded() {
    viewModel?.genresLoaded = {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
//  private func albumLoaded() {
//    print("albumLoaded")
//    viewModel?.albumLoaded = {
//      DispatchQueue.main.async {
//        let vc = MusicPlayerViewController(album: self.viewModel.album)
//        let backButton = UIBarButtonItem()
//        backButton.title = Constants.playerScreen.backButtonTitle
//        self.navigationItem.backBarButtonItem = backButton
//        self.show(vc, sender: self)
//      }
//    }
//  }
  
}

extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    DispatchQueue.main.async {
//      let vc = AlbumViewController()
//      vc.viewModel = AlbumViewModel(storage: AppleMusicStorage(), genre: self.viewModel.getGenre(index: indexPath.row))
//      self.show(vc, sender: self)
//    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.getGenresCount() ?? 0
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      return 1
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
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    switch kind {
      case UICollectionView.elementKindSectionHeader:
      if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "genresHeader", for: indexPath) as! GenreHeader? {
        header.titleLabel.text = headerTitle ?? title
        header.currentController = self
        headerView = header
        return header
      }

      default:
        assert(false, "Unexpected element kind")
    }
    return UICollectionReusableView()
  }
  
  
  
  // MARK: UICollectionViewDelegateFlowLayout
//  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//      return CGSize(width: 90, height: 90) // The size of one cell
//  }
//  
//  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//      return CGSizeMake(self.view.frame.width, 90)  // Header size
//  }
}

//extension GenreViewController: UIToolbarDelegate {
//    public func position(for bar: UIBarPositioning) -> UIBarPosition {
//        .topAttached
//    }
//}

