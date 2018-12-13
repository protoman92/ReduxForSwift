//
//  AutocompleteSaga.swift
//  ReduxForSwiftTests
//
//  Created by Hai Pham on 12/13/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import XCTest
@testable import ReduxForSwift

final class AutocompleteSagaTest: XCTestCase {
  let timeout: TimeInterval = 10
  var searchResult: iTunesResult?
  var searchError: Error?
}

extension AutocompleteSagaTest {
  func test_autocompleteSaga_shouldDispatchCorrectActions() {
    /// Setup
    let query = "Search query"
    let effect = AppSaga.autocompleteSaga(self, query)
    let state = AppState()
    var actions: [ReduxActionType] = []
    self.searchResult = iTunesResult(resultCount: 0, results: [])
    
    /// When
    let output = effect.invoke(withState: state, dispatch: {actions.append($0)})
    _ = output.nextValue(timeoutInSeconds: self.timeout)
    
    /// Then
    XCTAssertEqual(actions as! [AppAction], [
      .updateAutocompleteProgress(true),
      .updateITunesResults(self.searchResult!),
      .updateAutocompleteProgress(false)
      ])
  }
  
  func test_searchFailsWithError_shouldDispatchCorrectActions() {
    /// Setup
    let effect = AppSaga.autocompleteSaga(self, "")
    let state = AppState()
    var actions: [ReduxActionType] = []
    self.searchError = Redux.Saga.Error.unimplemented
    
    /// When
    let output = effect.invoke(withState: state, dispatch: {actions.append($0)})
    _ = output.nextValue(timeoutInSeconds: self.timeout)
    
    /// Then
    XCTAssertEqual(actions as! [AppAction], [
      .updateAutocompleteProgress(true),
      .updateAutocompleteProgress(false)
      ])
  }
}

extension AutocompleteSagaTest: AppRepositoryType {
  func searchITunes(_ input: String, _ cb: @escaping (iTunesResult?, Error?) -> Void) {
    cb(self.searchResult, self.searchError)
  }
}
