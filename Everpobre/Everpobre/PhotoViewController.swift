//
//  PhotoViewController.swift
//  Everpobre
//
//  Created by Home on 19/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // Model has to be the note (maybe we use image title in note)
    let model : Note

    @IBOutlet weak var photoView: UIImageView!
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        
    }
    
    @IBAction func deletePhoto(_ sender: AnyObject) {
        
    }
    
    init(model: Note) {
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .all
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        syncViewModel()
    }
    
    func syncModelView(){
        title = model.text
        photoView.image = model.photo?.image
    }
    
    func syncViewModel(){
        model.photo?.image = photoView.image
    }

    // Managed by CoreData, transforming data into Fault
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 */


}
