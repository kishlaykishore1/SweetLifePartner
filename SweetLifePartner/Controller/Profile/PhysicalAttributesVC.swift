//
//  PhysicalAttributesVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PhysicalAttributesVC: UIViewController {

    var labelTitles : [String] = ["Height","Weight","Eye Color","Hair Color","Complexion","Blood Group","Body Type","Body Art","Any Disability"]
    
    var getPhysicalAttribute: PhysicalAttributeModel?
    var strHeight: String?
    var strWeight: String?
    var strEyeColor: String?
    var strHairColor: String?
    var strComplexion: String?
    var strBloodGroup: String?
    var strBodyType: String?
    var strBodyart: String?
    var strAnydisability: String?
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiPhysicalAttributes()
    }
    override func viewWillAppear(_ animated: Bool) {
                  DispatchQueue.main.async {
                      self.setNavigationbarThemeGradientColor()
                  }
                   navigationController?.navigationBar.isHidden = false
                   setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
                   title = "Physical Attributes"
          }
          //MARK: Back Button Action
          override func backBtnTapAction() {
                self.navigationController?.popViewController(animated: true)
          }
  //MARK:- Update Button Pressed Action
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        let index0 = IndexPath(row: 0, section: 0)
        let heightCell = tableView.cellForRow(at: index0)! as! physicalAttributeTitlesCell
        
        let index1 = IndexPath(row: 1, section: 0)
        let weightCell =  tableView.cellForRow(at: index1)! as! physicalAttributeTitlesCell
        
        let index2 = IndexPath(row: 2, section: 0)
        let eyeColorCell =  tableView.cellForRow(at: index2)! as! physicalAttributeTitlesCell
        
        let index3 = IndexPath(row: 3, section: 0)
        let hairColorCell = tableView.cellForRow(at: index3)! as! physicalAttributeTitlesCell
        
        let index4 = IndexPath(row: 4, section: 0)
        let complexionCell =  tableView.cellForRow(at: index4)! as! physicalAttributeTitlesCell
        
        let index5 = IndexPath(row: 5, section: 0)
        let bloodGroupCell =  tableView.cellForRow(at: index5)! as! physicalAttributeTitlesCell
        
        let index6 = IndexPath(row: 6, section: 0)
        let bodyTypeCell = tableView.cellForRow(at: index6)! as! physicalAttributeTitlesCell
        
        let index7 = IndexPath(row: 7, section: 0)
        let bodyArtCell =  tableView.cellForRow(at: index7)! as! physicalAttributeTitlesCell
        
        let index8 = IndexPath(row: 8, section: 0)
        let disabilityCell =  tableView.cellForRow(at: index8)! as! physicalAttributeTitlesCell
        
        strHeight = heightCell.tfTitlesInput.text!
        strWeight = weightCell.tfTitlesInput.text!
        strEyeColor = eyeColorCell.tfTitlesInput.text!
        strHairColor = hairColorCell.tfTitlesInput.text!
        strComplexion = complexionCell.tfTitlesInput.text!
        strBloodGroup = bloodGroupCell.tfTitlesInput.text!
        strBodyType = bodyTypeCell.tfTitlesInput.text!
        strBodyart = bodyArtCell.tfTitlesInput.text!
        strAnydisability = disabilityCell.tfTitlesInput.text!
        apiPhysicalAttributeUpdate()
        
    }
}
//MARK:- TableView Datasource Methods
extension PhysicalAttributesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "physicalAttributeTitlesCell") as! physicalAttributeTitlesCell
        cell.lblTitles.text = labelTitles[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.tfTitlesInput.text = getPhysicalAttribute?.height
        case 1:
            cell.tfTitlesInput.text = getPhysicalAttribute?.weight
        case 2:
            cell.tfTitlesInput.text = getPhysicalAttribute?.eyeColor
        case 3:
            cell.tfTitlesInput.text = getPhysicalAttribute?.hairColor
        case 4:
            cell.tfTitlesInput.text = getPhysicalAttribute?.complexion
        case 5:
            cell.tfTitlesInput.text = getPhysicalAttribute?.bloodGroup
        case 6:
            cell.tfTitlesInput.text = getPhysicalAttribute?.bodyType
        case 7:
            cell.tfTitlesInput.text = getPhysicalAttribute?.bodyArt
        case 8:
            cell.tfTitlesInput.text = getPhysicalAttribute?.anyDisability
        default:
            break
        }
        return cell
    }
}
//MARK:- TableView Delegates Methods
extension PhysicalAttributesVC: UITableViewDelegate {
    
    
}
//MARK:- TableView cell class
class physicalAttributeTitlesCell: UITableViewCell {
    
    @IBOutlet weak var lblTitles: UILabel!
    @IBOutlet weak var tfTitlesInput: UITextField!
}

//MARK:- Api calling for Physical Attributes
extension PhysicalAttributesVC {
    func apiPhysicalAttributes() {
        
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        if let getRequest = API.PHYSICALATTRIBUTE.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
            Global.dismissLoadingSpinner()
                API.PHYSICALATTRIBUTE.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                        self.getPhysicalAttribute = try decoder.decode(PhysicalAttributeModel.self, from: jsonData)
                        print(self.getPhysicalAttribute ?? "")
                        self.tableView.reloadData()
                     }  catch let err {
                           print("Err", err)
                       }
                    
                })
            }
            
        }
    }
    
  //MARK:- calling Update Api for Physical Attributes
      func apiPhysicalAttributeUpdate() {
          guard let id = MemberModel.getMemberModel()?.memberID else {
              return
          }
        let  param:[String:Any] = ["member_id":id, "height":strHeight ?? "", "weight":strWeight ?? "", "eye_color":strEyeColor ?? "","hair_color":strHairColor ?? "","complexion":strComplexion ?? "","blood_group":strBloodGroup ?? "","body_type":strBodyType ?? "","body_art":strBodyart ?? "", "any_disability":strAnydisability ?? ""]
        
          if let getRequest = API.UPDATEPHYSICALATTRIBUTE.request(method: .post, with: param, forJsonEncoding: true){
              Global.showLoadingSpinner()
              getRequest.responseJSON { response in
                  Global.dismissLoadingSpinner()
                  API.UPDATEPHYSICALATTRIBUTE.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
