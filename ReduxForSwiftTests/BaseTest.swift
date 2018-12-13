//
//  Dependency.swift
//  ReduxForSwiftTests
//
//  Created by Hai Pham on 12/13/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import XCTest
@testable import ReduxForSwift

class BaseUITest: XCTestCase {
  var mockInjector: Redux.UI.MockInjector<AppState>!
  var mockStaticProps: Redux.UI.MockStaticProps<AppState>!
  
  override func setUp() {
    super.setUp()
    self.mockInjector = Redux.UI.MockInjector(forState: AppState.self)
    self.mockStaticProps = Redux.UI.MockStaticProps(injector: self.mockInjector)
  }
}
