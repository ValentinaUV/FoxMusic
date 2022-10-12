//
//  MusicCollection.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import Foundation

protocol MusicCollection {
  
  init(id: String, name: String, songs: [Song])
  func getId() -> String
  func getName() -> String
  func getSongsCount() -> Int
  func getSong(index: Int) -> Song
}

