//
//  PicturePrivacyVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 10/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PicturePrivacyVC: UIViewController {

    var privacyOptions = ["Only Me","All Member","Premium Member"]
    var pickerView : UIPickerView?
    var getPicturePrivacyData: PicturePrivacyModel?
    
    @IBOutlet weak var tfProfilePic: UITextField!
    @IBOutlet weak var tfGalleryImages: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        apiPicturePrivacy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
               DispatchQueue.main.async {
                   self.setNavigationbarThemeGradientColor()
               }
                navigationController?.navigationBar.isHidden = false
                setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
                title = "Picture Privacy Settings"
       }
    //MARK: Back Button Action
       override func backBtnTapAction() {
             self.navigationController?.popViewController(animated: true)
       }
    
//MARK:- UIPickerView Delegates assigning
       func PickerViewConnection() {
           let pickerView = UIPickerView()
           pickerView.delegate = self
           pickerView.dataSource = self
           
           tfProfilePic.delegate = self
           tfGalleryImages.delegate = self
              
           tfProfilePic.inputView = pickerView
           tfGalleryImages.inputView = pickerView
          
           
           self.pickerView = pickerView
       }

 //MARK:-Save Button Action
    @IBAction func btnSavePressed(_ sender: UIButton) {
        apiPicturePrivacyUpdate()
    }
}

//MARK:-UITextField delegates Methods
extension PicturePrivacyVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension PicturePrivacyVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfProfilePic.isFirstResponder {
            return privacyOptions.count
        } else if tfGalleryImages.isFirstResponder {
            return privacyOptions.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if tfProfilePic.isFirstResponder {
            return privacyOptions[row]
        } else if tfGalleryImages.isFirstResponder {
            return privacyOptions[row]
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension PicturePrivacyVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tfProfilePic.isFirstResponder{
            let itemselected = privacyOptions[row]
            tfProfilePic.text = itemselected
            
        } else if tfGalleryImages.isFirstResponder {
            let stauts = privacyOptions[row]
            tfGalleryImages.text = stauts
        }
    }
}

//MARK:-API CALLING
extension PicturePrivacyVC {
//MARK:- api calling For Picture Privacy
        func apiPicturePrivacy() {
                 guard let id = MemberModel.getMemberModel()?.memberID else {
                     return
                 }
                 if let getRequest = API.PICTUREPRIVACY.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
                     Global.showLoadingSpinner()
                     getRequest.responseJSON { response in
                     Global.dismissLoadingSpinner()
                         API.PICTUREPRIVACY.validatedResponse(response, completionHandler: {(jsonObject, error) in
                             guard error == nil else {
                                 return
                             }
                             
                             guard jsonObject?["status"] as? Int == 1 else {
                             Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                               return
                             }
                             
                             guard let getData = jsonObject?["data"] as? [String: Any] else {
                                 Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                                 return
                             }
                             
                             do{
                                 let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
                                 let decoder = JSONDecoder()
                                self.getPicturePrivacyData = try decoder.decode(PicturePrivacyModel.self, from: jsonData)
                                 print(self.getPicturePrivacyData ?? "")
                                self.setPicturePrivacyData()
                              }  catch let err {
                                    print("Err", err)
                                }
                             
                         })
                     }
                     
                 }
             }
          
          func setPicturePrivacyData() {
            tfProfilePic.text = getPicturePrivacyData?.profilePicShow
            tfGalleryImages.text = getPicturePrivacyData?.galleryShow
          }
//MARK:- calling Update Api for Residency Info
        func apiPicturePrivacyUpdate() {
              guard let id = MemberModel.getMemberModel()?.memberID else {
                  return
              }
            let  param:[String:Any] = ["member_id":id, "profile_pic_show":tfProfilePic.text?.trim() ?? "", "gallery_show":tfGalleryImages.text?.trim() ?? ""]
            
              if let getRequest = API.UPDATEPICTUREPRIVACY.request(method: .post, with: param, forJsonEncoding: true){
                  Global.showLoadingSpinner()
                  getRequest.responseJSON { response in
                      Global.dismissLoadingSpinner()
                      API.UPDATEPICTUREPRIVACY.validatedResponse(response, completionHandler: { (jsonObject, error) in
                          guard  error == nil else {
                              return
                          }
                          guard jsonObject?["status"] as? Int == 1 else {
                              Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                              return
                          }
                          Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                          self.navigationController?.popViewController(animated: true)
                      })
                  }
              }
          }
    }

