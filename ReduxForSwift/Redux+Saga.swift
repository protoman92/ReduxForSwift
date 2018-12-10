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
  
  static func sagas(_ api: AppRepositoryType) -> [Effect<AppState, Any>] {
    return [
      Redux.Saga.Effect.takeLatest(
        paramExtractor: self.autocompleteParam,
        effectCreator: {self.autocompleteSaga(api, $0)},
        options: Redux.Saga.TakeOptions.builder().with(debounce: 0.5).build())
    ]
  }
  
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
      .put(AppAction.updateITunesResults)
      .catchError({_ in ()})
      .then(false).put(AppAction.updateAutocompleteProgress)
  }
}
