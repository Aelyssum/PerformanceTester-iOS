//
//  TestParameterCell.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class TestParameterCell: UITableViewCell, UITextFieldDelegate {

    static var idReuse = "TestParameterCell"
    
    @IBOutlet var label: UILabel!
    @IBOutlet var txtParameter: UITextField!
    var testParameter: TestGroup.TestParameter!
    
    class func dequeueOnto(tableView: UITableView, atIndexPath: NSIndexPath, inout forTestParameter: TestGroup.TestParameter) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(idReuse, forIndexPath: atIndexPath) as! TestParameterCell
        cell.testParameter = forTestParameter
        cell.label.text! = forTestParameter.label
        cell.txtParameter.text! = String(forTestParameter.parameter)
        cell.txtParameter.delegate = cell
        return cell
    }

    func textFieldDidEndEditing(textField: UITextField) {
        if textField == txtParameter {
            if let doubleVal = Double(txtParameter.text!) {
                testParameter.parameter = doubleVal
            }
        }
    }
    
}
