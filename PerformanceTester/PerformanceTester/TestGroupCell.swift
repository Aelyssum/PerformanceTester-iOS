//
//  TestGroupCell.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class TestGroupCell: UITableViewCell {

    static var nibName = "TestGroupCell"
    static var idReuse = "cellTestGroup"
    static var height: CGFloat = 80.0
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UITextView!
    
    class func register(tableView: UITableView) {
        tableView.registerNib(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: idReuse)
    }
    
    class func dequeueOnto(tableView: UITableView, atIndexPath: NSIndexPath, forTestGroup: TestGroup) -> TestGroupCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(idReuse, forIndexPath: atIndexPath) as! TestGroupCell
        cell.lblTitle.text! = forTestGroup.title
        cell.lblDescription.text! = forTestGroup.description
        return cell
    }    

}
