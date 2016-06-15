//
//  FunctionalVsIterativeTestGroup.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/14/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import Foundation

class FunctionalVsIterativeTestGroup: TestGroup {
    
    var arraySize = 1000000
    var multipler = 1.0
    
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
        return 2
    }
    
    override func configTestParameter(cell: TestParameterCell, forIndex: Int) {
        if forIndex == 0 {
            cell.config("Array Size", parameter: arraySize)
        } else {
            cell.config("Multiplier", parameter: multipler)
        }
    }
    
    // MARK: - TestParameterDelegate method
    
    override func testParameterDidUpdate<T>(parameter: T, label: String) {
        NSLog("testParameterDidUpdate: \(label)")
        if label == "Array Size" {
            arraySize = parameter as! Int
        } else {
            multipler = parameter as! Double
        }
    }
    
    // MARK: - Test Setup
    
    var myArray = [Double]()
    var sum = 0.0
    var moments = Moments()
    var momentsStruc = MomentStruc()

    
    override func setup(performanceTest: PerformanceTest) {
        let intArray = Array(0 ..< Int(arraySize))
        myArray = intArray.map() {
            element in
            return Double(element)
        }
        sum = 0.0
        moments = Moments()
        momentsStruc = MomentStruc()
    }
    
    // MARK: - Performance Tests
    
    func performanceTestSumFunctional() {
        sum = myArray.reduce(0.0) {
            sum, element in
            
            return sum + element
        }
    }
    
    func performanceTestSumIterative() {
        for element in myArray {
            sum += element
        }
    }
    
    class Moments {
        var mean = 0.0
        var variance = 0.0
    }
    
    func performanceTestMomentsFunctional() {
        moments = myArray.reduce(Moments()) {
            moments, element in
            moments.mean += element
            moments.variance += element*element
            return moments
        }
    }
    
    func performanceTestMomentsIterative() {
        for element in myArray {
            moments.mean += element
            moments.variance += element*element
        }
    }
    
    struct MomentStruc {
        var mean = 0.0
        var variance = 0.0
    }
    
    func performanceTestMomentStrucFunctional() {
        momentsStruc = myArray.reduce(MomentStruc()) {
            moments, element in
            var returnMoment = MomentStruc()
            
            returnMoment.mean += element
            returnMoment.variance += element*element
            return returnMoment
        }
    }
    
    func performanceTestMomentStrucIterative() {
        for element in myArray {
            momentsStruc.mean += element
            momentsStruc.variance += element*element
        }
    }
    

}
