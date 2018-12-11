//
//  TableCell.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/7/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import UIKit

final class TableCell: UITableViewCell {
  @IBOutlet private weak var textField: UITextField!
  
  var staticProps: StaticProps?

  var variableProps: VariableProps? {
    didSet {
      self.variableProps.map(self.didSetProps)
    }
  }
  
  func didSetProps(_ props: VariableProps) {    
    self.textField.text = props.nextState.textValue
  }
  
  @IBAction func updateTextValue(_ sender: UITextField) {
    self.variableProps?.action.updateTextValue(sender.text)
  }
}

extension TableCell: ReduxCompatibleViewType {
  typealias ReduxState = Dependency.State
  typealias OutProps = Int
  
  struct StateProps: Equatable {
    let textValue: String?
  }
  
  struct ActionProps {
    let updateTextValue: (String?) -> Void
  }
}

extension TableCell: ReduxPropMapperType {
  static func mapState(state: ReduxState, outProps: OutProps) -> StateProps {
    return StateProps(textValue: state.textValueList[outProps])
  }
  
  static func mapAction(dispatch: @escaping Redux.Store.Dispatch,
                        state: ReduxState,
                        outProps: OutProps) -> TableCell.ActionProps {
    return ActionProps(
      updateTextValue: {dispatch(AppAction.updateTextValue(outProps, $0))})
  }
}
