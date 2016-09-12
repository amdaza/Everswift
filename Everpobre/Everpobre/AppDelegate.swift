//
//  AppDelegate.swift
//  Everpobre
//
//  Created by Home on 6/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let model = CoreDataStack(modelName: "Model")!
    
    func loadDummyData() {
        // Reset
        do {
            try model.dropAllData()
        } catch {
            print("Error trying to delete")
        }
        
        // A couple of notes
        let pelis = Notebook(name: "Pelis de los 80",
                             inContext: model.context)
        let wwdc = Notebook(name: "Sesiones WWDC",
                            inContext: model.context)
        
        // Notes
        let axel = Note(notebook: pelis,
                        inContext: model.context)
        axel.text = "Beverly Hill's Cop"
        
        let strike = Note(notebook: pelis,
                        inContext: model.context)
        strike.text = "The Empire Strikes Back"
        
        let async = Note(notebook: wwdc,
                         inContext: model.context)
        async.text = "Asynchronous Design Patterns"
        
        // Save
        model.save()
    }
    
    func playWithData(){
    
        // Notebook
        let nb = Notebook(name: "Watchlist", inContext: model.context)
        let wwdc = Notebook(name: "Sesiones WWDC", inContext: model.context)
        
        // Notes
        let img = UIImage(imageLiteralResourceName: "Trollface.jpg")
        
        let trollface = Note(notebook: nb, image: img, inContext: model.context)
        
        trollface.text = "Troll Face"
        
        let expanse = Note(notebook: nb, inContext: model.context)
        expanse.text = "Serie ne SyFy"
        
        let r1 = Note(notebook: nb, inContext: model.context)
        r1.text = "Rogue 1: A Starways Story"
        
        // SEarch
        //let notebooks = Notebook.fetchRequest()
    
        let req = NSFetchRequest<Notebook>(entityName: Notebook.entityName)
        
        req.fetchBatchSize = 50
        
        let notebooks = try! model.context.execute(req)
        
        print(type(of: notebooks))
        print(notebooks)
        
        // Filter
        let req2 = NSFetchRequest<Note>(entityName: Note.entityName)
        
            // Order
        req2.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                ascending: false)]
        
        req2.predicate = NSPredicate(format: "notebook == %@", nb)
        let movies = try! model.context.execute(req2)
        
        // Delete objects
        model.context.delete(trollface)
        
        print(movies)
        
        // Save
        model.save()
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //playWithData()
        
        // Create data stuff
        loadDummyData()
        
        // Create fetchRequest
        let fr = NSFetchRequest<Notebook>(entityName: Notebook.entityName)
        fr.fetchBatchSize = 50 // de 50 en 50
        
        fr.sortDescriptors = [NSSortDescriptor(key: "name",
                                               ascending: false),
                              NSSortDescriptor(key: "modificationDate",
                                               ascending: true)]
        
        // Create fetchedResultsCtrl
        let fc = NSFetchedResultsController(fetchRequest: fr,
                                            managedObjectContext: model.context,
                                            sectionNameKeyPath: nil,
                                            cacheName: nil)
        
        // Create rootVC
        let nVC = NotebooksViewController(fetchedResultsController: fc as! NSFetchedResultsController<NSFetchRequestResult>,
                                          style: .plain)
        
        let navVC = UINavigationController(rootViewController: nVC)
        
        // Create window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Put rootVC into window and show it
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

