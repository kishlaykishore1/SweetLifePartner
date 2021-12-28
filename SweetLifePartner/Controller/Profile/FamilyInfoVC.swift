//
//  FamilyInfoVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class FamilyInfoVC: UIViewController {
    
    var pickerView : UIPickerView?
    var getFamilyInfo: FamilyInfoModel?
    var occuptionArr = ["Choose One","Chiropractor", "Dentist","Dietitian or Nutritionist","Optometrist","Pharmacist","Physician","Physician Assistant","Podiatrist", "Registered Nurse", "Therapist", "Veterinarian", "Health Technologist or Technician", "Other Healthcare Practitioners and Technical Occupation","Nursing, Psychiatric, or Home Health Aide", "Occupational and Physical Therapist Assistant or Aide", "Other Healthcare Support Occupation","Chief Executive", "General and Operations Manager", "Advertising, Marketing, Promotions, Public Relations, and Sales Manager", "Operations Specialties Manager (e.g., IT or HR Manager)","Construction Manager", "Engineering Manager", "Accountant, Auditor", "Business Operations or Financial Specialist", "Business Owner", "Other Business, Executive, Management, Financial Occupation", "Architect, Surveyor, or Cartographer", "Engineer", "Other Architecture and Engineering Occupation", "Postsecondary Teacher (e.g., College Professor)", "Primary, Secondary, or Special Education School Teacher", "Other Teacher or Instructor", "Other Education, Training, and Library Occupation", "Arts, Design, Entertainment, Sports, and Media Occupation", "Computer Specialist, Mathematical Science","Counselor, Social Worker, or Other Community and Social Service Specialist", "Lawyer,Judge", "Life Scientist (e.g., Animal, Food, Soil, or Biological Scientist, Zoologist)","Physical Scientist (e.g., Astronomer, Physicist, Chemist, Hydrologist)", "Religious Worker(e.g., Clergy, Director of Religious Activities or Education)","Social Scientist and Related Worker","Other Professional Occupation","Supervisor of Administrative Support Workers","Financial Clerk","Secretary or Administrative Assistant","Material Recording, Scheduling, and Dispatching Worker","Other Office and Administrative Support Occupation","Protective Service (e.g., Fire Fighting, Police Officer, Correctional Officer)","Chef or Head Cook","Cook or Food Preparation Worker","Food and Beverage Serving Worker (e.g., Bartender, Waiter, Waitress)","Building and Grounds Cleaning and Maintenance","Personal Care and Service (e.g., Hairdresser, Flight Attendant, Concierge)","Sales Supervisor, Retail Sales","Retail Sales Worker","Insurance Sales Agent", "Sales Representative","Real Estate Sales Agent","Other Services Occupation","Construction and Extraction (e.g., Construction Laborer, Electrician)","Farming, Fishing, and Forestry","Installation, Maintenance, and Repair","Production Occupations","Other Agriculture, Maintenance, Repair, and Skilled Crafts Occupation","Aircraft Pilot or Flight Engineer","Motor Vehicle Operator (e.g., Ambulance, Bus, Taxi, or Truck Driver)","Other Transportation Occupation","Military","Homemaker","Other Occupation","Don't Know","Not Applicable"]
   var fatherStatusArr = ["Choose One","Employed","Business","Retired","Passed Away","Not Employed"]
   var motherStatus = ["Choose One","Employed","Business","Retired","House Wife","Passed Away","Not Employed",]
   var familyStatusData = [FamilyStatusModel]()
   var familyValuesData = [FamilyValuesModel]()
    
    @IBOutlet weak var txtNoOfBro: UITextField!
    @IBOutlet weak var txtMarriedBro: UITextField!
    @IBOutlet weak var txtNoOfSis: UITextField!
    @IBOutlet weak var txtMarriedSis: UITextField!
    @IBOutlet weak var txtFatherName: UITextField!
    @IBOutlet weak var txtFatherOccupation: UITextField!
    @IBOutlet weak var txtFatherStatus: UITextField!
    @IBOutlet weak var txtMotherName: UITextField!
    @IBOutlet weak var txtMotherOccupation: UITextField!
    @IBOutlet weak var txtMotherStatus: UITextField!
    @IBOutlet weak var txtFamilyStatus: UITextField!
    @IBOutlet weak var txtFamilyValue: UITextField!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        apiFamilyInfo()
        apiFamilyStatus()
        apiFamilyValues()
        txtFatherOccupation.addImageTo(txtField: txtFatherOccupation, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtFatherStatus.addImageTo(txtField: txtFatherStatus, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtMotherOccupation.addImageTo(txtField: txtMotherOccupation, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtMotherStatus.addImageTo(txtField: txtMotherStatus, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtFamilyStatus.addImageTo(txtField: txtFamilyStatus, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtFamilyValue.addImageTo(txtField: txtFamilyValue, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtFatherOccupation.text = occuptionArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtFatherStatus.text = fatherStatusArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtMotherOccupation.text = occuptionArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtMotherStatus.text = motherStatus[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
        title = "Family Information"
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
        
        txtFatherOccupation.delegate = self
        txtFatherStatus.delegate = self
        txtMotherOccupation.delegate = self
        txtMotherStatus.delegate = self
        txtFamilyStatus.delegate = self
        txtFamilyValue.delegate = self
        
        
        txtFatherOccupation.inputView = pickerView
        txtFatherStatus.inputView = pickerView
        txtMotherOccupation.inputView = pickerView
        txtMotherStatus.inputView = pickerView
        txtFamilyStatus.inputView = pickerView
        txtFamilyValue.inputView = pickerView
        
        self.pickerView = pickerView
    }
    //MARK:- Update Button Pressed Action
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
       
        apiFamilyInfoUpdate()
    }
    
}

//MARK:-UITextField delegates Methods
extension FamilyInfoVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension FamilyInfoVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtFatherOccupation.isFirstResponder {
            return occuptionArr.count
        } else if txtFatherStatus.isFirstResponder {
            return fatherStatusArr.count
        } else if txtMotherOccupation.isFirstResponder {
            return occuptionArr.count
        } else if txtMotherStatus.isFirstResponder {
            return motherStatus.count
        } else if txtFamilyStatus.isFirstResponder {
            return familyStatusData.count
        } else if txtFamilyValue.isFirstResponder {
            return familyValuesData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtFatherOccupation.isFirstResponder {
            return occuptionArr[row]
        } else if txtFatherStatus.isFirstResponder {
            return fatherStatusArr[row]
        } else if txtMotherOccupation.isFirstResponder {
            return occuptionArr[row]
        } else if txtMotherStatus.isFirstResponder {
            return motherStatus[row]
        } else if txtFamilyStatus.isFirstResponder {
            return familyStatusData[row].name
        } else if txtFamilyValue.isFirstResponder {
            return familyValuesData[row].name
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension FamilyInfoVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if txtFatherOccupation.isFirstResponder {
            let status = occuptionArr[row]
            txtFatherOccupation.text = status
        } else if txtFatherStatus.isFirstResponder {
            let status = fatherStatusArr[row]
            txtFatherStatus.text = status
        } else if txtMotherOccupation.isFirstResponder {
            let status = occuptionArr[row]
            txtMotherOccupation.text = status
        } else if txtMotherStatus.isFirstResponder {
            let status = motherStatus[row]
            txtMotherStatus.text = status
        } else if txtFamilyStatus.isFirstResponder {
            let status = familyStatusData[row].name
            txtFamilyStatus.text = status
        } else if txtFamilyValue.isFirstResponder {
            let status = familyValuesData[row].name
            txtFamilyValue.text = status
        }
        
    }
}


//MARK:- api calling
extension FamilyInfoVC {
//MARK:- api calling for Family Status
    func apiFamilyStatus() {
           if let getRequest = API.FAMILYSTATUS.request(method: .get, with: nil, forJsonEncoding: true){
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
                   Global.dismissLoadingSpinner()
                   API.FAMILYSTATUS.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                           self.familyStatusData = try decoder.decode([FamilyStatusModel].self, from: jsonData)
                        self.txtFamilyStatus.text = self.familyStatusData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        print(self.familyStatusData)
                       }catch let err {
                           print("Err", err)
                       }
                   })
               }
           }
       }
    //MARK:- api calling for Family Values
    func apiFamilyValues() {
           if let getRequest = API.FAMILYVALUES.request(method: .get, with: nil, forJsonEncoding: true){
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
                   Global.dismissLoadingSpinner()
                   API.FAMILYVALUES.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                           self.familyValuesData = try decoder.decode([FamilyValuesModel].self, from: jsonData)
                          self.txtFamilyValue.text = self.familyValuesData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        print(self.familyValuesData)
                       }catch let err {
                           print("Err", err)
                       }
                   })
               }
           }
       }
    
    
  //MARK:- Api calling for getting family Info data
    func apiFamilyInfo() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        if let getRequest = API.FAMILYINFO.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.FAMILYINFO.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                        self.getFamilyInfo = try decoder.decode(FamilyInfoModel.self, from: jsonData)
                        print(self.getFamilyInfo ?? "")
                        self.setData()
                    }  catch let err {
                        print("Err", err)
                    }
                    
                })
            }
            
        }
    }
    func setData() {
        txtNoOfBro.text = getFamilyInfo?.noOfBrothers
        txtMarriedBro.text = getFamilyInfo?.marriedBrothers
        txtNoOfSis.text = getFamilyInfo?.noOfSisters
        txtMarriedSis.text = getFamilyInfo?.marriedSisters
        txtFatherName.text = getFamilyInfo?.fatherName
        txtFatherOccupation.text = getFamilyInfo?.fatherOccupation
        txtFatherStatus.text = getFamilyInfo?.fatherStatus
        txtMotherName.text = getFamilyInfo?.motherName
        txtMotherOccupation.text = getFamilyInfo?.motherOccupation
        txtMotherStatus.text = getFamilyInfo?.motherStatus
        txtFamilyStatus.text = getFamilyInfo?.familyStatus
        txtFamilyValue.text = getFamilyInfo?.familyValue
       }
    
    //MARK:- calling Update Api for Family Info
    func apiFamilyInfoUpdate() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let  param:[String:Any] = ["member_id":id, "no_of_brothers": txtNoOfBro.text?.trim() ?? "", "married_brothers": txtMarriedBro.text?.trim() ?? "", "no_of_sisters": txtNoOfSis.text?.trim() ?? "", "married_sisters": txtMarriedSis.text?.trim() ?? "", "father_name": txtFatherName.text?.trim() ?? "", "father_occupation": txtFatherOccupation.text?.trim() ?? "", "father_status": txtFatherStatus.text?.trim() ?? "", "mother_name": txtMotherName.text?.trim() ?? "", "mother_occupation":txtMotherOccupation.text?.trim() ?? "","mother_status":txtMotherStatus.text?.trim() ?? "","family_status":self.familyStatusData[self.pickerView?.selectedRow(inComponent: 0) ?? 0 ].familyStatusID,"family_value":self.familyValuesData[self.pickerView?.selectedRow(inComponent: 0) ?? 0 ].familyValueID]
        
        if let getRequest = API.UPDATEFAMILYINFO.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.UPDATEFAMILYINFO.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
