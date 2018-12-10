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
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

