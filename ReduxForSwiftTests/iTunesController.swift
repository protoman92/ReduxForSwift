//
//  iTunesController.swift
//  ReduxForSwiftTests
//
//  Created by Hai Pham on 12/13/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import XCTest
@testable import ReduxForSwift

final class iTunesControllerTest: BaseUITest {
  private var controller: iTunesController!
  
  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    self.controller = storyboard
      .instantiateViewController(withIdentifier: "iTunesController")
      as? iTunesController
    
    _ = self.controller.view
  }
}

extension iTunesControllerTest {
  func test_injectingNewState_shouldPopulateViews() {
    let app = UIApplication.shared
    let vc = self.controller!
    
    for _ in 0...1000 {
      /// Setup
      let query = (0..<10)
        .map({_ in "abcd".randomElement()!})
        .map(String.init)
        .joined()
      
      let resultCount = (0..<100).randomElement()!
      let progress = Bool.random()
      var goToViewController1 = 0
      var updatedAutocompleteInput: String? = nil

      let stateProps = iTunesController.StateProps(
        autocompleteInput: query,
        resultCount: resultCount,
        progress: progress
      )
      
      let actionProps = iTunesController.ActionProps(
        goToViewController1: {goToViewController1 += 1},
        updateAutocompleteInput: {updatedAutocompleteInput = $0}
      )
      
      /// When
      vc.variableProps = Redux.UI
        .VariableProps(false, nil, stateProps, actionProps)
      
      app.sendAction(
        vc.navigationItem.rightBarButtonItem!.action!,
        to: vc, from: self, for: nil)

      vc.autocompleteInput.sendActions(for: .editingChanged)
      
      /// Then
      XCTAssertEqual(vc.autocompleteInput.text, query)
      XCTAssertEqual(vc.resultTable.numberOfRows(inSection: 0), resultCount)
      XCTAssertEqual(UIApplication.shared.isNetworkActivityIndicatorVisible, progress)
      XCTAssertEqual(goToViewController1, 1)
      XCTAssertEqual(updatedAutocompleteInput, query)
    }
  }
  
  func test_dequeuingTableCell_shouldInjectProps() {
    /// Setup
    self.controller.staticProps = self.mockStaticProps

    /// When
    _ = self.controller.tableView(
      self.controller.resultTable,
      cellForRowAt: IndexPath(row: 0, section: 0))

    /// Then
    XCTAssertTrue(self.mockInjector.didInject(iTunesTrackCell.self, times: 1))
  }
}
