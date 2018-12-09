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
  @IBOutlet private weak var autocompleteInput: UITextField!
  
  var staticProps: StaticProps?
  
  var variableProps: VariableProps? {
    didSet { self.variableProps.map(self.didSetProps) }
  }
  
  func didSetProps(_ props: VariableProps) {
    self.autocompleteInput.text = props.nextState.autocompleteInput
  }
  
  @IBAction func updateAutocompleteInput(_ sender: UITextField) {
    self.variableProps?.action.updateAutocompleteInput(sender.text)
  }
}

extension ViewController2: ReduxCompatibleViewType {
  typealias ReduxState = AppState
  typealias OutProps = ()
  
  struct StateProps: Equatable {
    let autocompleteInput: String?
  }
  
  struct ActionProps {
    let updateAutocompleteInput: (String?) -> Void
  }
}

extension ViewController2: ReduxPropMapperType {
  static func mapState(state: ReduxState, outProps: OutProps) -> StateProps {
    return StateProps(autocompleteInput: state.autocompleteInput)
  }
  
  static func mapAction(dispatch: @escaping Redux.Store.Dispatch,
                        outProps: OutProps) -> ActionProps {
    return ActionProps(
      updateAutocompleteInput: {dispatch(AppAction.updateAutocompleteInput($0))}
    )
  }
}
