//
//  TestGroup.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import Foundation

class TestGroup {
    
    var title: String
    var description: String
    
    struct TestParameter {
        var label: String
        var parameter: Double
    }

    var testParameters = [TestParameter]()
    
    struct PerformanceTest {
        var title: String
        var result: Double
        var performanceTest: () -> Double
    }

    var performanceTests = [PerformanceTest]()

    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
