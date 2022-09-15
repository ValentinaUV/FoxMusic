//
//  MusicCollection.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 15.09.2022.
//

import Foundation

protocol MusicCollection {
  
  init(name: String, songs: [Song])
  func getName() -> String
  func getSongsCount() -> Int
  func getSong(index: Int) -> Song
}

