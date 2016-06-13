//
//  TestGroupCell.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class TestGroupCell: UITableViewCell {

    static var idReuse = "TestGroupCell"
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UITextView!
    
    class func dequeueOnto(tableView: UITableView, atIndexPath: NSIndexPath, forTestGroup: TestGroup) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(idReuse, forIndexPath: atIndexPath) as! TestGroupCell
        cell.lblTitle.text! = forTestGroup.title
        cell.lblDescription.text! = forTestGroup.description
        return cell
    }    

}
