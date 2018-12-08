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
  
  init(_ topController: UINavigationController) {
    let router = AppRouter(topController)
    
    self.store = Redux.Middleware.applyMiddlewares([
      Redux.Middleware.Router.Provider(router: router).middleware
      ])(SimpleReduxStore(initialState: AppState(), reducer: AppReducer.reduce))

    self.propInjector = Redux.UI.PropInjector(store: self.store)
  }
}
