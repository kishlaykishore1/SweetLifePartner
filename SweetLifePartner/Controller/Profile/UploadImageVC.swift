//
//  UploadImageVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 11/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class UploadImageVC: BaseImagePicker {

    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var txtTitleInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async {
                self.setNavigationbarThemeGradientColor()
            }
                    navigationController?.navigationBar.isHidden = false
           let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
                    self.navigationItem.leftBarButtonItem = backButton;
           self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    super.viewWillAppear(animated);
                    title = "Upload Your Image"
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnSelectPhotoPressed(_ sender: UIButton) {
        openOptions()
      
    }
    
    @IBAction func btnUploadPressed(_ sender: UIButton) {
         requestService()
    }
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chooseImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!
        selectedImage.contentMode = .scaleAspectFit
        selectedImage.image = chooseImage
        dismiss(animated: true, completion: nil)
    }
}

//MARK:- API CALLING For Uploading Gallery
extension UploadImageVC {

func requestService()  {
     guard let id = MemberModel.getMemberModel()?.memberID else {
                return
            }
    let param: [String: Any] = ["member_id": id ,"title": txtTitleInput.text?.trim() ?? "" ]
    
    API.ADDGALLERY.requestUpload( with: param, files: ["image": selectedImage.image ?? ""]) { (jsonObject, error) in
        guard error == nil, (jsonObject?["status"] as! Bool ) else {
            Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
            return
        }
        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
        self.navigationController?.popViewController(animated: true)
    }
 }
}
