//
//  ChildNameViewModel.swift
//  MVVMDemo
//
//  Created by liangliang hu on 2018/12/10.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChildNameViewModel {
    // Input
    let validatedUsername: Observable<Bool>
    
    // Output
    let canAddEnabled: Observable<Bool>
    
    // 如果Observable众多，不止一个，这里可以采用input的方式来管理
    init(username: Observable<String>) {
//        validatedUsername = username.flatMapLatest { username in
//            return Observable.create { observer in
//                let validUsername = username.count > 5  // 简化测试
//
//                observer.onNext(validUsername)
//                observer.onCompleted()
//                return Disposables.create()
//            }
//            }.share(replay: 1, scope: .forever)
        // 简化写法
        validatedUsername = username.share(replay: 1, scope: .forever).map({ $0.count > 5 })
        canAddEnabled = validatedUsername
    }
}
