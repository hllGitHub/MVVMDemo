//
//  ChildNameTests.swift
//  MVVMDemoTests
//
//  Created by liangliang hu on 2018/12/10.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import MVVMDemo

let resolution: TimeInterval = 0.2 // seconds


class ChildNameTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    
    // 测试控制中心，模拟响应式环境中，用户在某一时刻进行某个交互（输入）的情况
    let scheduler = TestScheduler(initialClock: 0)
    //    var viewModel = ChildNameViewModel()
    
    func testValidateUserame() {
        
        // 建立一个可以得到结果的 Observer
        // Bool.self 相当于只观察“是”或“否”两种结果
        let canSendObserver = scheduler.createObserver(Bool.self)
        
        // 创建热信号，next在某个时间点，发送了某个信号
        let inputUsernameObservable = scheduler.createHotObservable([next(100, ("hel")),
                                                                     next(200, ("hello")),
                                                                     next(300, ("helloworld")),
                                                                     completed(500)])
        
        // 初始化，并且绑定数据源
        let viewModel = ChildNameViewModel(username: inputUsernameObservable.asObservable())
        viewModel.canAddEnabled.subscribe(canSendObserver).disposed(by: self.disposeBag)
        
        // 启动
        scheduler.start()
        
        // 测试信号事件
        let expectedCanSendEvents = [
            next(100, false),
            next(200, false),
            next(300, true),
            completed(500)
            ]
        
        // 测试
        XCTAssertEqual(canSendObserver.events, expectedCanSendEvents)
        
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
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
