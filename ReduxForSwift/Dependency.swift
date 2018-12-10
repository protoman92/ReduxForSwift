//
//  Dependency.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/3/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux

final class Dependency {
  typealias State = AppState
  typealias Store = Redux.Store.DelegateStore<State>
  
  let propInjector: Redux.UI.PropInjector<State>
  let store: Store
  
  init(store: Redux.Store.DelegateStore<State>) {
    self.store = store
    self.propInjector = Redux.UI.PropInjector(store: self.store)
  }
}
