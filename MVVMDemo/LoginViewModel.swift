//
//  LoginViewModel.swift
//  MVVMDemo
//
//  Created by liangliang hu on 2018/12/10.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class LoginViewModel {
  // Input
  var validateUsername: Observable<ValidationResult>
  var validatePassword: Observable<ValidationResult>
  
  // Output
  let logInEnabled: Observable<Bool>
  let signingIn: Observable<Bool>
  let signedIn: Observable<Bool>
  
  init(input: (
        username: Observable<String>,
        password: Observable<String>,
        loginTaps: Observable<Void>),
       dependency: (
    API: UserDefaultAPI,
    validationService: ValidationService
        )
    ) {
    
    let API = dependency.API
    let validationService = dependency.validationService
        
    // 简化写法
    validateUsername = input.username.flatMapLatest { username in
      return validationService.validateUsername(username).observeOn(MainScheduler.instance).catchErrorJustReturn(.failed)
    }
    
    validatePassword = input.password.flatMapLatest { password in
      return validationService.validatePassword(password).observeOn(MainScheduler.instance).catchErrorJustReturn(.failed)
    }
    signingIn = Observable.just(false)
    
    logInEnabled = Observable.combineLatest(validateUsername, validatePassword, self.signingIn) { username, password, signingIn in
      username.isValid && password.isValid && !signingIn
      }.distinctUntilChanged().share(replay: 1, scope: .forever)
    
    
    let usernameAndPassword = Observable.combineLatest(input.username, input.password) { (username: $0, password: $1) }
    signedIn = input.loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest { pair in
      return API.loginIn(username: pair.username, password: pair.password).observeOn(MainScheduler.instance).catchErrorJustReturn(false)
      }.flatMapLatest { loggedIn -> Observable<Bool> in
        return Observable.just(loggedIn)
      }
    }
}
