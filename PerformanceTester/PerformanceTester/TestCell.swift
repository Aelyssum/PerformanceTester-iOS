//
//  TestCell.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class TestCell: UITableViewCell {

    static var nibName = "TestCell"
    static var idReuse = "cellTest"
    
    static var decimalFormatter = NSNumberFormatter()
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblResult: UILabel!
    @IBOutlet var lblUnits: UILabel!
    @IBOutlet var lblStatus: UILabel!
    

    class func register(tableView: UITableView) {
        tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: idReuse)
        TestCell.decimalFormatter.usesSignificantDigits = true
        TestCell.decimalFormatter.minimumSignificantDigits = 3
        TestCell.decimalFormatter.maximumSignificantDigits = 5
    }
    
    class func dequeueOnto(tableView: UITableView, atIndexPath: NSIndexPath) -> TestCell {
        return tableView.dequeueReusableCellWithIdentifier(idReuse, forIndexPath: atIndexPath) as! TestCell
    }
    
    func config(test: TestGroup.PerformanceTest) {
        lblTitle.text! = test.title
        if test.status == .Completed {
            lblResult.text = TestCell.decimalFormatter.stringFromNumber(test.result)
            lblUnits.text! = "s"
        } else {
            lblResult.text! = ""
            lblUnits.text! = ""
        }
        lblStatus.text! = test.status.rawValue
    }
    
}
