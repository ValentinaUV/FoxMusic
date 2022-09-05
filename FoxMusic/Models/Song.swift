//
//  Song.swift
//  MusicApp
//
//  Created by Ungurean Valentina on 11.07.2022.
//

import Foundation

struct Song {
  private var name: String
  private var image: String
  private var artist: String
  private var fileName: String
  private var fileExtension = "mp3"
  
  init(name: String, image: String, artist: String, fileName: String, fileExtension: String?) {
    self.name = name
    self.image = image
    self.artist = artist
    self.fileName = fileName
    if let ext = fileExtension {
      self.fileExtension = ext
    }
  }
  
  func getName() -> String {
    return name
  }
  
  func getImage() -> String {
    return image
  }
  
  func getArtist() -> String {
    return artist
  }
  
  func getFileName() -> String {
    return fileName
  }
  
  func getFileExtension() -> String {
    return fileExtension
  }
}
