//
//  ResidencyInfoVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class ResidencyInfoVC: UIViewController {

    
    var pickerView : UIPickerView?
    var getCountryData = [GetCountryModel]()
    var getResidencyInfo: ResidencyInfoModel?
    
    @IBOutlet weak var tfBirthCountry: UITextField!
    @IBOutlet weak var tfResidencyCountry: UITextField!
    @IBOutlet weak var tfCitizenshipCountry: UITextField!
    @IBOutlet weak var tfGrowUpCountry: UITextField!
    @IBOutlet weak var tfImmigrationStatus: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        apiCountryLivingIn()
        apiResidencyInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
               DispatchQueue.main.async {
                   self.setNavigationbarThemeGradientColor()
               }
                navigationController?.navigationBar.isHidden = false
                setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
                title = "Residency Information"
       }
       //MARK: Back Button Action
       override func backBtnTapAction() {
             self.navigationController?.popViewController(animated: true)
       }
//MARK:- UIPickerView Delegates assigning
    func PickerViewConnection() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tfBirthCountry.delegate = self
        tfResidencyCountry.delegate = self
        tfCitizenshipCountry.delegate = self
        tfGrowUpCountry.delegate = self
       
        
        tfBirthCountry.inputView = pickerView
        tfResidencyCountry.inputView = pickerView
        tfCitizenshipCountry.inputView = pickerView
        tfGrowUpCountry.inputView = pickerView
        
        self.pickerView = pickerView
    }
        
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        
        
        apiResidencyInfoUpdate()
    }
}

//MARK:-UITextField delegates Methods
extension ResidencyInfoVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension ResidencyInfoVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfBirthCountry.isFirstResponder {
            return getCountryData.count
        } else if tfResidencyCountry.isFirstResponder {
            return getCountryData.count
        } else if tfCitizenshipCountry.isFirstResponder {
            return getCountryData.count
        } else if tfGrowUpCountry.isFirstResponder {
            return getCountryData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if tfBirthCountry.isFirstResponder {
            return getCountryData[row].name
        } else if tfResidencyCountry.isFirstResponder {
            return getCountryData[row].name
        } else if tfCitizenshipCountry.isFirstResponder {
            return getCountryData[row].name
        } else if tfGrowUpCountry.isFirstResponder {
            return getCountryData[row].name
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension ResidencyInfoVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tfBirthCountry.isFirstResponder {
            let status = getCountryData[row].name
            tfBirthCountry.text = status
        } else if tfResidencyCountry.isFirstResponder {
            let status = getCountryData[row].name
            tfResidencyCountry.text = status
        } else if tfCitizenshipCountry.isFirstResponder {
            let status = getCountryData[row].name
            tfCitizenshipCountry.text = status
        } else if tfGrowUpCountry.isFirstResponder {
            let status = getCountryData[row].name
            tfGrowUpCountry.text = status
        }
        
    }
}

//MARK:-API Calling for Getting Country Living in
extension ResidencyInfoVC {
    func apiCountryLivingIn() {
        // let param: [String: Any] = ["religion_id": religionID]
        //print(param)
        if let getRequest = API.GETCOUNTRY.request(method: .get, with: nil, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.GETCOUNTRY.validatedResponse(response, completionHandler: { (jsonObject, error) in
                    guard error == nil else {
                        return
                    }
                    guard let getData = jsonObject?["data"] as? [[String: Any]] else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        self.getCountryData = try decoder.decode([GetCountryModel].self, from: jsonData)
                        print(self.getCountryData)
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
        
    }
 //MARK:- api calling For Residency Info
  func apiResidencyInfo() {
           guard let id = MemberModel.getMemberModel()?.memberID else {
               return
           }
           if let getRequest = API.RESIDENCYINFO.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
               Global.dismissLoadingSpinner()
                   API.RESIDENCYINFO.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                          self.getResidencyInfo = try decoder.decode(ResidencyInfoModel.self, from: jsonData)
                           print(self.getResidencyInfo ?? "")
                          self.setResidencyInfoData()
                        }  catch let err {
                              print("Err", err)
                          }
                       
                   })
               }
               
           }
       }
    
    func setResidencyInfoData() {
        tfBirthCountry.text = getResidencyInfo?.birthCountry
        tfResidencyCountry.text = getResidencyInfo?.residencyCountry
        tfCitizenshipCountry.text = getResidencyInfo?.citizenshipCountry
        tfImmigrationStatus.text = getResidencyInfo?.immigrationStatus
        tfGrowUpCountry.text = getResidencyInfo?.growUpCountry
    }
    
    
//MARK:- calling Update Api for Residency Info
        func apiResidencyInfoUpdate() {
              guard let id = MemberModel.getMemberModel()?.memberID else {
                  return
              }
            let  param:[String:Any] = ["member_id":id, "birth_country":tfBirthCountry.text?.trim() ?? "", "residency_country":tfResidencyCountry.text?.trim() ?? "", "citizenship_country":tfCitizenshipCountry.text?.trim() ?? "","grow_up_country":tfGrowUpCountry.text?.trim() ?? "","immigration_status":tfImmigrationStatus.text?.trim() ?? ""]
            
              if let getRequest = API.UPDATERESIDENCYINFO.request(method: .post, with: param, forJsonEncoding: true){
                  Global.showLoadingSpinner()
                  getRequest.responseJSON { response in
                      Global.dismissLoadingSpinner()
                      API.UPDATERESIDENCYINFO.validatedResponse(response, completionHandler: { (jsonObject, error) in
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



