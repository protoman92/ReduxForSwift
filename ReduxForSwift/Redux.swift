//
//  Redux.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/2/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux

public final class SimpleReduxStore<State>: ReduxStoreType {
  private var state: State
  private let reducer: (State, ReduxActionType) -> State
  private var subscribers: [String : (State) -> Void]
  
  public init(initialState: State,
              reducer: @escaping (State, ReduxActionType) -> State) {
    self.state = initialState
    self.reducer = reducer
    self.subscribers = [:]
  }
  
  public var lastState: Redux.Store.LastState<State> {
    return {self.state}
  }
  
  /// Deliver the action to the internal reducer to produce a new state.
  public var dispatch: Redux.Store.Dispatch {
    return {action in
      self.state = self.reducer(self.state, action)
    
      /// Broadcast the new state to all subscribers.
      self.subscribers.forEach({$1(self.state)})
    }
  }
  
  /// Create a subscription for some subscriber.
  public var subscribeState: Redux.Store.Subscribe<State> {
    return {(subscriberId, callback) in
      self.subscribers[subscriberId] = callback

      return Redux.Store
        .Subscription({self.subscribers.removeValue(forKey: subscriberId)})
    }
  }
}
