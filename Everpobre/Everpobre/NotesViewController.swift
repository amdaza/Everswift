//
//  NotesViewController.swift
//  Everpobre
//
//  Created by Home on 13/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//

import UIKit

class NotesViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let fc = fetchedResultsController else {
            return
        }
        
        let note = fc.fetchedObjects?.first as? Note
        title = note?.notebook?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "NoteCell"
        
        let note = fetchedResultsController?.object(at: indexPath) as! Note
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: cellId)
        }
        
        cell?.imageView?.image = note.photo?.image
        cell?.textLabel?.text = note.text
        
        return cell!
    }
}
