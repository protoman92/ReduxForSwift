//
//  Redux+Saga.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/10/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux

final class AppSaga {
  typealias Effect = Redux.Saga.Effect
  
  /// The app's saga branches.
  static func sagas(_ api: AppRepositoryType) -> [Effect<AppState, Any>] {
    return [
      Redux.Saga.Effect.takeLatest(
        paramExtractor: self.autocompleteParam,
        effectCreator: {self.autocompleteSaga(api, $0)},
        options: Redux.Saga.TakeOptions.builder().with(debounce: 0.5).build())
    ]
  }
  
  /// Extract the autocomplete query from an action.
  static func autocompleteParam(_ action: AppAction) -> String? {
    switch action {
    case .updateAutocompleteInput(let input): return input
    default: return nil
    }
  }
  
  static func autocompleteSaga(_ api: AppRepositoryType, _ input: String)
    -> Effect<AppState, Any>
  {
    return Redux.Saga.Effect<AppState, Bool>
      .put(true, actionCreator: AppAction.updateAutocompleteProgress)
      .then(input).call(api.searchITunes)
      .put(AppAction.updateITunesResults, usingQueue: .global(qos: .background))
      .catchError({_ in ()})
      .then(false).put(AppAction.updateAutocompleteProgress)
  }
  
  /// Verbose saga to demonstrate full use of helper functions.
  static func verboseAutocompleteSaga(_ api: AppRepositoryType, _ input: String)
    -> Redux.Saga.Effect<AppState, Any>
  {
    /// Create an Effect wrapper from the input string.
    let inputEffect = Redux.Saga.Effect<AppState, String>.just(input)
    
    /// Create a CallEffect to invoke the search API on the query.
    let callEffect = Redux.Saga.Effect
      .call(with: inputEffect, callCreator: api.searchITunes)
    
    /// Create a PutEffect to deposit search results into the Redux Store.
    return Redux.Saga.Effect
      .put(callEffect, actionCreator: AppAction.updateITunesResults)
  }
}
