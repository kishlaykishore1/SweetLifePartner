//
//  AstroInfoVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class AstroInfoVC: UIViewController {

    var labelTitles : [String] = ["Sun Sign","Moon Sign","Time Of Birth","City of Birth"]
    var getAstronomicInfo: AstronomicDataModel?
    var strSunSign: String?
    var strMoonSign: String?
    var strTimeOfBirth: String?
    var strCityOfBirth: String?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiAstroInfo()

    }
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async {
                self.setNavigationbarThemeGradientColor()
            }
             navigationController?.navigationBar.isHidden = false
             setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
             title = "Astronomic Information"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
          self.navigationController?.popViewController(animated: true)
    }

//MARK:- Update Button Action
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
       let index0 = IndexPath(row: 0, section: 0)
       let sunSignCell = tableView.cellForRow(at: index0)! as! AstroInfoTableCell
       
       let index1 = IndexPath(row: 1, section: 0)
       let moonSignCell =  tableView.cellForRow(at: index1)! as! AstroInfoTableCell
       
       let index2 = IndexPath(row: 2, section: 0)
       let timeOfBirthCell =  tableView.cellForRow(at: index2)! as! AstroInfoTableCell
       
       let index3 = IndexPath(row: 3, section: 0)
       let cityOfBirthCell = tableView.cellForRow(at: index3)! as! AstroInfoTableCell
       
      strSunSign = sunSignCell.tfTitlesDataInput.text!
      strMoonSign = moonSignCell.tfTitlesDataInput.text!
      strTimeOfBirth = timeOfBirthCell.tfTitlesDataInput.text!
      strCityOfBirth = cityOfBirthCell.tfTitlesDataInput.text!
      apiAstroInfoUpdate()
    }
    
}
//MARK:- TableView Datasource Methods
extension AstroInfoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AstroInfoTableCell") as! AstroInfoTableCell
        cell.lblTitles.text = labelTitles[indexPath.row]
        cell.tfTitlesDataInput.setPadding(left: 10)
        switch indexPath.row {
        case 0:
            cell.tfTitlesDataInput.text = getAstronomicInfo?.sunSign
        case 1:
            cell.tfTitlesDataInput.text = getAstronomicInfo?.moonSign
        case 2:
            cell.tfTitlesDataInput.text = getAstronomicInfo?.timeOfBirth
        case 3:
            cell.tfTitlesDataInput.text = getAstronomicInfo?.cityOfBirth
       
        default:
            break
        }
        return cell
    }
}
//MARK:- TableView Delegates Methods
extension AstroInfoVC: UITableViewDelegate {
    
    
}
//MARK:-TableView Cell Class
class AstroInfoTableCell: UITableViewCell {
    
    @IBOutlet weak var lblTitles: UILabel!
    @IBOutlet weak var tfTitlesDataInput: UITextField!
}

//MARK:- Api calling for Astro Info
extension AstroInfoVC {
    func apiAstroInfo() {
        
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        if let getRequest = API.ASTROINFO.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
            Global.dismissLoadingSpinner()
                API.ASTROINFO.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                        self.getAstronomicInfo = try decoder.decode(AstronomicDataModel.self, from: jsonData)
                        print(self.getAstronomicInfo ?? "")
                        self.tableView.reloadData()
                     }  catch let err {
                           print("Err", err)
                       }
                    
                })
            }
            
        }
    }
    
  //MARK:- calling Update Api for Astro info
      func apiAstroInfoUpdate() {
          guard let id = MemberModel.getMemberModel()?.memberID else {
              return
          }
        let  param:[String:Any] = ["member_id":id, "sun_sign":strSunSign ?? "", "moon_sign":strMoonSign ?? "", "time_of_birth":strTimeOfBirth ?? "","city_of_birth":strCityOfBirth ?? ""]
        
          if let getRequest = API.UPDATEASTROINFO.request(method: .post, with: param, forJsonEncoding: true){
              Global.showLoadingSpinner()
              getRequest.responseJSON { response in
                  Global.dismissLoadingSpinner()
                  API.UPDATEASTROINFO.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
