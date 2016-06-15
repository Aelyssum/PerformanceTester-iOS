//
//  TestGroupTableViewController.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class TestGroupTableViewController: UITableViewController {
    
    var testGroup: TestGroup
    var queue: dispatch_queue_t
    
    init(testGroup: TestGroup) {
        self.testGroup = testGroup
        self.queue = dispatch_queue_create(testGroup.title, DISPATCH_QUEUE_SERIAL)
        super.init(style: .Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TestParameterCell.register(tableView)
        TestCell.register(tableView)
        TestParameterCell.delegate = testGroup
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
            return testGroup.numberOfTestParameters()
        } else {
            return testGroup.performanceTests.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = TestParameterCell.dequeueOnto(tableView, atIndexPath: indexPath)
            testGroup.configTestParameter(cell, forIndex: indexPath.row)
            return cell
        } else {
            let cell = TestCell.dequeueOnto(tableView, atIndexPath: indexPath)
            cell.config(testGroup.performanceTests[indexPath.row])
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            clearTests()
            let test = testGroup.performanceTests[indexPath.row]
            if test.status == .WillRun {
                test.status = .WillNotRun
            } else if test.status == .WillNotRun {
                test.status = .WillRun
            }
        }
    }

    var testIndex = 0
    
    func getHelp() {
        let vcAlert = UIAlertController(title: testGroup.title, message: testGroup.description, preferredStyle: .Alert)
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
        if !testGroup.performanceTests.isEmpty && testIndex < testGroup.performanceTests.count {
            let test = testGroup.performanceTests[testIndex]
            NSLog("runNextTest: \(test.title)")
            if test.status == .WillRun {
                test.status = .IsRunning
                tableView.reloadData()
                dispatch_async(queue) {
                    self.testGroup.setup(test)
                    let startTime = NSDate()
                    test.performanceTest()
                    let endTime = NSDate()
                    test.result = endTime.timeIntervalSinceDate(startTime)
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
        for test in testGroup.performanceTests {
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
