//
//  MockUserAPI.swift
//  MVVMDemoTests
//
//  Created by liangliang hu on 2018/12/24.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import UIKit
import RxSwift

@testable import MVVMDemo

class MockUserAPI: UserAPI {
  func usernameAvailable(_ username: String) -> Observable<Bool> {
    return _usernameAvailable(username)
  }
  
  func loginIn(username: String, password: String) -> Observable<Bool> {
    return _loginIn((username, password))
  }
  
  let _usernameAvailable: (String) -> Observable<Bool>
  let _loginIn: ((String, String)) -> Observable<Bool>
  
  init(usernameAvailable: @escaping (String) -> Observable<Bool> = notImplemented(),
       loginIn: @escaping ((String, String)) -> Observable<Bool> = notImplemented()) {
    _usernameAvailable = usernameAvailable
    _loginIn = loginIn
  }
  
}
