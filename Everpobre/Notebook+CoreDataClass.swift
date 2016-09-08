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

@objc(Notebook)
public class Notebook: NSManagedObject {
    init(name: String, inContext context: NSManagedObjectContext) {
        
        /*static*/ let entityName = "Notebook"
        
        // We need Notebook entity
        let entity = NSEntityDescription.entity(forEntityName: entityName,
                                                in: context)!
        
        // Super call
        super.init(entity: entity, insertInto: context)
    
        // Assign date values
        creationDate = NSDate()
        modificationDate = NSDate()
    }
}
