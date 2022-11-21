//
//  AlbumViewModel.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 31.08.2022.
//

import Foundation
import Combine

class AlbumViewModel {
  
  var storage: MusicStorage!
  let genre: Genre!
  
  private var cancellables = Set<AnyCancellable>()
  var albumsLoaded : (() -> ()) = {}
  
  private(set) var albums: [Album]! {
    didSet {
      albumsLoaded()
    }
  }

  init(storage: MusicStorage, genre: Genre!) {
    self.genre = genre
    self.storage = storage
    subscribeToAlbums()
    self.storage.getAlbumsByGenre(genre: genre)
  }
  
  private func subscribeToAlbums() {
    storage.albumsPublisher
      .sink { items in
        print("subscribeToAlbums")
        self.albums = items
      }
      .store(in: &cancellables)
  }
    
  func getAlbumsCount() -> Int {
    return albums.count
  }
  
  func getAlbum(index: Int) -> Album {
    return albums[index]
  }
}

