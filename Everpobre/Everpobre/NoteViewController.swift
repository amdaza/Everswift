//
//  NoteViewController.swift
//  Everpobre
//
//  Created by Home on 13/9/16.
//  Copyright © 2016 Alicia. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    // Optional to use it with storyboard
    var model : Note

    @IBOutlet weak var textView: UITextView!
    
    @IBAction func displayPhoto(_ sender: AnyObject) {
        
        //let pVC = PhotoViewController(model: model)
        
    }
    
    // No need to be convenience, except if it uses storyboard
    init(model: Note) {
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        syncViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func syncModelView(){
        textView.text = model.text
    }
    
    func syncViewModel(){
        model.text = textView.text
    }

}
