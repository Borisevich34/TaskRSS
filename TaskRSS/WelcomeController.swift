//
//  ViewController.swift
//  TaskRSS
//
//  Created by MacBook on 17.09.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //createing
        let createdNew = New.MR_createEntity()
        
        createdNew?.title = "Появляется ошибка"
        createdNew?.newDescription = "После загрузки из БД"
        createdNew?.date = NSDate()
        
        //saving
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
        //loading
        if let element = New.MR_findFirst() {
            print(element.newDescription)   //ошибка появляется через какое-то время, если поставить ! то появится сразу
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

