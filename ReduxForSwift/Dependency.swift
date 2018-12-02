//
//  Dependency.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/3/18.
//  Copyright © 2018 swiften. All rights reserved.
//

public final class Dependency {
  private static var _instance: Dependency?
  
  public static var shared: Dependency {
    if let instance = self._instance {
      return instance
    } else {
      let instance = Dependency()
      self._instance = instance
      return instance
    }
  }
  
  public let store: SimpleReduxStore<ReduxState>
  
  public init() {
    self.store = SimpleReduxStore(initialState: ReduxState(),
                                  reducer: ReduxReducer.reduce)
  }
}
