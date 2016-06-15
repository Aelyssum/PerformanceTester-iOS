//
//  TestGroup.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/14/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

//import UIKit

/** Create a subclass of TestGroup to define your own performance tests.  To specify a performance test, create an instance of PerformanceTest and give it a title and the name of your performance test function.  In the init() of your TestGroup subclass, append to the performanceTests array each of your PerformanceTest instances.  Override the setup() method to set up any data structures required for each test.  You can create your own test parameters and configure them in the UI by specifying numberOfTestParameters() and configuring a TestParameterCell with each test parameter.  Use the testParameterDidUpdate() method to get back a value for your test parameter from the UI.
    - Parameter title: The text to display in row in the MainTableViewController and on the navigation bar of TestGroupTableViewController
    - Parameter description: Text that displays under the title text in the row in MainTableViewController, and displays in the help dialog.
*/
class TestGroup: TestParameterDelegate {
    
    /**
    Create instances of this class to specify a performance test.  Initialize the instance with the title text which will display in its row in TestGroupTableViewController and provide the function name of the performance test.
    */
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
    /**
    Intializer for TestGroup. Your subclass should create its own init() and call super.init(title:description) to set these value.  After calling super.init() you can then add your PerformanceTest instances to the performanceTests array.
    */
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    /** 
    Override this method to specify the number of test parameters you will modify through the UI
    - Returns: number of test parameters which will be used by TestGroupTableViewController in numberOfRowsInSection() for section 0.
    */
    func numberOfTestParameters() -> Int {
        return 0
    }
    /** 
    Override this method to configure a TestParameterCell with the test parameter.  Test parameters should conform to either Int or Double.
     
    Usage:
    ```swift
    override func configTestParameter(cell: TestParameterCell, forIndex: Int) {
        if forIndex == 0 {
            cell.config("First Parameter", parameter: intParam1)
        }
    }*/
    func configTestParameter(cell: TestParameterCell, forIndex: Int) {
        
    }
    
    // MARK: - TestParameterDelegate
    
    /**
    Override this method to get back an updated value of a parameter from the UI.
     
    Usage:
    override testParameterDidUpdate<T>(parameter: T, label: String) {
        if label == "First Parameter" {
            intParam1 = parameter as! Int
        }
    }
    */
    func testParameterDidUpdate<T>(parameter: T, label: String) {

    }
    
    /// Override this method to setup any data structures required for a performance test.  Setup called before each performanceTest.  Execution time of setup is not included in performance test results.
    func setup(performanceTest: PerformanceTest) {
        
    }
    
}
