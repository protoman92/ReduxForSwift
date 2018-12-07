//
//  Redux+Action+Reducer.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/3/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux

struct AppState {
  let counter: Int
  var valueList: [String?]
  
  init(counter: Int = 0, valueList: [String?] = ["", "", ""]) {
    self.counter = counter
    self.valueList = valueList
  }
  
  func increment() -> AppState {
    return AppState(counter: self.counter + 1)
  }
  
  func updateTextValue(_ index: Int, _ value: String?) -> AppState {
    var clone = self
    let length = self.valueList.count
    
    if index >= 0 && index < length {
      clone.valueList[index] = value
    } else if index >= length {
      clone.valueList.append(value)
    }
    
    return clone
  }
}

enum AppAction: ReduxActionType {
  case incrementCounter
  case updateTextValue(Int, String?)
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
      }
      
    default: return state
    }
  }
}
