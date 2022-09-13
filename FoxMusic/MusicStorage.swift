//
//  MusicStorage.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 06.09.2022.
//

import Foundation
import MusicKit

protocol MusicStorage {
  
}



public typealias Genres = MusicItemCollection<Genre>

//public typealias Songs = MusicItemCollection<Song>

class AppleMusicStorage: MusicStorage {
  
  let rootPath = "https://api.music.apple.com/v1"
  let publicCatalogPath = "/catalog"
  
  var delegate: AlbumViewModel!
  
  private func getCountryCode() async throws -> String {
    return try await MusicDataRequest.currentCountryCode
  }

  func getTopGenres() async throws -> Genres {
    let countryCode = try await getCountryCode()
    print(countryCode)
    let path = "\(rootPath)\(publicCatalogPath)/\(countryCode)/genres"
    let request = MusicDataRequest(urlRequest: URLRequest(url: URL(string: path)!))
    let response = try await request.response()

    return try JSONDecoder().decode(Genres.self, from: response.data)
  }
  
  func getSongs(genre: Genre) {
    Task {
      do {
        let status = await MusicAuthorization.request()
        switch status {
        case .authorized:
          do {
            let genres = try await getTopGenres()
            print("================genre==============")
            let genre = genres[2]
            print(genre)

            var songsRequest = MusicCatalogSearchRequest(term: genre.name,
                                                          types: [MusicKit.Song.self])
            songsRequest.limit = 10
            let result = try await songsRequest.response()
            print(result.songs.count)

            var songs: [Song] = []
            for song in result.songs {
              songs.append(Song(name: song.title, imageUrl: song.artwork?.url(width: 100, height: 100), artist: song.artistName, url: song.url!))
            }
            print("send to delegate")
            delegate.receiveSongs(songs: songs)
          } catch {
            print(error)
          }
//        case .notDetermined:
//          <#code#>
//        case .denied:
//          <#code#>
//        case .restricted:
//          <#code#>
        default:
          break
        }
      }
    }
  }
}
