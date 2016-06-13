//
//  TestGroupTableViewController.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class TestGroupTableViewController: UITableViewController {

    var testGroup: TestGroup
    
    init(testGroup: TestGroup) {
        self.testGroup = testGroup
        super.init(style: .Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
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
            return testGroup.testParameters.count
        } else {
            return testGroup.performanceTests.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return TestParameterCell.dequeueOnto(tableView, atIndexPath: indexPath, forTestParameter: &testGroup.testParameters[indexPath.row])
        } else {
            return TestCell.dequeueOnto(tableView, atIndexPath: indexPath, forTest: &testGroup.performanceTests[indexPath.row])
        }
    }

}
