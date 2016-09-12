//
//  NotebooksViewController.swift
//  Everpobre
//
//  Created by Home on 12/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//

import UIKit

class NotebooksViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}
