//
//  DataBase.swift
//  RSS
//
//  Created by MacBook on 20.09.16.
//  Copyright © 2016 MacBook. All rights reserved.
//

import Foundation


class DataBase {
    
    var allRecords = [(date : String?, title : String?, description : String?)]()
    
    var managedObjectStore : RKManagedObjectStore!
    
    static let shared = DataBase()
    
    init () { }
    
    func setup () {
        
        guard let modelURL : NSURL = NSBundle.mainBundle().URLForResource("ModelNew", withExtension:"momd")
            else {
                fatalError("Error loading model from bundle")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        managedObjectStore = RKManagedObjectStore(managedObjectModel: managedObjectModel)
        
        let storePath : String = RKApplicationDataDirectory().stringByAppendingString("ModelNew.sqlite")
        
        do {
            try managedObjectStore.addSQLitePersistentStoreAtPath(storePath, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: nil)
        }
        catch {
            fatalError("Error migrating store")
        }
        managedObjectStore.createManagedObjectContexts()
        
        // Configure MagicalRecord to use RestKit's Core Data stack
        NSPersistentStoreCoordinator.MR_setDefaultStoreCoordinator(managedObjectStore.persistentStoreCoordinator)
        NSManagedObjectContext.MR_setRootSavingContext(managedObjectStore.persistentStoreManagedObjectContext)
        NSManagedObjectContext.MR_setDefaultContext(managedObjectStore.mainQueueManagedObjectContext)
        
        //нужно зарегистрировать MIMEType: "application/rss+xml"
        //https://github.com/RestKit/RKXMLReaderSerialization
        //========^^^^^^========//
        
    }
    
    func loadFromCoreData() {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E yyyy-MM-dd H:m:s"

        allRecords.removeAll()
        MyRecord.MR_truncateAll()
        
        MyRecord.MR_findAll()?.forEach({ (record) in
            
            var newRecord = (date : String?, title : String?, description : String?) (nil, nil, nil)
            newRecord.title = record.valueForKey("title") as? String
            newRecord.description = record.valueForKey("recordDescription") as? String
            
            if let date = record.valueForKey("date") as? NSDate {
                newRecord.date = formatter.stringFromDate(date)
            }
            
            allRecords.append(newRecord)
        })
        
        print(allRecords.count)
    }
    
    func loadNewRecords(callBack : (succes : Bool) -> Void) {
        
        //мэпинг нужно настроить для "http://news.tut.by/rss/all.rss"
        //========^^^^^^========//
        
        let recordMapping : RKEntityMapping = RKEntityMapping(forEntityForName: "MyRecord", inManagedObjectStore: managedObjectStore)
        
        recordMapping.addAttributeMappingsFromDictionary(["title" : "title"])

        let responseDescriptor : RKResponseDescriptor = RKResponseDescriptor(mapping: recordMapping, method: RKRequestMethod.GET, pathPattern: nil, keyPath: "item", statusCodes: nil)
        
        guard let url : NSURL = NSURL(string: "http://news.tut.by/rss/all.rss")
        else {
            fatalError("Nsurl didn't create")
        }
        let request : NSURLRequest = NSURLRequest(URL: url)
        
        let operation : RKManagedObjectRequestOperation = RKManagedObjectRequestOperation(request: request, responseDescriptors: [RKResponseDescriptor] (arrayLiteral: responseDescriptor))
        
        operation.managedObjectContext = managedObjectStore.mainQueueManagedObjectContext
        operation.managedObjectCache = managedObjectStore.managedObjectCache
        
        operation.setCompletionBlockWithSuccess({ (operation, result) in
                callBack(succes: true)
            }) { (operation, error) in
                
                // нужно сделать switch для ошибки
                //========^^^^^^========//
                callBack(succes: false)
        }
        operation.start()
    }
}
