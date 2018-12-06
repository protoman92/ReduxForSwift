//
//  NavigationController.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/6/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
  }
}

extension NavigationController: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController,
                            didShow viewController: UIViewController,
                            animated: Bool) {
    switch viewController {
    case let vc as ViewController1:
      _ = Dependency.shared.propInjector
        .injectProps(controller: vc, outProps: ())
      
    default:
      fatalError()
    }
  }
}
