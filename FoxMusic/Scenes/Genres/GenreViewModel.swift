//
//  GenreViewModel.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import Foundation
import Combine
import MusicKit

class GenreViewModel {

  var storage: MusicStorage!
  private var cancellables = Set<AnyCancellable>()
  
  var genresLoaded : (() -> ()) = {}
  var genreWithSongsLoaded : (() -> ()) = {}
//  var albumLoaded : (() -> ()) = {}
  
  private(set) var genres: [Genre]! {
    didSet {
      print("will call genresLoaded")
      genresLoaded()
    }
  }
  
//  private(set) var genreWithSongs: Genre! {
//    didSet {
//      genreWithSongsLoaded()
//    }
//  }
//
//  private(set) var album: MusicKit.Album! {
//    didSet {
//      albumLoaded()
//    }
//  }
  
  init(storage: MusicStorage) {
    self.storage = storage
    subscribeToGenres()
//    subscribeToAlbum()
    self.storage.getGenres()
  }
  
  func getGenresCount() -> Int {
    return genres.count
  }

  func getGenre(index: Int) -> Genre {
    return genres[index]
  }
  
  private func subscribeToGenres() {
    storage.genresPublisher
      .sink { items in
        print("subscribeToGenres")
        self.genres = items
      }
      .store(in: &cancellables)
  }
  
//  private func subscribeToAlbum() {
//    storage.albumPublisher
//      .sink { item in
//        self.album = item
//      }
//      .store(in: &cancellables)
//  }
  
  func getSongsByGenre(index: Int) {
    print("getSongsByGenre")
    storage.getSongsByGenre(genre: genres[index])
  }
}
