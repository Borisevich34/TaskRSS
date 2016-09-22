//
//  MyRecord+CoreDataProperties.swift
//  RSS
//
//  Created by MacBook on 20.09.16.
//  Copyright © 2016 MacBook. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MyRecord {

    //нужны будут еще поля
    @NSManaged var date: NSDate?
    @NSManaged var title: String?
    @NSManaged var recordDescription: String?

}
