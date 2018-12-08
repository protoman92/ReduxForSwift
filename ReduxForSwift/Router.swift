//
//  Router.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/8/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import UIKit

enum AppScreen: ReduxNavigationScreenType {
  case viewController1
  case viewController2
}

final class AppRouter: ReduxRouterType {
  typealias Screen = AppScreen
  
  private weak var controller: UINavigationController?
  
  init(_ controller: UINavigationController) {
    self.controller = controller
  }
  
  func navigate(_ screen: Screen) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    switch screen {
    case .viewController1:
      let vc = storyboard
        .instantiateViewController(withIdentifier: "ViewController1")
        as! ViewController1
      
      self.controller?.setViewControllers([vc], animated: true)
      
    case .viewController2:
      let vc = storyboard
        .instantiateViewController(withIdentifier: "ViewController2")
        as! ViewController2
      
      self.controller?.setViewControllers([vc], animated: true)
    }
  }
}
