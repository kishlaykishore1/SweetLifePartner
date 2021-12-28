//
//  SplashVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 18/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func btn_LoginTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func btn_signUpTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
