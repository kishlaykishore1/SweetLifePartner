//
//  PersonalAttitudeVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PersonalAttitudeVC: UIViewController {
 
    var labelTitles : [String] = ["Affection","Humor","Political View","Religious Service" ]
    var getPersonalAttitude: PersonalAttitudeModel?
    var strAffection: String?
    var strHumor: String?
    var strPoliticalView: String?
    var strReligiousService: String?
   
       
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiPersonalAttitude()

    }
    override func viewWillAppear(_ animated: Bool) {
               DispatchQueue.main.async {
                   self.setNavigationbarThemeGradientColor()
               }
                navigationController?.navigationBar.isHidden = false
                setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
                title = "Personal Attitude"
       }
       //MARK: Back Button Action
       override func backBtnTapAction() {
             self.navigationController?.popViewController(animated: true)
       }
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
       let index0 = IndexPath(row: 0, section: 0)
       let affectionCell = tableView.cellForRow(at: index0)! as! PersonalAttTableCell
       
       let index1 = IndexPath(row: 1, section: 0)
       let humorCell =  tableView.cellForRow(at: index1)! as! PersonalAttTableCell
       
       let index2 = IndexPath(row: 2, section: 0)
       let politicalviewCell =  tableView.cellForRow(at: index2)! as! PersonalAttTableCell
       
       let index3 = IndexPath(row: 3, section: 0)
       let ReligiousWorkCell = tableView.cellForRow(at: index3)! as! PersonalAttTableCell
       
      
       
        strAffection = affectionCell.tfTitlesDataInput.text!
        strHumor = humorCell.tfTitlesDataInput.text!
        strPoliticalView = politicalviewCell.tfTitlesDataInput.text!
        strReligiousService = ReligiousWorkCell.tfTitlesDataInput.text!
        apiPersonalAttitudeUpdate()
    }
}
//MARK:- TableView Datasource Methods
extension PersonalAttitudeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalAttTableCell") as! PersonalAttTableCell
        cell.lblTitles.text = labelTitles[indexPath.row]
        cell.tfTitlesDataInput.setPadding(left: 10)
        switch indexPath.row {
           case 0:
            cell.tfTitlesDataInput.text = getPersonalAttitude?.affection
           case 1:
            cell.tfTitlesDataInput.text = getPersonalAttitude?.humor
           case 2:
            cell.tfTitlesDataInput.text = getPersonalAttitude?.politicalView
           case 3:
            cell.tfTitlesDataInput.text = getPersonalAttitude?.religiousService
           default:
               break
           }
        return cell
    }
}
//MARK:- TableView Delegates Methods
extension PersonalAttitudeVC: UITableViewDelegate {
    
    
}
//MARK:- TableView Cell Class
class PersonalAttTableCell: UITableViewCell {
    
    @IBOutlet weak var lblTitles: UILabel!
    @IBOutlet weak var tfTitlesDataInput: UITextField!
}
//MARK:- Api Calling to get Personal Attitude And Behaviour
extension PersonalAttitudeVC {
        func apiPersonalAttitude() {
            
            guard let id = MemberModel.getMemberModel()?.memberID else {
                return
            }
            if let getRequest = API.PERSONALATTITUDE.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
                Global.showLoadingSpinner()
                getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                    API.PERSONALATTITUDE.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                            self.getPersonalAttitude = try decoder.decode(PersonalAttitudeModel.self, from: jsonData)
                            print(self.getPersonalAttitude ?? "")
                            self.tableView.reloadData()
                         }  catch let err {
                               print("Err", err)
                           }
                        
                    })
                }
                
            }
        }
    
//MARK:- calling Update Api for Physical Attributes
    func apiPersonalAttitudeUpdate() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
      let  param:[String:Any] = ["member_id":id, "affection":strAffection ?? "", "humor":strHumor ?? "", "political_view":strPoliticalView ?? "","religious_service":strReligiousService ?? ""]
      
        if let getRequest = API.UPDATEPERSONALATTITUDE.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.UPDATEPERSONALATTITUDE.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
