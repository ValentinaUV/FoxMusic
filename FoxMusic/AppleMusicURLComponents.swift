//
//  AppleMusicURLComponents.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 07.09.2022.
//

import Foundation

struct AppleMusicURLComponents {
  private var components: URLComponents

  init() {
    self.components = URLComponents()
    components.scheme = "https"
    components.host = "api.music.apple.com"
  }
  
  var queryItems: [URLQueryItem]? {
    get {
      components.queryItems
    } set {
      components.queryItems = newValue
    }
  }

  var path: String {
    get {
      return components.path
    } set {
      components.path = "/v1/" + newValue
    }
  }

  var url: URL? {
    components.url
  }
}

