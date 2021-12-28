//
//  AccountSettingsVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 23/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class AccountSettingsVC: UIViewController {

    var dataSetSection1 = ["Change Password","Update Email"]
    var MyIndex = 0
    var section1Images :  [String] = ["Change-Password","Mail"]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tableView.contentInset = UIEdgeInsets.zero
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), isImage: true)
        title = "Account Settings"
        DispatchQueue.main.async {
          self.setNavigationbarThemeGradientColor()
         // self.tableView.reloadData()
         
        }
        self.tableView.tableFooterView = UIView()
        
    }
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }


}
//MARK:- Table View DataSource Methods
extension AccountSettingsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSetSection1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountSettingTableCell") as! AccountSettingTableCell
        cell.lblSettingName.text = dataSetSection1[indexPath.row]
         cell.settingImg.image = UIImage(named: section1Images[indexPath.row])
        return cell
    }
    
    
}
//MARK:- Table View DataSource Methods
extension AccountSettingsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         MyIndex = indexPath.row
                   switch MyIndex {
                   case 0:
                       let vc = storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                       navigationController?.pushViewController(vc, animated: true)
                   case 1:
                       let vc = storyboard?.instantiateViewController(withIdentifier: "ChangeEmailVC") as! ChangeEmailVC
                       navigationController?.pushViewController(vc, animated: true)
                  
                   default:
                       break
                   }
               }
    }
//MARK:- Table view cell classes
class AccountSettingTableCell: UITableViewCell {
    
    @IBOutlet weak var settingImg: UIImageView!
    @IBOutlet weak var lblSettingName: UILabel!
    
}

