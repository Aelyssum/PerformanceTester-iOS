//
//  TestGroupTableViewController.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class TestGroupTableViewController: UITableViewController, TestParameterDelegate {
    
    var helpText: String
    
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
        var performanceTest: () -> Double
        
        init(title: String, performanceTest: () -> Double) {
            self.title = title
            result = 0
            status = .WillRun
            self.performanceTest = performanceTest
        }
    }
    
    var performanceTests = [PerformanceTest]()
    
    init(title: String, description: String) {
        self.helpText = description
        super.init(style: .Grouped)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TestParameterCell.register(tableView)
        TestCell.register(tableView)
        TestParameterCell.delegate = self
        self.navigationItem.title = title
        self.navigationItem.rightBarButtonItems = [
        UIBarButtonItem(title: "Run", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(runTests)),
        UIBarButtonItem(image: UIImage(named: "help"), style: .Plain, target: self, action: #selector(getHelp))
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Test Parameters"
        } else {
            return "Test Results"
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0 // Error should be overidden by subclass
        } else {
            return performanceTests.count            
        }
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = TestCell.dequeueOnto(tableView, atIndexPath: indexPath)
        cell.config(performanceTests[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            clearTests()
            let test = performanceTests[indexPath.row]
            if test.status == .WillRun {
                test.status = .WillNotRun
            } else if test.status == .WillNotRun {
                test.status = .WillRun
            }
        }
    }

    var testIndex = 0
    
    func getHelp() {
        let vcAlert = UIAlertController(title: title, message: helpText, preferredStyle: .Alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
        vcAlert.addAction(dismissAction)
        self.presentViewController(vcAlert, animated: true, completion: nil)
    }
    
    func runTests() {
        NSLog("runTests: Executed")
        clearTests()
        runNextTest()
    }
    
    func runNextTest() {
        if !performanceTests.isEmpty && testIndex < performanceTests.count {
            let test = performanceTests[testIndex]
            if test.status == .WillRun {
                test.status = .IsRunning
                tableView.reloadData()
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)) {
                    test.result = test.performanceTest()
                    test.status = .Completed
                    dispatch_async(dispatch_get_main_queue()) {
                        self.tableView.reloadData()
                        self.testIndex += 1
                        self.runNextTest()
                    }
                }
                NSLog("Running: \(test.title)")
            }
            
        }
    }

    func clearTests() {
        testIndex = 0
        for test in performanceTests {
            if test.status == .Completed {
                test.status = .WillRun
            }
        }
        tableView.reloadData()
    }
    // MARK: - TestParameterDelegate method
    
    func testParameterDidUpdate(sender: TestParameterCell, label: String) {

    }

}
