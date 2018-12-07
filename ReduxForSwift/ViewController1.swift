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
  @IBOutlet private weak var tableView: UITableView!
  
  /// Required by prop injector.
  var staticProps: StaticProps?
  
  /// Required by prop injector.
  var variableProps: VariableProps? {
    didSet {
      self.variableProps.map(self.didSetProps)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.counterLabel.layer.cornerRadius = 4
    self.counterLabel.layer.borderWidth = 1
    self.counterLabel.layer.borderColor = UIColor.gray.cgColor
  }
  
  func didSetProps(_ props: VariableProps) {
    self.counterLabel.text = String(describing: props.nextState.counter)
    self.tableView.reloadData()
  }
  
  @IBAction func incrementCounter(_ sender: UIButton) {
    self.variableProps?.action.incrementCounter()
  }
}

extension ViewController1: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return self.variableProps?.nextState.valueCount ?? 0
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView
      .dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
      as! TableCell
    
    self.staticProps?.injector.injectProps(view: cell, outProps: indexPath.row)
    return cell
  }
}

extension ViewController1: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 56
  }
}

extension ViewController1: ReduxCompatibleViewType {
  typealias ReduxState = Dependency.State
  typealias OutProps = ()
  
  struct StateProps: Equatable {
    let counter: Int
    let valueCount: Int
  }
  
  struct ActionProps {
    let incrementCounter: () -> Void
  }
}

extension ViewController1: ReduxPropMapperType {
  static func mapState(state: AppState, outProps: OutProps) -> StateProps {
    return StateProps(counter: state.counter,
                      valueCount: state.valueList.count)
  }
  
  static func mapAction(dispatch: @escaping Redux.Store.Dispatch,
                        outProps: OutProps) -> ActionProps {
    return ActionProps(incrementCounter: {dispatch(AppAction.incrementCounter)})
  }
}
