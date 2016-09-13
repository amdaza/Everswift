//
//  Photo+CoreDataClass.swift
//  Everpobre
//
//  Created by Home on 8/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc
public class Photo: NSManagedObject {
    
    static let entityName = "Photo"
    
    var image : UIImage? {
        get {
            guard let data = photoData else {
                return nil
            }
            return UIImage(data: data as Data)!
        }
        
        set {
            guard let img = newValue else {
                photoData = nil
                return
            }
            photoData = UIImageJPEGRepresentation(img, 0.9) as NSData?
        }
    }
    
    convenience init(note: Note,
         image: UIImage,
         inContext context: NSManagedObjectContext) {
        
        let ent = NSEntityDescription.entity(forEntityName: Photo.entityName,
                                             in: context)!
        
        self.init(entity: ent, insertInto: context)
        
        // Add note
        addToNotes(note)
        
        // Transform UIImage into data and set it
        self.image = image
        
    }
    
    convenience init(note: Note, inContext context: NSManagedObjectContext) {
        let ent = NSEntityDescription.entity(forEntityName: Photo.entityName, in: context)!
        
        self.init(entity: ent, insertInto: context)
        addToNotes(note)
    }
}
