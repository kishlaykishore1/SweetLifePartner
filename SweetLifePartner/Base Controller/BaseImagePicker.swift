//
//  BaseImagePicker.swift
//  SweetLifePartner
//
//  Created by angrej singh on 19/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class BaseImagePicker: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imagePicker.delegate = self
        
    }
    
    func openOptions() {
        
        let alert = UIAlertController(title: "Choose Image", message: "Pick Image From : ", preferredStyle: .actionSheet)
        let gallaryAction = UIAlertAction(title: "Gallery", style: .default) { (btn) in
            self.imagePicker.sourceType = .photoLibrary
            self.openPicker()
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (btn) in
            
            self.imagePicker.sourceType = .camera
            self.openPicker()
        
    }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(gallaryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
   }
    
    
    func selectedImage(chooseImage:UIImage) {
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chooseImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        selectedImage(chooseImage: chooseImage)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func openPicker()  {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}
