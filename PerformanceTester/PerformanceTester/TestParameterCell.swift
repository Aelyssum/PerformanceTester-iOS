//
//  TestParameterCell.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

protocol TestParameterDelegate {
    func testParameterDidUpdate(sender: TestParameterCell, label: String)
}

class TestParameterCell: UITableViewCell, UITextFieldDelegate {

    static var idReuse = "cellTestParameter"
    static var nibName = "TestParameterCell"
    static var delegate: TestParameterDelegate?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var txtParameter: UITextField!
    
    var intParameter: Int!
    var dblParameter: Double!
    
    class func register(tableView: UITableView) {
        tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: idReuse)
    }
    
    class func dequeueOnto(tableView: UITableView, atIndexPath: NSIndexPath) -> TestParameterCell {
        return tableView.dequeueReusableCellWithIdentifier(idReuse, forIndexPath: atIndexPath) as! TestParameterCell
    }
    
    func config<T>(label: String, parameter: T) {
        self.label.text! = label
        self.txtParameter.text! = String(parameter)
        self.txtParameter.delegate = self
        if let _ = parameter as? Int {
            self.txtParameter.keyboardType = UIKeyboardType.NumberPad
        } else {
            self.txtParameter.keyboardType = UIKeyboardType.DecimalPad
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == txtParameter {
            if let intParam = Int(txtParameter.text!) {
                intParameter = intParam
                TestParameterCell.delegate?.testParameterDidUpdate(self, label: label.text!)
            }
        }
    }
    
}
