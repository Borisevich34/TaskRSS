//
//  NewsController.swift
//  RSS
//
//  Created by MacBook on 20.09.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import Foundation

class NewsController: UITableViewController {
    
    var records = [(date : String?, title : String?, description : String?)]()
    
    @IBOutlet weak var refreshingControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10
        
        records = DataBase.shared.allRecords
        if records.isEmpty {
            let alertController = UIAlertController(title: "Empty", message: "Pull down the table", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        refreshingControl.addTarget(self, action: #selector(NewsController.loadNews), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    func loadNews() {
        
        //пока не готово
        //DataBase.shared.loadNewRecords(callBack)
        refreshingControl.endRefreshing()
        //========^^^^^^========//
        
    }
    
    func callBack (success : Bool) {
        if success {
            DataBase.shared.loadFromCoreData()
            records = DataBase.shared.allRecords
            refreshingControl.endRefreshing()
            self.tableView.reloadData()
        }
        else {
            let alertController = UIAlertController(title: "Sorry", message: "Check your internet connection", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
            refreshingControl.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCellWithIdentifier("New") as? NewCell {
            
            cell.cellTitle.text = records[indexPath.row].title
            cell.cellDate.text = records[indexPath.row].date
   
            return cell
        }
        else {
            return UITableViewCell()
        }

    }
    
}