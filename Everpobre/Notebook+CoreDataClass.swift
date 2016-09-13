//
//  Notebook+CoreDataClass.swift
//  Everpobre
//
//  Created by Home on 8/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc
public class Notebook: NSManagedObject {
    
    static let entityName = "Notebook"
    
    convenience init(name: String, inContext context: NSManagedObjectContext) {
        
        // We need Notebook entity
        let entity = NSEntityDescription.entity(forEntityName: Notebook.entityName,
                                                in: context)!
        
        // Super call
        self.init(entity: entity, insertInto: context)
    
        // Assign date values
        creationDate = NSDate()
        modificationDate = NSDate()
        self.name = name
    }
}

//MARK: - KVO
extension Notebook {
    @nonobjc static let observableKeys = ["name", "notes"]
    
    func setupKVO(){
        // Subscribe notifications to some properties
        for key in Notebook.observableKeys {
        self.addObserver(self, forKeyPath: key, options: [],
                         context: nil)
        }
    }
    
    func teardownKVO(){
        // Unsubscribe
        for key in Notebook.observableKeys {
            self.removeObserver(self, forKeyPath: key)
        }
    }
    
    public override func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey : Any]?,
                                      context: UnsafeMutableRawPointer?) {
        modificationDate = NSDate()
    }
}

//MARK: - Lifecycle
extension Notebook {
    
    // Called only once
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setupKVO()
    }
    
    // Called many times
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        
        setupKVO()
    }
    
    public override func willTurnIntoFault() {
        super.willTurnIntoFault()
        
        teardownKVO()
    }
    
    
}



