//
//  Redux+Action+Reducer.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/3/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux

public struct AppState {
  public let counter: Int
  
  public init(counter: Int = 0) {
    self.counter = counter
  }
  
  public func increment() -> AppState {
    return AppState(counter: self.counter + 1)
  }
}

public enum AppAction: ReduxActionType {
  case incrementCounter
}

public final class AppReducer {
  public typealias State = AppState
  
  public static func reduce(_ state: State, _ action: ReduxActionType) -> State {
    switch action {
    case let action as AppAction:
      switch action {
      case .incrementCounter: return state.increment()
      }
      
    default: return state
    }
  }
}
