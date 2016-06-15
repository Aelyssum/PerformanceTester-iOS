//
//  FunctionalVsIterativeTestGroup.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/14/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import Foundation
import UIKit

class FunctionalVsIterativeTestGroup: TestGroup {
    
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
            PerformanceTest(title: "Functional Struc", performanceTest: performanceTestMomentStrucFunctional)
        )
        performanceTests.append(
            PerformanceTest(title: "Iterative Struc", performanceTest: performanceTestMomentStrucIterative)
        )
        performanceTests.append(
            PerformanceTest(title: "Functional Class", performanceTest: performanceTestMomentsFunctional)
        )
        performanceTests.append(
            PerformanceTest(title: "Iterative Class", performanceTest: performanceTestMomentsIterative)
        )
    }

    override func numberOfTestParameters() -> Int {
        return 1
    }
    
    override func getTestParameterCell(tableView: UITableView, indexPath: NSIndexPath) -> TestParameterCell {
        let cell = TestParameterCell.dequeueOnto(tableView, atIndexPath: indexPath)
        cell.config("Array Size", param: arraySize)
        return cell
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
    
    struct MomentStruc {
        var mean = 0.0
        var variance = 0.0
    }
    
    func performanceTestMomentStrucFunctional() -> Double {
        let intArray = Array(0 ..< arraySize)
        let myArray = intArray.map() {
            element in
            return Double(element)
        }
        var moments = MomentStruc()
        let startTime = NSDate()
        //        moments = myArray.reduce(Moments(), combine: +)
        moments = myArray.reduce(MomentStruc()) {
            moments, element in
            var returnMoment = MomentStruc()
            
            returnMoment.mean += element
            returnMoment.variance += element*element
            return returnMoment
        }
        let endTime = NSDate()
        return endTime.timeIntervalSinceDate(startTime)
    }
    
    func performanceTestMomentStrucIterative() -> Double {
        let intArray = Array(0 ..< arraySize)
        let myArray = intArray.map() {
            element in
            return Double(element)
        }
        var moments = MomentStruc()
        let startTime = NSDate()
        for element in myArray {
            moments.mean += element
            moments.variance += element*element
        }
        let endTime = NSDate()
        return endTime.timeIntervalSinceDate(startTime)
    }
    

}
