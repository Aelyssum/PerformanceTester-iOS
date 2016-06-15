//
//  MainTableViewController.swift
//  PerformanceTester
//
//  Created by Allan Evans on 6/12/16.
//  Copyright © 2016 Aelyssum Corp. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var testGroups: [TestGroup] = [
        FunctionalVsIterativeTestGroup()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TestGroupCell.register(tableView)
        self.navigationItem.title = "Performance Tester"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        NSLog("Count = \(testGroups.count)")
        return testGroups.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return TestGroupCell.height
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return TestGroupCell.dequeueOnto(tableView, atIndexPath: indexPath, forTestGroup: testGroups[indexPath.row])
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vcTestGroup = TestGroupTableViewController(testGroup: testGroups[indexPath.row])
        self.navigationController?.pushViewController(vcTestGroup, animated: true)
    }


}
