//
//  Genre.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import Foundation

struct Genre: MusicCollection {
  private var name: String
  private var songs: [Song]!
    
  init(name: String, songs: [Song]) {
    self.name = name
    self.songs = songs
  }
  
  func getName() -> String {
    return name
  }
    
  func getSongsCount() -> Int {
    return songs.count
  }
    
  func getSong(index: Int) -> Song {
    return songs[index]
  }
}
