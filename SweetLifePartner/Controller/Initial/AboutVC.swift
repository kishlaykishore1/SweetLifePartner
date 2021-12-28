//
//  AboutVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 19/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class AboutVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var AboutTextView: UITextView!
    @IBOutlet weak var lblCounter: UILabel!
    
    var NumberofCharacter = Int()
    var memberId: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AboutTextView.delegate = self
        updateCharacterCount()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        setBackButton(tintColor: .black, isImage: true)
        setNavigationBarImage(for: UIImage(), color: .white)
        title = "About"
        
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateCharacterCount() {
        
        let summaryCount = self.AboutTextView.text!.count
        NumberofCharacter = summaryCount
        lblCounter.text = "Character Count \((0) + summaryCount)"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if(textView == AboutTextView){
            return textView.text.count +  (text.count - range.length) <= 500
        }
        return false
    }
    
    
    
    @IBAction func did_tapCreateProfile(_ sender: Any) {
        if NumberofCharacter <= 50 {
            Common.showAlertMessage(message: Messages.aboutUs, alertType: .warning)
        } else {
            apiUpdateAbout()
            
        }
    }
    
}

extension AboutVC {
    func apiUpdateAbout() {
        let param: [String : Any] = ["member_id": memberId!, "introduction": AboutTextView.text!.trim()]
        if let getRequest = API.UPDATEABOUT.request(method: .post, with: param, forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.UPDATEABOUT.validatedResponse(response, completionHandler: { (jsonObject, error) in
                    guard error == nil else {
                        return
                    }
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateProfileVC") as! CreateProfileVC
                    vc.memberId = self.memberId
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                
            }
        }
    }
}
