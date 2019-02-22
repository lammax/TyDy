//
//  TyDyListSceneInteractor.swift
//  TyDy
//
//  Created by Mac on 25/01/2019.
//  Copyright (c) 2019 Lammax. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TyDyListSceneBusinessLogic
{
  func doSomething(request: TyDyListScene.Something.Request)
}

protocol TyDyListSceneDataStore
{
  //var name: String { get set }
}

class TyDyListSceneInteractor: TyDyListSceneBusinessLogic, TyDyListSceneDataStore
{
  var presenter: TyDyListScenePresentationLogic?
  var worker: TyDyListSceneWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: TyDyListScene.Something.Request)
  {
    worker = TyDyListSceneWorker()
    worker?.doSomeWork()
    
    let response = TyDyListScene.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
