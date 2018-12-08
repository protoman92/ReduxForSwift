//
//  ViewController2.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/8/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import UIKit

final class ViewController2: UIViewController {
  var staticProps: StaticProps?
  var variableProps: VariableProps?
}

extension ViewController2: ReduxCompatibleViewType {
  typealias ReduxState = AppState
  typealias OutProps = ()
  struct StateProps: Equatable {}
  struct ActionProps {}
}

extension ViewController2: ReduxPropMapperType {
  static func mapState(state: ReduxState, outProps: OutProps) -> StateProps {
    return StateProps()
  }
  
  static func mapAction(dispatch: @escaping Redux.Store.Dispatch,
                        outProps: OutProps) -> ActionProps {
    return ActionProps()
  }
}
