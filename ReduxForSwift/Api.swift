//
//  Api.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/10/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import Foundation

protocol AppApiType {
  func searchITunes(_ input: String, _ cb: @escaping (Data?, Error?) -> Void)
}

struct AppApi: AppApiType {
  private let _urlSession: URLSession
  
  init(_ urlSession: URLSession) {
    self._urlSession = urlSession
  }
  
  func searchITunes(_ input: String, _ cb: @escaping (Data?, Error?) -> Void) {
    var comps = URLComponents(string: "https://itunes.apple.com/search")!
    
    comps.queryItems = [
      URLQueryItem(name: "term", value: input),
      URLQueryItem(name: "limit", value: "5"),
      URLQueryItem(name: "media", value: "music")
    ]
    
    let task = self._urlSession.dataTask(with: comps.url!) {cb($0, $2)}
    task.resume()
  }
}
