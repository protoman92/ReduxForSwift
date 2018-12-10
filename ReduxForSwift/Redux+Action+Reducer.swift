//
//  Redux+Action+Reducer.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/3/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux

struct AppState {
  var autocompleteInput: String?
  var counter: Int
  var iTunesResults: iTunesResult?
  var textValueList: [String?]
  
  init() {
    self.counter = 0
    self.textValueList = []
  }
  
  func increment() -> AppState {
    var clone = self
    clone.counter += 1
    return clone
  }
  
  func updateTextValue(_ index: Int, _ value: String?) -> AppState {
    var clone = self
    let length = self.textValueList.count
    
    if index >= 0 && index < length {
      clone.textValueList[index] = value
    } else if index >= length {
      clone.textValueList.append(value)
    }
    
    return clone
  }
  
  func updateAutocompleteInput(_ input: String?) -> AppState {
    var clone = self
    clone.autocompleteInput = input
    return clone
  }
  
  func updateITunesResults(_ results: iTunesResult?) -> AppState {
    var clone = self
    clone.iTunesResults = results
    return clone
  }
  
  func iTunesTrack(at index: Int) -> iTunesTrack? {
    if
      let tracks = self.iTunesResults?.results,
      index >= 0 && index < tracks.count
    {
      return tracks[index]
    } else {
      return nil
    }
  }
}

enum AppAction: ReduxActionType {
  case incrementCounter
  case updateTextValue(Int, String?)
  case updateAutocompleteInput(String?)
  case updateITunesResults(iTunesResult?)
}

final class AppReducer {
  typealias State = Dependency.State
  
  static func reduce(_ state: State, _ action: ReduxActionType) -> State {
    switch action {
    case let action as AppAction:
      switch action {
      case .incrementCounter:
        return state.increment()

      case .updateTextValue(let index, let value):
        return state.updateTextValue(index, value)
        
      case .updateAutocompleteInput(let input):
        return state.updateAutocompleteInput(input)
        
      case .updateITunesResults(let results):
        return state.updateITunesResults(results)
      }
      
    default: return state
    }
  }
}
