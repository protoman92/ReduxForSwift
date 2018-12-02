//
//  Redux.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/2/18.
//  Copyright © 2018 swiften. All rights reserved.
//

public protocol ReduxActionType {}

public struct Subscription {
  public let unsubscribe: () -> Void
  
  public init(_ unsubscribe: @escaping () -> Void) {
    self.unsubscribe = unsubscribe
  }
}

public protocol ReduxStoreType {
  associatedtype State
  
  func lastState() -> State
  
  func dispatch(_ action: ReduxActionType)
  
  func subscribeState(_ subscriberId: String,
                      _ callback: @escaping (State) -> Void) -> Subscription
}

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
  
  public func lastState() -> State {
    return self.state
  }
  
  /// Deliver the action to the internal reducer to produce a new state.
  public func dispatch(_ action: ReduxActionType) {
    self.state = self.reducer(self.state, action)
    
    /// Broadcast the new state to all subscribers.
    self.subscribers.forEach({$1(self.state)})
  }
  
  /// Create a subscription for some subscriber.
  public func subscribeState(_ subscriberId: String,
                             _ callback: @escaping (State) -> Void) -> Subscription {
    self.subscribers[subscriberId] = callback
    return Subscription({self.subscribers.removeValue(forKey: subscriberId)})
  }
}
