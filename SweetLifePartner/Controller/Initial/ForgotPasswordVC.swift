//
//  ForgotPasswordVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 18/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UnderLineImageTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: .black, isImage: true)
        setNavigationBarImage(for: UIImage(), color: .white)
        title = "Forgot Password"
        
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func did_tapSend(_ sender: Any) {
        if Validation.isBlank(for: txtEmail.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyEmail, alertType: .error)
            return
        } else if !Validation.isValidEmail(for: txtEmail.text ?? "") {
            Common.showAlertMessage(message: Messages.invalidEmail, alertType: .error)
            return
        }
        
        apiForgotPassword()
    }
}
//MARK:- Forget Password Api Function
extension ForgotPasswordVC {
    func apiForgotPassword() {
        let param: [String : Any] = ["email": txtEmail.text!.trim()]
        if let getRequest = API.FORGOTPASS.request(method: .post, with: param, forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.FORGOTPASS.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
