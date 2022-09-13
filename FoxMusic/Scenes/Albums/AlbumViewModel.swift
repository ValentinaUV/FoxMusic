//
//  AlbumViewModel.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 31.08.2022.
//

import Foundation

class AlbumViewModel {
//    private let albums = Album.get()
  private var albums: [Album] = []
    
  init() {
    let storage = AppleMusicStorage()
    storage.delegate = self
    
//    storage?.bindSongs = {
////      self.authSucceeded()
//      albums.append(Album(name: "Acoustic", image: "acoustic", songs: storage.getSongs()))
//    }
    
    storage.getSongs()
//    albums.append(Album(name: "Acoustic", image: "acoustic", songs: storage.getSongs()))
    
  }
  
  func receiveSongs(songs: [Song]) {
    albums.append(Album(name: "Acoustic", image: "acoustic", songs: songs))
    print("receiveSongs")
    print(albums)
  }
    
  func getAlbumsCount() -> Int {
    return albums.count
  }
  
  func getAlbum(index: Int) -> Album {
    

    
    return albums[index]
  }
}

