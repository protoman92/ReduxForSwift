//
//  ViewController1.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/2/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
  @IBOutlet private weak var counterLabel: UILabel!
  
  private var subscription: Subscription?
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.subscription = Dependency.shared.store.subscribeState("VC1", {
      self.counterLabel.text = String(describing: $0.counter)
    })
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.subscription?.unsubscribe()
  }
  
  @IBAction func incrementCounter(_ sender: UIButton) {
    Dependency.shared.store.dispatch(ReduxAction.incrementCounter)
  }
}
