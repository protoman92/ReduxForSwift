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
  @IBOutlet private weak var resultTable: UITableView!
  
  var staticProps: StaticProps?
  
  var variableProps: VariableProps? {
    didSet { self.variableProps.map(self.didSetProps) }
  }
  
  func didSetProps(_ props: VariableProps) {
    let state = props.nextState
    self.autocompleteInput.text = state.autocompleteInput
    self.resultTable.reloadData()
    UIApplication.shared.isNetworkActivityIndicatorVisible = state.progress ?? false
  }
  
  @IBAction func updateAutocompleteInput(_ sender: UITextField) {
    self.variableProps?.action.updateAutocompleteInput(sender.text)
  }
}

extension ViewController2: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return self.variableProps?.nextState.resultCount ?? 0
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView
      .dequeueReusableCell(withIdentifier: "iTunesTrackCell")
      as! iTunesTrackCell
    
    self.staticProps?.injector.injectProps(view: cell, outProps: indexPath.row)
    return cell
  }
}

extension ViewController2: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 56
  }
}

extension ViewController2: ReduxCompatibleViewType {
  typealias ReduxState = AppState
  typealias OutProps = ()
  
  struct StateProps: Equatable {
    let autocompleteInput: String?
    let resultCount: Int?
    let progress: Bool?
  }
  
  struct ActionProps {
    let updateAutocompleteInput: (String?) -> Void
  }
}

extension ViewController2: ReduxPropMapperType {
  static func mapState(state: ReduxState, outProps: OutProps) -> StateProps {
    return StateProps(
      autocompleteInput: state.autocompleteInput,
      resultCount: state.iTunesResults?.resultCount,
      progress: state.autocompleteProgress
    )
  }
  
  static func mapAction(dispatch: @escaping Redux.Store.Dispatch,
                        outProps: OutProps) -> ActionProps {
    return ActionProps(
      updateAutocompleteInput: {dispatch(AppAction.updateAutocompleteInput($0))}
    )
  }
}
