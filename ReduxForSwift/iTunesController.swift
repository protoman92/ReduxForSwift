//
//  iTunesController.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/8/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import UIKit

final class iTunesController: UIViewController {
  @IBOutlet weak var autocompleteInput: UITextField!
  @IBOutlet weak var resultTable: UITableView!
  
  var staticProps: StaticProps?
  
  var variableProps: VariableProps? {
    didSet { self.variableProps.map(self.didSetProps) }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "View controller 1",
      style: .plain,
      target: self,
      action: #selector(self.goToViewController1))
  }
  
  private func didSetProps(_ props: VariableProps) {
    let state = props.nextState
    self.autocompleteInput.text = state.autocompleteInput
    self.resultTable.reloadData()
    UIApplication.shared.isNetworkActivityIndicatorVisible = state.progress ?? false
  }
  
  @IBAction func updateAutocompleteInput(_ sender: UITextField) {
    self.variableProps?.action.updateAutocompleteInput(sender.text)
  }
  
  @objc func goToViewController1(_ sender: UIBarButtonItem) {
    self.variableProps?.action.goToViewController1()
  }
}

extension iTunesController: UITableViewDataSource {
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

extension iTunesController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 56
  }
}

extension iTunesController: ReduxCompatibleViewType {
  typealias ReduxState = AppState
  typealias OutProps = ()
  
  struct StateProps: Equatable {
    let autocompleteInput: String?
    let resultCount: Int?
    let progress: Bool?
  }
  
  struct ActionProps {
    let goToViewController1: () -> Void
    let updateAutocompleteInput: (String?) -> Void
  }
}

extension iTunesController: ReduxPropMapperType {
  static func mapState(state: ReduxState, outProps: OutProps) -> StateProps {
    return StateProps(
      autocompleteInput: state.autocompleteInput,
      resultCount: state.iTunesResults?.resultCount,
      progress: state.autocompleteProgress
    )
  }
  
  static func mapAction(dispatch: @escaping Redux.Store.Dispatch,
                        state: ReduxState,
                        outProps: OutProps) -> ActionProps {
    return ActionProps(
      goToViewController1: {dispatch(AppScreen.viewController1)},
      updateAutocompleteInput: {dispatch(AppAction.updateAutocompleteInput($0))}
    )
  }
}
