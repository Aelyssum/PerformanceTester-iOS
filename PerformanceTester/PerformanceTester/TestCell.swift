//
//  TestCell.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {

    static var idReuse = "TestCell"
    
    @IBOutlet var txtTitle: UILabel!
    @IBOutlet var txtResult: UILabel!
    
    var performanceTest: TestGroup.PerformanceTest!

    class func dequeueOnto(tableView: UITableView, atIndexPath: NSIndexPath, inout forTest: TestGroup.PerformanceTest) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(idReuse, forIndexPath: atIndexPath) as! TestCell
        cell.performanceTest = forTest
        cell.txtTitle.text! = forTest.title
        cell.txtResult.text! = String(forTest.result)
        return cell
    }
    
}
