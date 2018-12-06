//
//  ViewController1.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/2/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import UIKit

class ViewController1: UIViewController {
  @IBOutlet private weak var counterLabel: UILabel!
  
  /// Required by prop injector.
  var staticProps: StaticProps?
  
  /// Required by prop injector.
  var variableProps: VariableProps? {
    didSet {
      self.variableProps.map(self.didSetProps)
    }
  }
  
  func didSetProps(_ props: VariableProps) {
    self.counterLabel.text = String(describing: props.nextState.counter)
  }
  
  @IBAction func incrementCounter(_ sender: UIButton) {
    self.variableProps?.action.incrementCounter()
  }
}

extension ViewController1: ReduxCompatibleViewType {
  typealias ReduxState = Dependency.State
  typealias OutProps = ()
  
  struct StateProps: Equatable {
    let counter: Int
  }
  
  struct ActionProps {
    let incrementCounter: () -> Void
  }
}

extension ViewController1: ReduxPropMapperType {
  static func mapState(state: AppState, outProps: OutProps) -> StateProps {
    return StateProps(counter: state.counter)
  }
  
  static func mapAction(dispatch: @escaping Redux.Store.Dispatch,
                        outProps: OutProps) -> ActionProps {
    return ActionProps(incrementCounter: {dispatch(AppAction.incrementCounter)})
  }
}
