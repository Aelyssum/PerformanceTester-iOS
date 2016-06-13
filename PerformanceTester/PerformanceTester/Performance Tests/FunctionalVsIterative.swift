//
//  FunctionalVsIterative.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import Foundation

class FunctionalVsIterative: TestGroup {
    
    
    var arraySize: Double = 100000

    init() {
        super.init(
            title: "Functional vs. Iterative Array Methods",
            description: ""
        )
        testParameters.append(TestParameter(label: "Array Size", parameter: arraySize))
        performanceTests.append(PerformanceTest(
            title: "Sum, Functional",
            result: <#T##Double#>,
            performanceTest: {
                self.performanceTestSumFunctional()
            }
        ))
        performanceTests.append(PerformanceTest(
            title: "Sum, Itrative",
            result: <#T##Double#>,
            performanceTest: {
                self.performanceTestSumFunctional()
            }
            ))
    }
    
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
    
}
