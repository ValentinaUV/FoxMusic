//
//  GenreViewModel.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import Foundation
import Combine

class GenreViewModel {
  
//  var genres: [Genre]!
  var storage: MusicStorage!
  private var cancellables = Set<AnyCancellable>()
  
  var genresLoaded : (() -> ()) = {}
  
  private(set) var genres: [Genre]! {
    didSet {
      genresLoaded()
    }
  }
  
  init() {
    storage = AppleMusicStorage()
//    storage.delegate = self
    subscribeToGenres()
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
        self.genres = items
      }
      .store(in: &cancellables)
  }
}
