//
//  iTunesTrackCell.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/10/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import UIKit

final class iTunesTrackCell: UITableViewCell {
  @IBOutlet private weak var rootView: UIView!
  @IBOutlet private weak var trackName: UILabel!
  @IBOutlet weak var artistName: UILabel!
  
  var staticProps: StaticProps?
  
  var variableProps: VariableProps? {
    didSet { self.variableProps.map(self.didSetProps) }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.rootView.layer.borderColor = UIColor.gray.cgColor
    self.rootView.layer.borderWidth = 1
    self.rootView.layer.cornerRadius = 8
  }
  
  func didSetProps(_ props: VariableProps) {
    self.trackName.text = props.nextState.iTunesTrack?.trackName
    self.artistName.text = props.nextState.iTunesTrack?.artistName
  }
}

extension iTunesTrackCell: ReduxCompatibleViewType {
  typealias ReduxState = AppState
  typealias OutProps = Int
  
  struct StateProps: Equatable {
    let iTunesTrack: iTunesTrack?
  }
  
  typealias ActionProps = ()
}

extension iTunesTrackCell: ReduxPropMapperType {
  static func mapState(state: ReduxState, outProps: OutProps) -> StateProps {
    return StateProps(iTunesTrack: state.iTunesTrack(at: outProps))
  }
  
  static func mapAction(dispatch: @escaping Redux.Store.Dispatch,
                        outProps: OutProps) -> ActionProps {
    return ()
  }
}
