//
//  CreateProfileVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 19/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class CreateProfileVC: BaseImagePicker {
    
    @IBOutlet weak var imgView: UIImageView!
    var memberId: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        setBackButton(tintColor: .black, isImage: true)
        setNavigationBarImage(for: UIImage(), color: .white)
        title = "Profile Photo"
        
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func did_AddGallaryTapped(_ sender: Any) {
        openOptions()
    }
    
    override func selectedImage(chooseImage: UIImage) {
        imgView.image = chooseImage
        Global.showLoadingSpinner()
        apiUpdateProfilePic()
    }
    
}
extension CreateProfileVC {
    func apiUpdateProfilePic() {
        let param: [String : Any] = ["member_id": memberId!]
        API.UPDATEPHOTO.requestUpload(with: param, files: ["profile_image": self.imgView.image ?? ""]) { (response, error) in
            Global.dismissLoadingSpinner()
            guard error == nil else {
                return
            }
            Common.showAlertMessage(message: response?["message"] as? String ?? "", alertType: .success )
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
