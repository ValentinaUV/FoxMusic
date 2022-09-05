//
//  AlbumViewModel.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 31.08.2022.
//

import Foundation

class AlbumViewModel {
    private let albums = Album.get()
    
    func getAlbumsCount() -> Int {
        return albums.count
    }
    
    func getAlbum(index: Int) -> Album {
        return albums[index]
    }
}
