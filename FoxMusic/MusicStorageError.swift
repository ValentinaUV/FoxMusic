//
//  MusicStorageError.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 27.09.2022.
//

import Foundation

public enum MusicStorageError: Error, Equatable {
  case notFound(for: String)
}
