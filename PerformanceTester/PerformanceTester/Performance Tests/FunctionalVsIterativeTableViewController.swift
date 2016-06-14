//
//  TableViewController.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class FunctionalVsIterativeTableViewController: TestGroupTableViewController {

    var arraySize = 1000000
    
    init() {
        super.init(
            title: "Functional vs. Iterative Tests",
            description: "Functional tests use the reduce() method on the array, whereas Iterative tests use a for loop with accumulation"
            )
        performanceTests.append(
            PerformanceTest(title: "Functional Sum", performanceTest: performanceTestSumFunctional)
        )
        performanceTests.append(
            PerformanceTest(title: "Iterative Sum", performanceTest: performanceTestSumIterative)
        )
        performanceTests.append(
            PerformanceTest(title: "Functional Class", performanceTest: performanceTestMomentsFunctional)
        )
        performanceTests.append(
            PerformanceTest(title: "Iterative Class", performanceTest: performanceTestMomentsIterative)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return performanceTests.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = TestParameterCell.dequeueOnto(tableView, atIndexPath: indexPath)
            cell.config("Array Size", param: arraySize)
            return cell
        } else {
            let cell = TestCell.dequeueOnto(tableView, atIndexPath: indexPath)
            cell.config(performanceTests[indexPath.row])
            return cell
        }
    }

    // MARK: - TestParameterDelegate method
    
    override func testParameterDidUpdate(sender: TestParameterCell, label: String) {
        NSLog("testParamterDidUpdate: \(label)")
        if label == "Array Size" {
            arraySize = sender.intParameter!
        }
    }
    
    // MARK: - Performance Tests

    func performanceTestSumFunctional() -> Double {
        let intArray = Array(0 ..< Int(arraySize))
        let myArray = intArray.map() {
            element in
            return Double(element)
        }
        var sum = 0.0
        let startTime = NSDate()
        sum = myArray.reduce(0.0) {
            sum, element in
            
            return sum + element
        }
        let endTime = NSDate()
        return endTime.timeIntervalSinceDate(startTime)
    }
    
    func performanceTestSumIterative() -> Double {
        let intArray = Array(0 ..< Int(arraySize))
        let myArray = intArray.map() {
            element in
            return Double(element)
        }
        var sum = 0.0
        let startTime = NSDate()
        for element in myArray {
            sum += element
        }
        let endTime = NSDate()
        return endTime.timeIntervalSinceDate(startTime)
    }
    
    class Moments {
        var mean = 0.0
        var variance = 0.0
    }
    
    func performanceTestMomentsFunctional() -> Double {
        let intArray = Array(0 ..< arraySize)
        let myArray = intArray.map() {
            element in
            return Double(element)
        }
        var moments = Moments()
        let startTime = NSDate()
        //        moments = myArray.reduce(Moments(), combine: +)
        moments = myArray.reduce(Moments()) {
            moments, element in
            moments.mean += element
            moments.variance += element*element
            return moments
        }
        let endTime = NSDate()
        return endTime.timeIntervalSinceDate(startTime)
    }
    
    func performanceTestMomentsIterative() -> Double {
        let intArray = Array(0 ..< arraySize)
        let myArray = intArray.map() {
            element in
            return Double(element)
        }
        var moments = Moments()
        let startTime = NSDate()
        for element in myArray {
            moments.mean += element
            moments.variance += element*element
        }
        let endTime = NSDate()
        return endTime.timeIntervalSinceDate(startTime)
    }
    


}
