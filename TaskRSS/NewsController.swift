//
//  NewsController.swift
//  TaskRSS
//
//  Created by MacBook on 17.09.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit

class NewsController: UITableViewController {
    
    @IBOutlet weak var refreshingControl: UIRefreshControl!
    
    var arrayOfNews = [New]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 10
        
        refreshingControl.addTarget(self, action: #selector(NewsController.loadNews), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func loadNews() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

