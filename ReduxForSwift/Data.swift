//
//  Data.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/10/18.
//  Copyright © 2018 swiften. All rights reserved.
//

struct iTunesTrack {
  let artistName: String
  let currency: String
  let previewUrl: String
  let trackName: String
  let trackPrice: Double
  let trackTimeMillis: Int
}

struct iTunesResult {
  let resultCount: Int
  let results: [iTunesTrack]
}

extension iTunesTrack: Equatable {}
extension iTunesTrack: Decodable {}
extension iTunesResult: Equatable {}
extension iTunesResult: Decodable {}
