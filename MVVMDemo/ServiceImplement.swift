//
//  ServiceImplement.swift
//  MVVMDemo
//
//  Created by liangliang hu on 2018/12/24.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import UIKit
import RxSwift
import Foundation

import struct Foundation.CharacterSet
import struct Foundation.URL
import struct Foundation.URLRequest

class ValidationService: UserService {
  static let sharedValidationService = ValidationService.init()
  
  let minUsernameCount = 2
  let minPasswordCount = 2
  
  func validateUsername(_ username: String) -> Observable<ValidationResult> {
    if username.isEmpty {
      return .just(.empty)
    }
    
    if username.count < minUsernameCount {
      return .just(.failed)
    }
    
    return .just(.success)
  }
  
  func validatePassword(_ password: String) -> Observable<ValidationResult> {
    if password.isEmpty {
      return .just(.empty)
    }
    
    if password.count < minPasswordCount {
      return .just(.failed)
    }
    
    return .just(.success)
  }
}

class UserDefaultAPI: UserAPI {
  let URLSession1: Foundation.URLSession
  
  static let sharedAPI = UserDefaultAPI(
    URLSession: Foundation.URLSession.shared
  )
  
  init(URLSession: Foundation.URLSession) {
    self.URLSession1 = URLSession
  }
  
  func usernameAvailable(_ username: String) -> Observable<Bool> {
    let url = URL(string: "http://api.staging.kangyu.co/v3/session/")!
    let request = URLRequest(url: url)
    return self.URLSession1.rx.response(request: request)
      .map { pair in
        return pair.response.statusCode == 404
    }
    .catchErrorJustReturn(false)
  }
  
  func loginIn(username: String, password: String) -> Observable<Bool> {
    
    let url = URL(string: "http://api.staging.kangyu.co/v3/session/")!
    let parameters = ["phone" : username, "password" : password, "locale" : "zh-CN", "city_id" : "4133"]
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
    } catch let error {
      print(error.localizedDescription)
    }
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error  in
      guard error == nil else {
        print("error = \(String(describing: error))")
        return
      }
      
      guard let data = data else {
        return
      }
      
      print("data = \(data)")
      
      do {
        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
          print("json = \(json)")
        }
      } catch let error {
        print(error.localizedDescription)
      }
    })
    task.resume()
    
    return self.URLSession1.rx.data(request: request).map { pair in
      print(pair)
      return true
    }.catchErrorJustReturn(false)
  }
}
