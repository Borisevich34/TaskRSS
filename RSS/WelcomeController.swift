//
//  ViewController.swift
//  RSS
//
//  Created by MacBook on 19.09.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var refreshingControl: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshingControl.startAnimating()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {

            //слишком быстро выполняется :)
            DataBase.shared.loadFromCoreData()
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.refreshingControl.stopAnimating()
                self.performSegueWithIdentifier("Next", sender: self)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

