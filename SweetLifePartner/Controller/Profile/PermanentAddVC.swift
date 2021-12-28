//
//  PermanentAddVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PermanentAddVC: UIViewController {
    
    var pickerView : UIPickerView?
    var getPermanentAddData : PermanentAddModel?
    var getcountryData = [GetCountryModel]()
    var countryID = ""
    var stateData = [GetStateModel]()
    var stateID = ""
    var cityData = [GetCityModel]()
    
    @IBOutlet weak var tfCountry: UITextField!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfPostalCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        apiCountryLivingIn()
        apiPermanentAdd()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
        title = "Permanent Address"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Update Button Action
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        apiPermanentAddUpdate()
    }
    
    //MARK:- UIPickerView Delegates assigning
    func PickerViewConnection() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tfCountry.delegate = self
        tfState.delegate = self
        tfCity.delegate = self
        
        
        tfCountry.inputView = pickerView
        tfState.inputView = pickerView
        tfCity.inputView = pickerView
        
        self.pickerView = pickerView
    }
    
}
//MARK:-UITextField delegates Methods
extension PermanentAddVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension PermanentAddVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfCountry.isFirstResponder {
            return getcountryData.count
        } else if tfState.isFirstResponder {
            return stateData.count
        } else if tfCity.isFirstResponder {
            return cityData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if tfCountry.isFirstResponder {
            return getcountryData[row].name
        } else if tfState.isFirstResponder {
            return stateData[row].name
        } else if tfCity.isFirstResponder {
            return cityData[row].name
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension PermanentAddVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if tfCountry.isFirstResponder {
            let status = getcountryData[row].name
            self.countryID = getcountryData[row].countryID
            apiStateLivingIn()
            tfCountry.text = status
        } else if tfState.isFirstResponder {
            let status = stateData[row].name
            self.stateID = stateData[row].stateID
            apiCityLivingIn()
            tfState.text = status
        } else if tfCity.isFirstResponder {
            let status = cityData[row].name
            tfCity.text = status
        }
    }
}

//MARK:- api Calling
extension PermanentAddVC {
    //MARK:-API Calling for Getting Country Living in
    func apiCountryLivingIn() {
        
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
                        self.getcountryData = try decoder.decode([GetCountryModel].self, from: jsonData)
                        print(self.getcountryData)
                        
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
        
    }
    
    //MARK:-API Calling for Getting State Living In
    func apiStateLivingIn() {
        let param: [String: Any] = ["country_id": countryID]
        print(param)
        if let getRequest = API.GETSTATE.request(method: .post, with: param, forJsonEncoding: true){
            //Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                // Global.dismissLoadingSpinner()
                API.GETSTATE.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                        self.stateData = try decoder.decode([GetStateModel].self, from: jsonData)
                        print(self.stateData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
    }
    //MARK:-API Calling for Getting City Living In
    func apiCityLivingIn() {
        let param: [String: Any] = ["state_id": stateID]
        print(param)
        if let getRequest = API.GETCITY.request(method: .post, with: param, forJsonEncoding: true){
            //  Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                //  Global.dismissLoadingSpinner()
                API.GETCITY.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                        self.cityData = try decoder.decode([GetCityModel].self, from: jsonData)
                        print(self.cityData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
    }
    //MARK:- api calling For Permanent Address
    func apiPermanentAdd() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        if let getRequest = API.PERMANENTADDRESS.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.PERMANENTADDRESS.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                        self.getPermanentAddData = try decoder.decode(PermanentAddModel.self, from: jsonData)
                        print(self.getPermanentAddData ?? "")
                        self.setPermanentAddData()
                    }  catch let err {
                        print("Err", err)
                    }
                    
                })
            }
            
        }
    }
    
    func setPermanentAddData() {
        tfCountry.text = getPermanentAddData?.permanentCountry
        tfState.text = getPermanentAddData?.permanentState
        tfCity.text = getPermanentAddData?.permanentCity
        tfPostalCode.text = getPermanentAddData?.permanentPostalCode
        
    }
    //MARK:- calling Update Api for Residency Info
    func apiPermanentAddUpdate() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let  param:[String:Any] = ["member_id":id, "permanent_country":tfCountry.text?.trim() ?? "", "permanent_city":tfCity.text?.trim() ?? "", "permanent_state":tfState.text?.trim() ?? "","permanent_postal_code":tfPostalCode.text?.trim() ?? ""]
        
        if let getRequest = API.UPDATEPERMANENTADDRESS.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.UPDATEPERMANENTADDRESS.validatedResponse(response, completionHandler: { (jsonObject, error) in
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



