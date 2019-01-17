//
//  Protocols.swift
//  MVVMDemo
//
//  Created by liangliang hu on 2018/12/24.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import RxCocoa
import RxSwift

enum ValidationResult {
  case success
  case failed
  case empty
}

protocol UserAPI {
  func usernameAvailable(_ username: String) -> Observable<Bool>
  func loginIn(username: String, password: String) -> Observable<Bool>
}

protocol UserService {
  func validateUsername(_ username: String) -> Observable<ValidationResult>
  func validatePassword(_ password: String) -> Observable<ValidationResult>
}

extension ValidationResult {
  var isValid: Bool {
    switch self {
    case .success:
      return true
    default:
      return false
    }
  }
}
