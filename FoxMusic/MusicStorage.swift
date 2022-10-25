//
//  MusicStorage.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 06.09.2022.
//

import Foundation
import MusicKit
import MediaPlayer

protocol MusicStorage {
  
  var genresPublisher: Published<[Genre]>.Publisher { get }
  var genreWithSongsPublisher: Published<Genre?>.Publisher { get }
  var albumPublisher: Published<MusicKit.Album?>.Publisher { get }

  func getGenres()
  func getSongsByGenre(genre: Genre)
}


public typealias Genres = MusicItemCollection<MusicKit.Genre>
public typealias Songs = MusicItemCollection<MusicKit.Song>

class AppleMusicStorage: MusicStorage {
  
  let rootPath = "https://api.music.apple.com/v1"
  let publicCatalogPath = "/catalog"
  
  @Published var genres: [Genre] = []
  var genresPublisher: Published<[Genre]>.Publisher { $genres }
  
  @Published var genreWithSongs: Genre?
  var genreWithSongsPublisher: Published<Genre?>.Publisher { $genreWithSongs }
  
  @Published var album: MusicKit.Album?
  var albumPublisher: Published<MusicKit.Album?>.Publisher { $album }
  
  private func getCountryCode() async throws -> String {
    return try await MusicDataRequest.currentCountryCode
  }

  func getTopGenres() async throws -> Genres {
    let countryCode = try await getCountryCode()
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
            print("genres: ")
            print(genres)
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
  
  private func returnGenres(genres: Genres) {
    var items: [Genre] = []
    for genre in genres {
      items.append(Genre(id: genre.id.rawValue, name: genre.name, songs: []))
    }
    self.genres = items
  }
  
  @available(iOS 16.0, *)
  private func fetchCatalogCharts(genre: MusicKit.Genre, kinds: [MusicCatalogChartKind], types: [MusicCatalogChartRequestable.Type], limit: Int?, offset: Int?) async throws -> MusicCatalogChartsResponse {
    let chartTypes = types.map { $0}
    var request = MusicCatalogChartsRequest(genre: genre, kinds: kinds, types: chartTypes)
    request.limit = limit
    request.offset = offset
    let response = try await request.response()
    return response
  }
  
  private func getGenreById(id: String) async throws -> MusicKit.Genre {
    let itemId = MusicItemID(rawValue: id)
    let request = MusicCatalogResourceRequest<MusicKit.Genre>(matching: \.id, equalTo: itemId)
    let response = try await request.response()

    guard let genre = response.items.first else {
      throw MusicStorageError.notFound(for: id)
    }

    return genre
  }
  
  private func returnGenreWithSongs(genre: Genre) {
    self.genreWithSongs = genre
  }
  
  @available(iOS 16.0, *)
  func getSongsByGenre(genre: Genre) {
    Task {
      do {
        let musicKitGenre = try await getGenreById(id: genre.getId())
        print("musicKitGenre: \(musicKitGenre)")
        let status = await MusicAuthorization.request()
        switch status {
        case .authorized:
          do {
            let response = try await fetchCatalogCharts(genre: musicKitGenre, kinds: [.mostPlayed], types: [MusicKit.Album.self], limit: 10, offset: 0)
        
            guard let album = response.albumCharts.first?.items.first else { return }
            print("album name: \(album.title)")
            self.album = album
//            playAlbum(album: album)
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
  
  private func playAlbum(album: MusicKit.Album) {
    do {
      if let albumPlayParams = album.playParameters {
        let data = try JSONEncoder().encode(albumPlayParams)
        let playParameters = try JSONDecoder().decode(MPMusicPlayerPlayParameters.self, from: data)
        let queue = MPMusicPlayerPlayParametersQueueDescriptor(playParametersQueue: [playParameters])
        let player = MPMusicPlayerController.applicationMusicPlayer
        player.setQueue(with: queue)
        
        
//        DispatchQueue.main.async {
////          player.play()
//
//          let viewPlayer = MusicKitPlayer(player: player)
//          viewPlayer.play()
//          //        player.prepareToPlay { (error) in
//          //          if let error = error as? MPError {
//          //            print("Error while preparing to play: \(error)")
//          //          } else {
//          //            player.play()
//          //          }
//          //        }
//        }
      } else {
        print("PLAY PARAMS NOT AVAILABLE")
      }
    } catch {
      print(error)
    }
  }
}
