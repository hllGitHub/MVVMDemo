//
//  LoginTests.swift
//  MVVMDemoTests
//
//  Created by liangliang hu on 2018/12/10.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import MVVMDemo

class LoginTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    
    let scheduler = TestScheduler(initialClock: 0)
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func testLogin() {
//        // 建立可以得到结果的 Observer
//        // Bool.self 相当于只观察"是"或“否”两种结果
//        let canSendObserver = scheduler.createObserver(Bool.self)
//
//        // 创建热信号
//        let inputUsernameObservable = scheduler.createHotObservable([next(100, ("nihao")),
//                                                                     next(200, ("nihaoa")),
//                                                                     next(300, ("nihaoa")),
//                                                                     completed(500)])
//        let inputPasswordObservable = scheduler.createHotObservable([next(100, ("12345")),
//                                                                     next(200, ("12345")),
//                                                                     next(300, ("123456")),
//                                                                     completed(500)])
//        let viewModel = LoginViewModel(input: (username: inputUsernameObservable.asObservable(), password: inputPasswordObservable.asObservable()))
//        viewModel.logInEnabled.subscribe(canSendObserver).disposed(by: self.disposeBag)
//
//        // 启动
//        scheduler.start()
//
//        // 测试信号事件
//        let expectedCanSendEvents = [
//            next(100, false),
//            next(200, false),
//            next(300, false),
//            completed(500)
//        ]
//
//        // f--------------------------------t---
//
//        // 测试
//        XCTAssertEqual(canSendObserver.events, expectedCanSendEvents)
//
//    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
