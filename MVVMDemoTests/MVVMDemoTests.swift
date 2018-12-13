//
//  MVVMDemoTests.swift
//  MVVMDemoTests
//
//  Created by liangliang hu on 2018/12/10.
//  Copyright © 2018年 liangliang hu. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import UIKit

@testable import MVVMDemo

class MVVMDemoTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMap_Range() {
        let scheduler = TestScheduler(initialClock: 0)
        
        let xs = scheduler.createHotObservable([.next(150, 1),
                                                .next(210, 0),
                                                .next(220, 1),
                                                .next(230, 2),
                                                .next(240, 4),
                                                .completed(300)])
        
        let res = scheduler.start { xs.map { $0 * 2 } }
        
        let correctMessages = Recorded.events(
            .next(210, 0 * 2),
            .next(220, 1 * 2),
            .next(230, 2 * 2),
            .next(240, 4 * 2),
            .completed(300)
        )
        
        let correctSuscriptions = [Subscription(200, 300)]
        
        XCTAssertEqual(res.events, correctMessages)
        XCTAssertEqual(xs.subscriptions, correctSuscriptions)
    }
  
  
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      // 设置初始变量
      let a = 10
      let b = 15
      let expected = 25
      
      // 得到实际值
      let actual = self.add(a: a, b: b)
      
      // 断言判断
      XCTAssertEqual(expected, actual, "add方法错误")
    }
  
  func testAsynExample() {
    let exp: XCTestExpectation = self.expectation(description: "错误信息")
    
    let queue: OperationQueue = OperationQueue.init()
    queue .addOperation {
      // 模拟异步操作，耗时2s
      sleep(2)
      XCTAssertEqual("a", "a")
      exp.fulfill()
    }
    
    self.waitForExpectations(timeout: 3) { (error) in
      if (error != nil) {
        print("Timeout Error: \(String(describing: error))")
      }
    }
  }
  
  func add(a: Int, b: Int) -> Int {
    return a + b
  }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

