//
//  Note+CoreDataClass.swift
//  Everpobre
//
//  Created by Home on 8/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {
    
    static let entityName = "Note"
    
    init(notebook: Notebook,
         image: UIImage,
         inContext context: NSManagedObjectContext){
    
        // Get entity description
        let ent = NSEntityDescription.entity(forEntityName: Note.entityName,
                                            in: context)!
    
        // Call super
        super.init(entity: ent, insertInto: context)
    
        // Assign properties
        self.notebook = notebook
        creationDate = NSDate()
        modificationDate = NSDate()
        
        // Create photo
        photo = Photo(note: self,
                      image: image,
                      inContext: context)
    }
    
    
    init(notebook: Notebook,
                     inContext context : NSManagedObjectContext) {
        let ent = NSEntityDescription.entity(forEntityName: Note.entityName,
                                             in: context)!
        
        super.init(entity: ent, insertInto: context)
        
        self.notebook = notebook
        creationDate = NSDate()
        modificationDate = NSDate()
        
        // Save empty photo
        photo = Photo(note: self, inContext: context)
    }
}



//MARK: - KVO
extension Note {
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
        for key in Note.observableKeys {
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
extension Note {
    
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

