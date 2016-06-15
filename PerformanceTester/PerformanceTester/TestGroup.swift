//
//  TestGroup.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/14/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

//import UIKit

class TestGroup: TestParameterDelegate {
    
    class PerformanceTest {
        
        enum Status: String {
            case WillRun = "\u{2713}"
            case WillNotRun = "x"
            case IsRunning = "..."
            case Completed = "Done"
        }
        
        var title: String
        var result: Double
        var status: Status
        var performanceTest: () -> ()
        
        init(title: String, performanceTest: () -> ()) {
            self.title = title
            result = 0
            status = .WillRun
            self.performanceTest = performanceTest
        }
    }
    
    var performanceTests = [PerformanceTest]()
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    func numberOfTestParameters() -> Int {
        return 0
    }

    func configTestParameter(cell: TestParameterCell, forIndex: Int) {
        
    }
    
    // MARK: - TestParameterDelegate
    
    func testParameterDidUpdate<T>(parameter: T, label: String) {

    }
    
    /// Setup any data structures required for a performance test.  Setup called before each performanceTest.  Execution time of setup is not included in performance test results.
    func setup(performanceTest: PerformanceTest) {
        
    }
    
}
