//
//  LoginVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 18/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UnderLineImageTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        
         navigationController?.navigationBar.isHidden = false
         setBackButton(tintColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , isImage: true)
         let logo = UIImage(named: "logo-white.png")
         let imageView = UIImageView(image:logo)
         self.navigationItem.titleView = imageView
//       title = "Login"
        
    }
    override func backBtnTapAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func did_tapLogin(_ sender: Any) {
        
        if Validation.isBlank(for: txtUserName.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyUsername, alertType: .error)
            return
        } else if Validation.isBlank(for: txtPassword.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyPassword, alertType: .error)
            return
        }
        
        apiUserLogin()
    }
    
    @IBAction func did_tapForgot(_ sender: Any) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: API Calling
extension LoginVC {
    func apiUserLogin() {
        let param: [String : Any] = ["email": txtUserName.text!.trim(), "password": txtPassword.text!.trim(), "device_type": "ios", "device_token": "token"]
        if let getRequest = API.USERLOGIN.request(method: .post, with: param, forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.USERLOGIN.validatedResponse(response, completionHandler: { (jsonObject, error) in
                    guard error == nil else {
                        return
                    }
                    guard let getData = jsonObject?["data"] as? [String: Any] else {
                        return
                    }
                    guard (getData["login_state"] as? Bool ?? false), let member = getData["member"] as? [String: Any] else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                    Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                    MemberModel.storeMemberModel(value: member)
                    Constants.kAppDelegate.isUserLogin(true)
                })
                
            }
        }
    }
}
