//
//  MusicStorage.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 06.09.2022.
//

import Foundation
import MusicKit

protocol MusicStorage {
  
  var genresPublisher: Published<[Genre]>.Publisher { get }
  
  func getGenres()
}



public typealias Genres = MusicItemCollection<MusicKit.Genre>

class AppleMusicStorage: MusicStorage {
  
  let rootPath = "https://api.music.apple.com/v1"
  let publicCatalogPath = "/catalog"
  
//  var delegate: AlbumViewModel!
  
  
  @Published var genres: [Genre] = []
  var genresPublisher: Published<[Genre]>.Publisher { $genres }
  
//  public init(genres: [Genre]) {
//    self.genres = genres
//  }
  
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
  
  func getGenres() {
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
            returnGenres(genres: genres)
            
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
  
  func returnGenres(genres: Genres) {
    var items: [Genre] = []
    for genre in genres {
      items.append(Genre(name: genre.name, songs: []))
    }
    self.genres = items
  }
  
  
  
//  public var type: MusicCatalogChartRequestable.Type {
//    switch self {
//      case .songs:
//        return Song.self
//      case .albums:
//        return Album.self
//      case .playlists:
//        return Playlist.self
//      case .musicVideos:
//        return MusicVideo.self
//    }
//  }
  
  @available(iOS 16.0, *)
  private func fetchCatalogCharts(genre: MusicKit.Genre?,
                                  kinds: [MusicCatalogChartKind],
                                  types: [MusicKit.Song.Type],
                                         limit: Int?,
                                         offset: Int?) async throws -> MusicCatalogChartsResponse {
//    let chartTypes = types.map { $0.Type }
    var request = MusicCatalogChartsRequest(genre: genre, kinds: kinds, types: types)
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response
  }
  
  @available(iOS 16.0, *)
  func getSongs() {
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

//            var songsRequest = MusicCatalogSearchRequest(term: genre.name,
//                                                          types: [MusicKit.Song.self])
//            songsRequest.limit = 10
//            let result = try await songsRequest.response()
//            print(result.songs.count)
            
            let result = try await fetchCatalogCharts(genre: genre, kinds: [.mostPlayed], types: [MusicKit.Song.self], limit: 10, offset: 0)

            var songs: [Song] = []
            for items in result.songCharts {
              for song in items.items {
                print(song.genreNames)
                songs.append(Song(name: song.title, imageUrl: song.artwork?.url(width: 100, height: 100), artist: song.artistName, url: song.url!))
              }
            }
            print("send to delegate")
//            delegate.receiveSongs(songs: songs)
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
