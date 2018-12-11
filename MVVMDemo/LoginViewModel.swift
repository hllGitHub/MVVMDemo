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
    var validateUsername: Observable<Bool>
    var validatePassword: Observable<Bool>
    
    // Output
    let logInEnabled: Observable<Bool>
    
    init(input: (username: Observable<String>, password: Observable<String>)) {
        
        // 简化写法
        validateUsername = input.username.share(replay: 1, scope: .forever).map({ $0.count > minimalUsernameLength })
        validatePassword = input.password.share(replay: 1, scope: .forever).map({ $0.count > minimalPasswordLength })
        
        logInEnabled = Observable.combineLatest(validateUsername, validatePassword) { $0 && $1 }.share(replay: 1, scope: .forever)
    }
}
