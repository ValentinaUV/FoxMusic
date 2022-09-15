//
//  Album.swift
//  MusicApp
//
//  Created by Ungurean Valentina on 11.07.2022.
//

import Foundation

struct Album: MusicCollection {
  private var name: String
  private var image: String!
  private var songs: [Song]
    
  init(name: String, songs: [Song]) {
    self.name = name
    self.songs = songs
  }
  
  init(name: String, image: String, songs: [Song]) {
    self.name = name
    self.image = image
    self.songs = songs
  }
  
  func getName() -> String {
    return name
  }
    
  func getImage() -> String {
    return image
  }
    
  func getSongsCount() -> Int {
    return songs.count
  }
    
  func getSong(index: Int) -> Song {
    return songs[index]
  }
}

extension Album {
  static func get() -> [Album] {
    return [
      Album(name: "Acoustic", image: "acoustic", songs: [
        Song(name: "Acoustic Breeze", image: "acoustic", artist: "Benjamin Tissot", fileName: "acousticbreeze", fileExtension: nil),
        Song(name: "A day to remember", image: "acoustic", artist: "Benjamin Tissot", fileName: "adaytoremember", fileExtension: nil),
        Song(name: "Buddy", image: "acoustic", artist: "Benjamin Tissot", fileName: "buddy", fileExtension: nil),
        Song(name: "Cute", image: "acoustic", artist: "Benjamin Tissot", fileName: "cute", fileExtension: nil),
        Song(name: "Funday", image: "acoustic", artist: "Benjamin Tissot", fileName: "funday", fileExtension: nil),
        Song(name: "Funky Suspense", image: "acoustic", artist: "Benjamin Tissot", fileName: "funkysuspense", fileExtension: nil),
        Song(name: "Happiness", image: "acoustic", artist: "Benjamin Tissot", fileName: "happiness", fileExtension: nil),
        Song(name: "Hey", image: "acoustic", artist: "Benjamin Tissot", fileName: "hey", fileExtension: nil),
        Song(name: "Slow Motion", image: "acoustic", artist: "Benjamin Tissot", fileName: "slowmotion", fileExtension: nil),
        Song(name: "Small Guitar", image: "acoustic", artist: "Benjamin Tissot", fileName: "smallguitar", fileExtension: nil),
        Song(name: "Smile", image: "acoustic", artist: "Benjamin Tissot", fileName: "smile", fileExtension: nil),
        Song(name: "Sunny", image: "acoustic", artist: "Benjamin Tissot", fileName: "sunny", fileExtension: nil),
        Song(name: "Sweet", image: "acoustic", artist: "Benjamin Tissot", fileName: "sweet", fileExtension: nil),
        Song(name: "Tenderness", image: "acoustic", artist: "Benjamin Tissot", fileName: "tenderness", fileExtension: nil),
        Song(name: "Ukulele", image: "acoustic", artist: "Benjamin Tissot", fileName: "ukulele", fileExtension: nil),
      ]),
      Album(name: "Cinematic", image: "cinematic", songs: [
        Song(name: "Adventure", image: "cinematic", artist: "Benjamin Tissot", fileName: "adventure", fileExtension: nil),
        Song(name: "Better Days", image: "cinematic", artist: "Benjamin Tissot", fileName: "betterdays", fileExtension: nil),
        Song(name: "Birth Of A Hero", image: "cinematic", artist: "Benjamin Tissot", fileName: "birthofahero", fileExtension: nil),
        Song(name: "Creepy", image: "cinematic", artist: "Benjamin Tissot", fileName: "creepy", fileExtension: nil),
        Song(name: "Enigmatic", image: "cinematic", artist: "Benjamin Tissot", fileName: "enigmatic", fileExtension: nil),
        Song(name: "Epic", image: "cinematic", artist: "Benjamin Tissot", fileName: "epic", fileExtension: nil),
        Song(name: "Evolution", image: "cinematic", artist: "Benjamin Tissot", fileName: "evolution", fileExtension: nil),
        Song(name: "Instinct", image: "cinematic", artist: "Benjamin Tissot", fileName: "instinct", fileExtension: nil),
        Song(name: "Memories", image: "cinematic", artist: "Benjamin Tissot", fileName: "memories", fileExtension: nil),
        Song(name: "November", image: "cinematic", artist: "Benjamin Tissot", fileName: "november", fileExtension: nil),
        Song(name: "Ofelia's Dream", image: "cinematic", artist: "Benjamin Tissot", fileName: "ofeliasdream", fileExtension: nil),
        Song(name: "Once Again", image: "cinematic", artist: "Benjamin Tissot", fileName: "onceagain", fileExtension: nil),
        Song(name: "Photo Album", image: "cinematic", artist: "Benjamin Tissot", fileName: "photoalbum", fileExtension: nil),
        Song(name: "Piano Moment", image: "cinematic", artist: "Benjamin Tissot", fileName: "pianomoment", fileExtension: nil),
        Song(name: "Sci Fi", image: "cinematic", artist: "Benjamin Tissot", fileName: "scifi", fileExtension: nil),
        Song(name: "The Duel", image: "cinematic", artist: "Benjamin Tissot", fileName: "theduel", fileExtension: nil),
        Song(name: "Tomorrow", image: "cinematic", artist: "Benjamin Tissot", fileName: "tomorrow", fileExtension: nil),
      ]),
      Album(name: "Jazz", image: "jazz", songs: [
        Song(name: "All That", image: "jazz", artist: "Benjamin Tissot", fileName: "allthat", fileExtension: nil),
        Song(name: "Badass", image: "jazz", artist: "Benjamin Tissot", fileName: "badass", fileExtension: nil),
        Song(name: "Charlie's mood", image: "jazz", artist: "Ponymusic", fileName: "bensound-charliesmood", fileExtension: nil),
        Song(name: "Doctor Yes", image: "jazz", artist: "Yari", fileName: "bensound-doctoryes", fileExtension: nil),
        Song(name: "Good Mood", image: "jazz", artist: "Happy Fingers", fileName: "bensound-goodmood", fileExtension: nil),
        Song(name: "Mademoiselle", image: "jazz", artist: "Ponymusic", fileName: "bensound-mademoiselle", fileExtension: nil),
        Song(name: "The Red Dress", image: "jazz", artist: "Happy Fingers", fileName: "bensound-thereddress", fileExtension: nil),
        Song(name: "The Thief", image: "jazz", artist: "AM Sound", fileName: "bensound-thethief", fileExtension: nil),
        Song(name: "Hip Jazz", image: "jazz", artist: "Benjamin Tissot", fileName: "hipjazz", fileExtension: nil),
        Song(name: "Jazz Comedy", image: "jazz", artist: "Benjamin Tissot", fileName: "jazzcomedy", fileExtension: nil),
        Song(name: "Jazz Frenchy", image: "jazz", artist: "Benjamin Tissot", fileName: "jazzyfrenchy", fileExtension: nil),
        Song(name: "Love", image: "jazz", artist: "Benjamin Tissot", fileName: "love", fileExtension: nil),
        Song(name: "The Jazz Piano", image: "jazz", artist: "Benjamin Tissot", fileName: "thejazzpiano", fileExtension: nil),
        Song(name: "The Lounge", image: "jazz", artist: "Benjamin Tissot", fileName: "thelounge", fileExtension: nil),
      ]),
      Album(name: "Acoustic", image: "acoustic", songs: [
        Song(name: "Acoustic Breeze", image: "acoustic", artist: "Benjamin Tissot", fileName: "acousticbreeze", fileExtension: nil),
        Song(name: "A day to remember", image: "acoustic", artist: "Benjamin Tissot", fileName: "adaytoremember", fileExtension: nil),
        Song(name: "Buddy", image: "acoustic", artist: "Benjamin Tissot", fileName: "buddy", fileExtension: nil),
        Song(name: "Cute", image: "acoustic", artist: "Benjamin Tissot", fileName: "cute", fileExtension: nil),
        Song(name: "Funday", image: "acoustic", artist: "Benjamin Tissot", fileName: "funday", fileExtension: nil),
        Song(name: "Funky Suspense", image: "acoustic", artist: "Benjamin Tissot", fileName: "funkysuspense", fileExtension: nil),
        Song(name: "Happiness", image: "acoustic", artist: "Benjamin Tissot", fileName: "happiness", fileExtension: nil),
        Song(name: "Hey", image: "acoustic", artist: "Benjamin Tissot", fileName: "hey", fileExtension: nil),
        Song(name: "Slow Motion", image: "acoustic", artist: "Benjamin Tissot", fileName: "slowmotion", fileExtension: nil),
        Song(name: "Small Guitar", image: "acoustic", artist: "Benjamin Tissot", fileName: "smallguitar", fileExtension: nil),
        Song(name: "Smile", image: "acoustic", artist: "Benjamin Tissot", fileName: "smile", fileExtension: nil),
        Song(name: "Sunny", image: "acoustic", artist: "Benjamin Tissot", fileName: "sunny", fileExtension: nil),
        Song(name: "Sweet", image: "acoustic", artist: "Benjamin Tissot", fileName: "sweet", fileExtension: nil),
        Song(name: "Tenderness", image: "acoustic", artist: "Benjamin Tissot", fileName: "tenderness", fileExtension: nil),
        Song(name: "Ukulele", image: "acoustic", artist: "Benjamin Tissot", fileName: "ukulele", fileExtension: nil),
      ]),
      Album(name: "Cinematic", image: "cinematic", songs: [
        Song(name: "Adventure", image: "cinematic", artist: "Benjamin Tissot", fileName: "adventure", fileExtension: nil),
        Song(name: "Better Days", image: "cinematic", artist: "Benjamin Tissot", fileName: "betterdays", fileExtension: nil),
        Song(name: "Birth Of A Hero", image: "cinematic", artist: "Benjamin Tissot", fileName: "birthofahero", fileExtension: nil),
        Song(name: "Creepy", image: "cinematic", artist: "Benjamin Tissot", fileName: "creepy", fileExtension: nil),
        Song(name: "Enigmatic", image: "cinematic", artist: "Benjamin Tissot", fileName: "enigmatic", fileExtension: nil),
        Song(name: "Epic", image: "cinematic", artist: "Benjamin Tissot", fileName: "epic", fileExtension: nil),
        Song(name: "Evolution", image: "cinematic", artist: "Benjamin Tissot", fileName: "evolution", fileExtension: nil),
        Song(name: "Instinct", image: "cinematic", artist: "Benjamin Tissot", fileName: "instinct", fileExtension: nil),
        Song(name: "Memories", image: "cinematic", artist: "Benjamin Tissot", fileName: "memories", fileExtension: nil),
        Song(name: "November", image: "cinematic", artist: "Benjamin Tissot", fileName: "november", fileExtension: nil),
        Song(name: "Ofelia's Dream", image: "cinematic", artist: "Benjamin Tissot", fileName: "ofeliasdream", fileExtension: nil),
        Song(name: "Once Again", image: "cinematic", artist: "Benjamin Tissot", fileName: "onceagain", fileExtension: nil),
        Song(name: "Photo Album", image: "cinematic", artist: "Benjamin Tissot", fileName: "photoalbum", fileExtension: nil),
        Song(name: "Piano Moment", image: "cinematic", artist: "Benjamin Tissot", fileName: "pianomoment", fileExtension: nil),
        Song(name: "Sci Fi", image: "cinematic", artist: "Benjamin Tissot", fileName: "scifi", fileExtension: nil),
        Song(name: "The Duel", image: "cinematic", artist: "Benjamin Tissot", fileName: "theduel", fileExtension: nil),
        Song(name: "Tomorrow", image: "cinematic", artist: "Benjamin Tissot", fileName: "tomorrow", fileExtension: nil),
      ]),
      Album(name: "Jazz", image: "jazz", songs: [
        Song(name: "All That", image: "jazz", artist: "Benjamin Tissot", fileName: "allthat", fileExtension: nil),
        Song(name: "Badass", image: "jazz", artist: "Benjamin Tissot", fileName: "badass", fileExtension: nil),
        Song(name: "Charlie's mood", image: "jazz", artist: "Ponymusic", fileName: "bensound-charliesmood", fileExtension: nil),
        Song(name: "Doctor Yes", image: "jazz", artist: "Yari", fileName: "bensound-doctoryes", fileExtension: nil),
        Song(name: "Good Mood", image: "jazz", artist: "Happy Fingers", fileName: "bensound-goodmood", fileExtension: nil),
        Song(name: "Mademoiselle", image: "jazz", artist: "Ponymusic", fileName: "bensound-mademoiselle", fileExtension: nil),
        Song(name: "The Red Dress", image: "jazz", artist: "Happy Fingers", fileName: "bensound-thereddress", fileExtension: nil),
        Song(name: "The Thief", image: "jazz", artist: "AM Sound", fileName: "bensound-thethief", fileExtension: nil),
        Song(name: "Hip Jazz", image: "jazz", artist: "Benjamin Tissot", fileName: "hipjazz", fileExtension: nil),
        Song(name: "Jazz Comedy", image: "jazz", artist: "Benjamin Tissot", fileName: "jazzcomedy", fileExtension: nil),
        Song(name: "Jazz Frenchy", image: "jazz", artist: "Benjamin Tissot", fileName: "jazzyfrenchy", fileExtension: nil),
        Song(name: "Love", image: "jazz", artist: "Benjamin Tissot", fileName: "love", fileExtension: nil),
        Song(name: "The Jazz Piano", image: "jazz", artist: "Benjamin Tissot", fileName: "thejazzpiano", fileExtension: nil),
        Song(name: "The Lounge", image: "jazz", artist: "Benjamin Tissot", fileName: "thelounge", fileExtension: nil),
      ])
    ]
  }
}
