//
//  Album.swift
//  MusicApp
//
//  Created by Ungurean Valentina on 11.07.2022.
//

import Foundation

struct Album {
  var name: String
  var image: String
  var songs: [Song]
}

extension Album {
  static func get() -> [Album] {
    return [
      Album(name: "Acoustic", image: "acoustic", songs: [
        Song(name: "Acoustic Breeze", image: "acoustic", artist: "Benjamin Tissot", fileName: "acousticbreeze"),
        Song(name: "A day to remember", image: "acoustic", artist: "Benjamin Tissot", fileName: "adaytoremember"),
        Song(name: "Buddy", image: "acoustic", artist: "Benjamin Tissot", fileName: "buddy"),
        Song(name: "Cute", image: "acoustic", artist: "Benjamin Tissot", fileName: "cute"),
        Song(name: "Funday", image: "acoustic", artist: "Benjamin Tissot", fileName: "funday"),
        Song(name: "Funky Suspense", image: "acoustic", artist: "Benjamin Tissot", fileName: "funkysuspense"),
        Song(name: "Happiness", image: "acoustic", artist: "Benjamin Tissot", fileName: "happiness"),
        Song(name: "Hey", image: "acoustic", artist: "Benjamin Tissot", fileName: "hey"),
        Song(name: "Slow Motion", image: "acoustic", artist: "Benjamin Tissot", fileName: "slowmotion"),
        Song(name: "Small Guitar", image: "acoustic", artist: "Benjamin Tissot", fileName: "smallguitar"),
        Song(name: "Smile", image: "acoustic", artist: "Benjamin Tissot", fileName: "smile"),
        Song(name: "Sunny", image: "acoustic", artist: "Benjamin Tissot", fileName: "sunny"),
        Song(name: "Sweet", image: "acoustic", artist: "Benjamin Tissot", fileName: "sweet"),
        Song(name: "Tenderness", image: "acoustic", artist: "Benjamin Tissot", fileName: "tenderness"),
        Song(name: "Ukulele", image: "acoustic", artist: "Benjamin Tissot", fileName: "ukulele"),
      ]),
      Album(name: "Cinematic", image: "cinematic", songs: [
        Song(name: "Adventure", image: "cinematic", artist: "Benjamin Tissot", fileName: "adventure"),
        Song(name: "Better Days", image: "cinematic", artist: "Benjamin Tissot", fileName: "betterdays"),
        Song(name: "Birth Of A Hero", image: "cinematic", artist: "Benjamin Tissot", fileName: "birthofahero"),
        Song(name: "Creepy", image: "cinematic", artist: "Benjamin Tissot", fileName: "creepy"),
        Song(name: "Enigmatic", image: "cinematic", artist: "Benjamin Tissot", fileName: "enigmatic"),
        Song(name: "Epic", image: "cinematic", artist: "Benjamin Tissot", fileName: "epic"),
        Song(name: "Evolution", image: "cinematic", artist: "Benjamin Tissot", fileName: "evolution"),
        Song(name: "Instinct", image: "cinematic", artist: "Benjamin Tissot", fileName: "instinct"),
        Song(name: "Memories", image: "cinematic", artist: "Benjamin Tissot", fileName: "memories"),
        Song(name: "November", image: "cinematic", artist: "Benjamin Tissot", fileName: "november"),
        Song(name: "Ofelia's Dream", image: "cinematic", artist: "Benjamin Tissot", fileName: "ofeliasdream"),
        Song(name: "Once Again", image: "cinematic", artist: "Benjamin Tissot", fileName: "onceagain"),
        Song(name: "Photo Album", image: "cinematic", artist: "Benjamin Tissot", fileName: "photoalbum"),
        Song(name: "Piano Moment", image: "cinematic", artist: "Benjamin Tissot", fileName: "pianomoment"),
        Song(name: "Sci Fi", image: "cinematic", artist: "Benjamin Tissot", fileName: "scifi"),
        Song(name: "The Duel", image: "cinematic", artist: "Benjamin Tissot", fileName: "theduel"),
        Song(name: "Tomorrow", image: "cinematic", artist: "Benjamin Tissot", fileName: "tomorrow"),
      ]),
      Album(name: "Jazz", image: "jazz", songs: [
        Song(name: "All That", image: "jazz", artist: "Benjamin Tissot", fileName: "allthat"),
        Song(name: "Badass", image: "jazz", artist: "Benjamin Tissot", fileName: "badass"),
        Song(name: "Charlie's mood", image: "jazz", artist: "Ponymusic", fileName: "bensound-charliesmood"),
        Song(name: "Doctor Yes", image: "jazz", artist: "Yari", fileName: "bensound-doctoryes"),
        Song(name: "Good Mood", image: "jazz", artist: "Happy Fingers", fileName: "bensound-goodmood"),
        Song(name: "Mademoiselle", image: "jazz", artist: "Ponymusic", fileName: "bensound-mademoiselle"),
        Song(name: "The Red Dress", image: "jazz", artist: "Happy Fingers", fileName: "bensound-thereddress"),
        Song(name: "The Thief", image: "jazz", artist: "AM Sound", fileName: "bensound-thethief"),
        Song(name: "Hip Jazz", image: "jazz", artist: "Benjamin Tissot", fileName: "hipjazz"),
        Song(name: "Jazz Comedy", image: "jazz", artist: "Benjamin Tissot", fileName: "jazzcomedy"),
        Song(name: "Jazz Frenchy", image: "jazz", artist: "Benjamin Tissot", fileName: "jazzyfrenchy"),
        Song(name: "Love", image: "jazz", artist: "Benjamin Tissot", fileName: "love"),
        Song(name: "The Jazz Piano", image: "jazz", artist: "Benjamin Tissot", fileName: "thejazzpiano"),
        Song(name: "The Lounge", image: "jazz", artist: "Benjamin Tissot", fileName: "thelounge"),
      ])
    ]
  }
}
