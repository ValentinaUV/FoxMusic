//
//  Genre.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import Foundation

struct Genre: MusicCollection {
  private var id: String
  private var name: String
  private var songs: [Song]!
    
  init(id: String, name: String, songs: [Song]) {
    self.id = id
    self.name = name
    self.songs = songs
  }
  
  func getId() -> String {
    return id
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
  
  mutating func addSongs(songs: [Song]) {
    self.songs = songs
  }
}
