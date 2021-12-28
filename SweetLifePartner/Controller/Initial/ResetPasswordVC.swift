//
//  ResetPasswordVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 18/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewpassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          txtOldPassword.setPadding(left: 5.0)
          txtNewpassword.setPadding(left: 5.0)
          txtConfirmPassword.setPadding(left: 5.0)
        
    }
    override func viewWillAppear(_ animated: Bool) {
               DispatchQueue.main.async {
                   self.setNavigationbarThemeGradientColor()
               }
                navigationController?.navigationBar.isHidden = false
                setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
                title = "Change Password"
       }
    //MARK: Back Button Action
       override func backBtnTapAction() {
             self.navigationController?.popViewController(animated: true)
       }
  //MARK:-
    @IBAction func btn_box(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func did_tapResetPassword(_ sender: Any) {
        
        guard txtOldPassword.text?.trimmingCharacters(in: .whitespaces) != "" else {
            //self.showToast(message: "Please enter old password")
            return
        }
        guard txtNewpassword.text?.trimmingCharacters(in: .whitespaces) != "" else {
            //self.showToast(message: "Please enter new password")
            return
        }
        
        guard txtConfirmPassword.text?.trimmingCharacters(in: .whitespaces) != "" else {
           // self.showToast(message: "Please enter confirm password")
            return
        }
        
        apiResetPassword()
    }
    
}
extension ResetPasswordVC {
    func apiResetPassword() {
          guard let id = MemberModel.getMemberModel()?.memberID else {
              return
          }
           let param: [String : Any] = ["member_id":id,"current_password": txtOldPassword.text!.trim(),"new_password": txtNewpassword.text!.trim(),"confirm_password": txtConfirmPassword.text!.trim()]
           if let getRequest = API.RESETPASSWORD.request(method: .post, with: param, forJsonEncoding: true) {
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
                   Global.dismissLoadingSpinner()
                   API.RESETPASSWORD.validatedResponse(response, completionHandler: { (jsonObject, error) in
                       guard error == nil else {
                           return
                       }
                       Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                       self.navigationController?.popViewController(animated: true)
                   })
                   
               }
           }
       }
}
