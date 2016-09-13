//
//  NotebooksViewController.swift
//  Everpobre
//
//  Created by Home on 12/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//

import UIKit
import CoreData

class NotebooksViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addNewNotebookButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

// MARK: - DataSource

extension NotebooksViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "NotebookCell"
        
        // Get notebook
        let nb = fetchedResultsController?.object(at: indexPath) as! Notebook
        
        // Create cell
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Configurate cell
        cell?.textLabel?.text = nb.name ?? "New Notebook"
        
        // ?? -> New unpack way. If nil, use right as default
        
        let fmt = DateFormatter()
        fmt.dateStyle = .medium
        
        cell?.detailTextLabel?.text = fmt.string(from: nb.modificationDate as! Date)
        
        // Return cell
        return cell!
    
    }
    
    // MARK: - Utils
    
    func addNewNotebookButton() {
    
        let btn = UIBarButtonItem(barButtonSystemItem: .add,
                                  target: self,
                                  action: #selector(addNewNotebook))
        
        navigationItem.rightBarButtonItem = btn
    }
    
    // MARK: - Actions
    func addNewNotebook() {
        
        guard let fc = fetchedResultsController else {
            return
        }
        // Create new notebook
        let _ = Notebook(name: "Nueva Libreta",
                         inContext: fc.managedObjectContext)
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nb = fetchedResultsController?.object(at: indexPath) as! Notebook
        
        let req = NSFetchRequest<Note>(entityName: Note.entityName)
        req.fetchBatchSize = 50
        req.predicate = NSPredicate(format: "notebook == %@", nb)
        req.sortDescriptors = [NSSortDescriptor(key: "modificationDate",
                                                ascending: false)]
        
        let fc = NSFetchedResultsController(fetchRequest: req,
                                            managedObjectContext: nb.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        let notesVC = NotesViewController(fetchedResultsController: fc as! NSFetchedResultsController<NSFetchRequestResult>)
        
        navigationController?.pushViewController(notesVC, animated: true)
    }
}




