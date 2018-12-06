//
//  Dependency.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/3/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux

final class Dependency {
  typealias PropInjector = Redux.UI.PropInjector<AppState>
  typealias Store = SimpleReduxStore<AppState>
  private static var _instance: Dependency?
  
  static var shared: Dependency {
    if let instance = self._instance {
      return instance
    } else {
      let instance = Dependency()
      self._instance = instance
      return instance
    }
  }
  
  let propInjector: PropInjector
  let store: Store
  
  init() {
    self.store = Store(initialState: AppState(), reducer: AppReducer.reduce)
    self.propInjector = PropInjector(store: self.store)
  }
}
