//
//  AppDelegate.swift
//  ReduxForSwift
//
//  Created by Hai Pham on 12/2/18.
//  Copyright © 2018 swiften. All rights reserved.
//

import ReactiveRedux
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
  {
    guard let topController = self.window?.rootViewController as? NavigationController else {
      fatalError()
    }
    
    let api = AppApi(URLSession.shared)
    let repository = AppRepository(api, JSONDecoder())
    let router = AppRouter(topController)
    let sagas = AppSaga.sagas(repository)
    
    let store = Redux.Middleware.applyMiddlewares([
      Redux.Middleware.Router.Provider(router: router).middleware,
      Redux.Middleware.Saga.Provider(effects: sagas).middleware
      ])(SimpleReduxStore(initialState: AppState(), reducer: AppReducer.reduce))

    let dependency = Dependency(store: store)
    topController.dependency = dependency
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {}
  func applicationDidEnterBackground(_ application: UIApplication) {}
  func applicationWillEnterForeground(_ application: UIApplication) {}
  func applicationDidBecomeActive(_ application: UIApplication) {}
  func applicationWillTerminate(_ application: UIApplication) {}
}

