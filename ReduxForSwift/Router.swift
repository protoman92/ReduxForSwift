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
  case iTunesSearch
  case viewController1
  case externalUrl(String?)
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
    case .iTunesSearch:
      let vc = storyboard
        .instantiateViewController(withIdentifier: "iTunesController")
        as! iTunesController
      
      self.controller?.setViewControllers([vc], animated: true)
      
    case .viewController1:
      let vc = storyboard
        .instantiateViewController(withIdentifier: "ViewController1")
        as! ViewController1
      
      self.controller?.setViewControllers([vc], animated: true)
      
    case .externalUrl(let urlString):
      if let urlStr = urlString, let url = URL(string: urlStr) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
    }
  }
}
