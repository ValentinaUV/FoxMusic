//
//  GenreViewModel.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import Foundation
import Combine

class GenreViewModel {

  var storage: MusicStorage!
  private var cancellables = Set<AnyCancellable>()
  
  var genresLoaded : (() -> ()) = {}
  var genreWithSongsLoaded : (() -> ()) = {}
  
  private(set) var genres: [Genre]! {
    didSet {
      print("will call genresLoaded")
      genresLoaded()
    }
  }
  
  private(set) var genreWithSongs: Genre! {
    didSet {
      genreWithSongsLoaded()
    }
  }
  
  init() {
    storage = AppleMusicStorage()
    subscribeToGenres()
//    subscribeToGenreSongs()
    storage.getGenres()
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
  
  private func subscribeToGenreSongs() {
    storage.genreWithSongsPublisher
      .sink { item in
        self.genreWithSongs = item
      }
      .store(in: &cancellables)
  }
  
  func getSongsByGenre(index: Int) {
    print("getSongsByGenre")
    storage.getSongsByGenre(genre: genres[index])
  }
}
