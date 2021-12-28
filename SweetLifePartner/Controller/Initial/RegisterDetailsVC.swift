//
//  RegisterDetailsVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 20/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class RegisterDetailsVC: UIViewController {
    
    var residentialStatusArr = ["Permanent Residence","Non - Resident"]
    var memberId: String!
    var pickerView : UIPickerView?
    var dataSource = [MaritalStatusModel]()
    var religionData = [ReligionModel]()
    var casteData = [GetCasteModel]()
    var religionID = ""
    var countryData = [GetCountryModel]()
    var countryID = ""
    var stateData = [GetStateModel]()
    var stateID = ""
    var cityData = [GetCityModel]()
    
    var param: [String: Any]!
    
    
    @IBOutlet weak var tfReligion: UITextField!
    @IBOutlet weak var tfMaritalStatus: UITextField!
    @IBOutlet weak var tfCaste: UITextField!
    @IBOutlet weak var tfDosham: UITextField!
    @IBOutlet weak var tfCountryLivingIn: UITextField!
    @IBOutlet weak var tfStateLivingIn: UITextField!
    @IBOutlet weak var tfCityLivingIn: UITextField!
    @IBOutlet weak var tfCitizenship: UITextField!
    @IBOutlet weak var tfResidentialStatus: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfResidentialStatus.text = self.residentialStatusArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        setDownImage()
        PickerViewConnection()
        apiMaritalStatus()
        apiReligion()
        apiCountryLivingIn()
        
        print(param ?? "")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
        title = "REGISTRATION"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK:- Setting The Text Fields Right Image
       func setDownImage() {
           tfReligion.addImageTo(txtField: tfReligion, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           tfMaritalStatus.addImageTo(txtField: tfMaritalStatus, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           tfCaste.addImageTo(txtField: tfCaste, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           tfCountryLivingIn.addImageTo(txtField:  tfCountryLivingIn, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           tfStateLivingIn.addImageTo(txtField:  tfStateLivingIn, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           tfCityLivingIn.addImageTo(txtField:  tfCityLivingIn, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
       }
   //MARK:- Action For Continue Button
    @IBAction func btnContinuePressed(_ sender: UIButton) {
        
        if Validation.isBlank(for: tfMaritalStatus.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyMaritalStatus, alertType: .error)
            return
        } else if Validation.isBlank(for: tfReligion.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyReligion, alertType: .error)
            return
        } else if Validation.isBlank(for: tfCaste.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyCaste, alertType: .error)
            return
        } else if Validation.isBlank(for: tfCountryLivingIn.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyCountry, alertType: .error)
            return
        } else if Validation.isBlank(for: tfStateLivingIn.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyState, alertType: .error)
            return
        } else if Validation.isBlank(for: tfCityLivingIn.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyCity, alertType: .error)
            return
        } else if Validation.isBlank(for: tfResidentialStatus.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyResidentialStatus, alertType: .error)
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterMoreDetailsVC") as! RegisterMoreDetailsVC
        param["marital_status"] = self.dataSource[self.pickerView?.selectedRow(inComponent: 0) ?? 0].id
        param["caste"] = self.casteData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].casteID
        param["dosham"] = tfDosham.text?.trim()
        param["get_country"] = countryID
        param["get_state"] = stateID
        param["get_city"] = self.cityData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].cityID
        param["citizenship"] = tfCitizenship.text!.trim()
        param["residential_status"] = tfResidentialStatus.text!.trim()
        print(param ?? "")
        vc.param = param
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- UIPickerView Delegates assigning
    func PickerViewConnection() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tfResidentialStatus.delegate = self
        tfMaritalStatus.delegate = self
        tfReligion.delegate = self
        tfCaste.delegate = self
        tfCountryLivingIn.delegate = self
        tfStateLivingIn.delegate = self
        tfCityLivingIn.delegate = self
        
        
        
        tfResidentialStatus.inputView = pickerView
        tfMaritalStatus.inputView = pickerView
        tfReligion.inputView = pickerView
        tfCaste.inputView = pickerView
        tfCountryLivingIn.inputView = pickerView
        tfStateLivingIn.inputView = pickerView
        tfCityLivingIn.inputView = pickerView
        
        self.pickerView = pickerView
    }
    
}
//MARK:-UITextField delegates Methods
extension RegisterDetailsVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension RegisterDetailsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfResidentialStatus.isFirstResponder {
            return residentialStatusArr.count
        } else if tfMaritalStatus.isFirstResponder {
            return dataSource.count
        } else if tfReligion.isFirstResponder {
            return religionData.count
        } else if tfCaste.isFirstResponder {
            return casteData.count
        } else if tfCountryLivingIn.isFirstResponder {
            return countryData.count
        } else if tfStateLivingIn.isFirstResponder {
            return stateData.count
        } else if tfCityLivingIn.isFirstResponder {
            return cityData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // return residentialStatusArr[row]
        if tfResidentialStatus.isFirstResponder {
            return residentialStatusArr[row]
        } else if tfMaritalStatus.isFirstResponder {
            return dataSource[row].name
        } else if tfReligion.isFirstResponder {
            return religionData[row].name
        } else if tfCaste.isFirstResponder {
            return casteData[row].casteName
        } else if tfCountryLivingIn.isFirstResponder {
            return countryData[row].name
        } else if tfStateLivingIn.isFirstResponder {
            return stateData[row].name
        } else if tfCityLivingIn.isFirstResponder {
            return cityData[row].name
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension RegisterDetailsVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tfResidentialStatus.isFirstResponder{
            let itemselected = residentialStatusArr[row]
            tfResidentialStatus.text = itemselected
            
        } else if tfMaritalStatus.isFirstResponder {
            let stauts = dataSource[row].name
            tfMaritalStatus.text = stauts
            
        } else if tfReligion.isFirstResponder {
            let stauts = religionData[row].name
            self.religionID = religionData[row].religionID
            apiCaste()
            tfReligion.text = stauts
            
        } else if tfCaste.isFirstResponder {
            let stauts = casteData[row].casteName
            tfCaste.text = stauts
            
        } else if tfCountryLivingIn.isFirstResponder {
            let stauts = countryData[row].name
            self.countryID = countryData[row].countryID
            apiStateLivingIn()
            tfCountryLivingIn.text = stauts
            
        } else if tfStateLivingIn.isFirstResponder {
            let stauts = stateData[row].name
            self.stateID = stateData[row].stateID
            apiCityLivingIn()
            tfStateLivingIn.text = stauts
            
        } else if tfCityLivingIn.isFirstResponder {
            let stauts = cityData[row].name
            tfCityLivingIn.text = stauts
            
        }
        
    }
}

