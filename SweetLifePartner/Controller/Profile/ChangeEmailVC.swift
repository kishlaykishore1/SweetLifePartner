//
//  ChangeEmailVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 19/02/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class ChangeEmailVC: UIViewController {

    @IBOutlet weak var tfEnterEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
          self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), isImage: true)
        title = "Update Email"
        
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
//MARK:- Submit Button Action
    @IBAction func btnSubmitPressed(_ sender: UIButton) {
    }
    
}
