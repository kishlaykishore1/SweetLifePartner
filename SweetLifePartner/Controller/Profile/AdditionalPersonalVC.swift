//
//  AdditionalPersonalVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class AdditionalPersonalVC: UIViewController {
    
    var labelTitles : [String] = ["Home District","Family Residence","Father's Occupation","Special Circumstances"]
    var getAdditionalpersonalInfo: AdditionalPersonalModel?
    var strHomedist: String?
    var strFamilyResidence: String?
    var strFathersOccupation: String?
    var strSpecialCircumstances: String?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiAdditionalPersonalInfo()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
        title = "Additional Personal Details"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Update Button Action
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        let index0 = IndexPath(row: 0, section: 0)
        let homeDistCell = tableView.cellForRow(at: index0)! as! AdditionalInfoTableCell
        
        let index1 = IndexPath(row: 1, section: 0)
        let familyResdCell =  tableView.cellForRow(at: index1)! as! AdditionalInfoTableCell
        
        let index2 = IndexPath(row: 2, section: 0)
        let fatherOccupationCell =  tableView.cellForRow(at: index2)! as! AdditionalInfoTableCell
        
        let index3 = IndexPath(row: 3, section: 0)
        let specialCircumstanceCell = tableView.cellForRow(at: index3)! as! AdditionalInfoTableCell
        
        strHomedist = homeDistCell.tfTitlesDataInput.text!
        strFamilyResidence = familyResdCell.tfTitlesDataInput.text!
        strFathersOccupation = fatherOccupationCell.tfTitlesDataInput.text!
        strSpecialCircumstances = specialCircumstanceCell.tfTitlesDataInput.text!
        apiAdditionalPersonalInfoUpdate()
    }
    
}
//MARK:- TableView Datasource Methods
extension AdditionalPersonalVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionalInfoTableCell") as! AdditionalInfoTableCell
        cell.lblTitles.text = labelTitles[indexPath.row]
        cell.tfTitlesDataInput.setPadding(left: 10)
        switch indexPath.row {
        case 0:
            cell.tfTitlesDataInput.text = getAdditionalpersonalInfo?.homeDistrict
        case 1:
            cell.tfTitlesDataInput.text = getAdditionalpersonalInfo?.familyResidence
        case 2:
            cell.tfTitlesDataInput.text = getAdditionalpersonalInfo?.fathersOccupation
        case 3:
            cell.tfTitlesDataInput.text = getAdditionalpersonalInfo?.specialCircumstances
        default:
            break
        }
        return cell
    }
}
//MARK:- TableView Delegates Methods
extension AdditionalPersonalVC: UITableViewDelegate {
    
    
}
//MARK:-TAbleView Cell class
class AdditionalInfoTableCell: UITableViewCell {
    
    @IBOutlet weak var lblTitles: UILabel!
    @IBOutlet weak var tfTitlesDataInput: UITextField!
}

//MARK:- api calling for Getting Additional Personal Info
extension AdditionalPersonalVC {
    func apiAdditionalPersonalInfo() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        if let getRequest = API.ADDITIONALPERSONALINFO.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.ADDITIONALPERSONALINFO.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                        self.getAdditionalpersonalInfo = try decoder.decode(AdditionalPersonalModel.self, from: jsonData)
                        print(self.getAdditionalpersonalInfo ?? "")
                        self.tableView.reloadData()
                    }  catch let err {
                        print("Err", err)
                    }
                    
                })
            }
            
        }
    }
    
    //MARK:- calling Update Api for Additional Personal Info
    func apiAdditionalPersonalInfoUpdate() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let  param:[String:Any] = ["member_id":id, "home_district":strHomedist ?? "", "family_residence":strFamilyResidence ?? "", "fathers_occupation":strFathersOccupation ?? "","special_circumstances":strSpecialCircumstances ?? ""]
        
        if let getRequest = API.UPDATEADDITIONALPERSONALINFO.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.UPDATEADDITIONALPERSONALINFO.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
