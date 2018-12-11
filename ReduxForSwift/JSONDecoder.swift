//
//  JSONDecoder.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/10/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import Foundation

/// Use this protocol to represent a JSON decoder.
protocol JSONDecoderType {
  func decode<D>(_ type: D.Type, from data: Data) throws -> D where D: Decodable
}

extension JSONDecoder: JSONDecoderType {}
