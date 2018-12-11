//
//  Repository.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/10/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import Foundation

protocol AppRepositoryType {
  func searchITunes(_ input: String, _ cb: @escaping (iTunesResult?, Error?) -> Void)
}

struct AppRepository: AppRepositoryType {
  private let _api: AppApiType
  private let _decoder: JSONDecoderType
  
  /// Use JSONDecoderType here to allow mocks.
  init(_ api: AppApiType, _ decoder: JSONDecoderType) {
    self._api = api
    self._decoder = decoder
  }
  
  /// Call the iTunes API and decode the result into a custom data structure.
  func searchITunes(_ input: String, _ cb: @escaping (iTunesResult?, Error?) -> Void) {
    self._api.searchITunes(input) {(d, err) in
      do {
        let data = try d.getOrThrow("")
        let results = try self._decoder.decode(iTunesResult.self, from: data)
        cb(results, nil)
      } catch let e {
        cb(nil, err ?? e)
      }
    }
  }
}
