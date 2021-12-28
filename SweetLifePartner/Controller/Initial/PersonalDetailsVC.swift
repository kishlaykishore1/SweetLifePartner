//
//  PersonalDetailsVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 22/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PersonalDetailsVC: UIViewController {

    var param: [String: Any]!
    
    
    @IBOutlet weak var tfGetEducationData: UILabel!
    @IBOutlet weak var lblSelectedOccupation: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
     
       
    }
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async {
                self.setNavigationbarThemeGradientColor()
            }
             navigationController?.navigationBar.isHidden = false
             setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
             title = "PERSONAL DETAILS"
        tfGetEducationData.text = param["education"] as? String ?? ""
        lblSelectedOccupation.text = param["occupation"] as? String ?? ""
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
          self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinuePressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PartnerRequirementsVC") as! PartnerRequirementsVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSkipPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PartnerRequirementsVC") as! PartnerRequirementsVC
               navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