//MARK:-API Calling for Getting MaritalStatus
extension RegisterDetailsVC {
    func apiMaritalStatus() {
        
        if let getRequest = API.MARITALSTATUS.request(method: .get, with: nil, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.MARITALSTATUS.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                        self.dataSource = try decoder.decode([MaritalStatusModel].self, from: jsonData)
                        if self.dataSource.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        self.tfMaritalStatus.text = self.dataSource[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                        print(self.dataSource)
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
    }
    
    
//MARK:- Api Calling for Religion Text Field
       func apiReligion() {
           if let getRequest = API.RELIGION.request(method: .get, with: nil, forJsonEncoding: true){
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
                   Global.dismissLoadingSpinner()
                   API.RELIGION.validatedResponse(response, completionHandler: { (jsonObject, error) in
                       guard  error == nil else {
                           return
                       }
                       guard let getData = jsonObject?["data"] as? [[String: Any]] else {
                           Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                           return
                       }
                       do{
                           let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
                           let decoder = JSONDecoder()
                           self.religionData = try decoder.decode([ReligionModel].self, from: jsonData)
                           if self.religionData.count > 0 {
                           self.pickerView?.selectRow(0, inComponent:0, animated: true)
                           self.tfReligion.text = self.religionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                           }
                           print(self.religionData)
                       }catch let err {
                           print("Err", err)
                       }
                   })
               }
           }
       }
//MARK:-API Calling for Getting Caste
    func apiCaste() {
        let param: [String: Any] = ["religion_id": religionID]
        print(param)
        if let getRequest = API.GETCASTE.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.GETCASTE.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                        self.casteData = try decoder.decode([GetCasteModel].self, from: jsonData)
                        if self.casteData.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        self.tfCaste.text = self.casteData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].casteName
                        }
                        print(self.casteData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
    }
    
//MARK:-API Calling for Getting Country Living in
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
                        self.countryData = try decoder.decode([GetCountryModel].self, from: jsonData)
                        if self.countryData.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        self.tfCountryLivingIn.text = self.countryData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                        print(self.countryData)
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
                        if self.stateData.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        self.tfStateLivingIn.text = self.stateData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
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
                        if self.cityData.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        self.tfCityLivingIn.text = self.cityData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                        print(self.cityData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
    }
}
