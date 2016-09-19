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
        // Create UIPicker instance
        let picker = UIImagePickerController()
        
        // Configure it
        if (UIImagePickerController.isCameraDeviceAvailable(.rear)) {
            picker.sourceType = .camera
        } else {
            // Gallery is enough
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = self
        
        // Show it modal way
        self.present(picker, animated: true) {
            // If you want to do something just when picker is shown
            
        }
    }
    
    @IBAction func deletePhoto(_ sender: AnyObject) {
        
        let oldBounds = self.photoView.bounds
        
        // Animación
        UIView.animate(withDuration: 0.9,
                       animations: {
                        self.photoView.alpha = 0
                        self.photoView.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
                        self.photoView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
                        
        }) { (finished: Bool) in
            // Dejar todo como estaba
            self.photoView.bounds = oldBounds
            self.photoView.transform = CGAffineTransform(rotationAngle: CGFloat(0))
            self.photoView.alpha = 1
            
            // Actualizamos
            self.model.photo?.image = nil
            self.syncModelView()
        }
    }
    
    @IBAction func addFilter(_ sender: AnyObject) {
        /*
        guard let image = photoView.image else {
            return
        }
        */
        
        // CIImage, Context, CIFilter
        
        // Imagen de entrada
        let img = CIImage(image: photoView.image)
        
        // Contexto: el que crea la imagen final
        let ctxt = CIContext(options: nil)
        
        // Filtro (usado por el contexto)
        let vintage = CIFilter(name: "CIFalseColor")
        vintage?.setDefaults()
        vintage?.setValue(img, forKey: "inputImage")
        
        // La imagen final
        let finalImg = vintage?.value(forKey: kCIOutputImageKey) as! CIImage
        
        // Aquí es donde se aplica el filtro y lo que consume tiempo
        let res = ctxt.createCGImage(finalImg, from: finalImg.extent)
        
        
        
        let result = UIImage(cgImage: res!)
        
        
        photoView.image = result
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


// MARK: - Delegates

extension PhotoViewController: UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {

    
    // Capture picked event (receives original and edited picker, and other metadata)
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Resize image to screen size
        
        // Save in model
        model.photo?.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        
        // Remove picker (remove modal controller)
        self.dismiss(animated: true) {
            // Nothing to do here
        }
        
        // If not dismiss, use presenting / presented - viewController
        // No needed here
    }
}
