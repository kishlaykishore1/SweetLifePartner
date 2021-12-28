//
//  PartnerRequirementsVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 22/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PartnerRequirementsVC: UIViewController {
    
    var pickerView : UIPickerView?
    var ageData = ["18 Yrs - 21 Yrs","22 Yrs - 25 Yrs","26 Yrs - 29 Yrs","30 Yrs - 33 Yrs","34 Yrs - 37 Yrs","38 Yrs - 41 Yrs","42 Yrs - 45 Yrs"]
    var heightDataArr = ["4.0-4.4","4.4-4.8","4.8-5.2","5.2-5.6","5.6-6.0","6.0-6.4","6.4-6.8","6.8-7.2"]
    var physicalStatusArr = ["Normal","Physically Challenged"]
    var getMaritalStatus = [MaritalStatusModel]()
    var getReligionData = [ReligionModel]()
    var getCasteData = [GetCasteModel]()
    var getMotherTongue = [MotherTongueModel]()
    var getStarsData = [""]
    var isMangalik = [""]
    var getCountryData = [GetCountryModel]()
    var getCountryID = ""
    var getStateData = [GetStateModel]()
    var getStateID = ""
    var getCityData = [GetCityModel]()
    var educationDataArr = ["B.Arch","B.A.","B.A.M.S.","B.B.A.","B.Com.","B.C.A.","B.D.S.","B.Des. / B.D.","B.Ed.","B.E./B.Tech.","BFA / BVA","B.F.Sc./ B.Sc. (Fisheries).","B.H.M.S."," L.L.B.","B.Lib. / B.Lib.Sc."," B.M.C. / B.M.M.","M.B.B.S.","Bachelor of Nursing","B.Pharm / B.Pharma.","B.P.Ed.","B.P.T.","B.Sc.","BSW / B.A. (SW)","B.V.Sc. &amp; A.H. / B.V.Sc","M.D.","M.D. (Homoeopathy)","Pharm.D","Ph.D.","D.M.","M.Arch.","M.A.","M.B.A.","M.Ch.","M.Com.","M.C.A.","M.D.S.","M.Des./ M.Design.","M.Ed.","M.E./ M.Tech.","MFA / MVA","L.L.M.","M.Lib./ M.Lib.Sc.","M.M.C / M.M.M.","M.Pharm","M.Phil","M.P.Ed. / M.P.E.","M.P.T.","M.Sc.","M.S.W. / M.A. (SW)","M.Sc.(Agriculture)","M.S.","M.V.Sc."]
    var occuptionArr = ["Chiropractor","Dentist","Dietitian or  Nutritionist","Optometrist","Pharmacist","Physician","Physician Assistant","Podiatrist", "Registered Nurse", "Therapist", "Veterinarian", "Health Technologist or Technician", "Other Healthcare Practitioners and Technical Occupation","Nursing, Psychiatric, or Home Health Aide", "Occupational and Physical Therapist Assistant or Aide", "Other Healthcare Support Occupation","Chief Executive", "General and Operations Manager", "Advertising, Marketing, Promotions, Public Relations, and Sales Manager", "Operations Specialties Manager (e.g., IT or HR Manager)","Construction Manager", "Engineering Manager", "Accountant, Auditor", "Business Operations or Financial Specialist", "Business Owner","Other Business, Executive, Management, Financial Occupation", "Architect, Surveyor, or Cartographer", "Engineer", "Other Architecture and Engineering Occupation","Postsecondary Teacher (e.g., College Professor)", "Primary, Secondary, or Special Education School Teacher", "Other Teacher or Instructor","Other Education, Training, and Library Occupation", "Arts, Design, Entertainment, Sports, and Media Occupation", "Computer Specialist, Mathematical Science","Counselor, Social Worker, or Other Community and Social Service Specialist", "Lawyer,Judge", "Life Scientist (e.g., Animal, Food, Soil, or Biological Scientist, Zoologist)","Physical Scientist (e.g., Astronomer, Physicist, Chemist, Hydrologist)", "Religious Worker(e.g., Clergy, Director of Religious Activities or Education)","Social Scientist and Related Worker","Other Professional Occupation","Supervisor of Administrative Support Workers","Financial Clerk","Secretary or Administrative Assistant","Material Recording, Scheduling, and Dispatching Worker","Other Office and Administrative Support Occupation","Protective Service (e.g., Fire Fighting, Police Officer, Correctional Officer)","Chef or Head Cook","Cook or Food Preparation Worker","Food and Beverage Serving Worker (e.g., Bartender, Waiter, Waitress)","Building and Grounds Cleaning and Maintenance","Personal Care and Service (e.g., Hairdresser, Flight Attendant, Concierge)","Sales Supervisor, Retail Sales","Retail Sales Worker","Insurance Sales Agent","Sales Representative","Real Estate Sales Agent","Other Services Occupation","Construction and Extraction (e.g., Construction Laborer, Electrician)","Farming, Fishing, and Forestry","Installation, Maintenance, and Repair","Production Occupations","Other Agriculture, Maintenance, Repair, and Skilled Crafts Occupation","Aircraft Pilot or Flight Engineer","Motor Vehicle Operator (e.g., Ambulance, Bus, Taxi, or Truck Driver)","Other Transportation Occupation","Military","Homemaker","Other Occupation","Don't Know","Not Applicable"]
    var annualIncomeArr = ["Below 50K","50K- 1Lac","1Lac- 3 Lac","3Lac- 6 Lac","6Lac- 10Lac","10 Lac- 15 Lac","20 Lac- 40 Lac","40 Lac and above"]
    //var param: [String: Any]!
    
    
    @IBOutlet weak var tfAge: UITextField!
    @IBOutlet weak var tfHeight: UITextField!
    @IBOutlet weak var tfMaritalStatus: UITextField!
    @IBOutlet weak var tfPhysicalStatus: UITextField!
    @IBOutlet weak var tfLifestylePreferences: UITextField!
    @IBOutlet weak var tfReligion: UITextField!
    @IBOutlet weak var tfMotherTongue: UITextField!
    @IBOutlet weak var tfCaste: UITextField!
    @IBOutlet weak var tfStar: UITextField!
    @IBOutlet weak var tfManglik: UITextField!
    @IBOutlet weak var tfCountryLivingIn: UITextField!
    @IBOutlet weak var tfStateLivingIn: UITextField!
    @IBOutlet weak var tfCityLivingIn: UITextField!
    @IBOutlet weak var tfEducation: UITextField!
    @IBOutlet weak var tfOccupation: UITextField!
    @IBOutlet weak var tfAnnualIncome: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        apiCountryLivingIn()
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
        
        let skipButton: UIBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skip))
        skipButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationItem.rightBarButtonItem = skipButton
        title = "PARTNER PREFERENCES"
    }
    //MARK:- Navigation Right button Action
    @objc func skip() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
       
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- Back Button Action
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Save button Action
    @IBAction func btnSaveContinuePressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- UIPickerView Delegates assigning
    func PickerViewConnection() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tfAge.delegate = self
        tfHeight.delegate = self
        tfMaritalStatus.delegate = self
        tfPhysicalStatus.delegate = self
        tfReligion.delegate = self
        tfMotherTongue.delegate = self
        tfCaste.delegate = self
        tfCountryLivingIn.delegate = self
        tfStateLivingIn.delegate = self
        tfCityLivingIn.delegate = self
        tfEducation.delegate = self
        tfOccupation.delegate = self
        tfAnnualIncome.delegate = self
        
        
        
        tfAge.inputView = pickerView
        tfHeight.inputView = pickerView
        tfMaritalStatus.inputView = pickerView
        tfPhysicalStatus.inputView = pickerView
        tfReligion.inputView = pickerView
        tfMotherTongue.inputView = pickerView
        tfCaste.inputView = pickerView
        tfCountryLivingIn.inputView = pickerView
        tfStateLivingIn.inputView = pickerView
        tfCityLivingIn.inputView = pickerView
        tfEducation.inputView = pickerView
        tfOccupation.inputView = pickerView
        tfAnnualIncome.inputView = pickerView
        
        self.pickerView = pickerView
    }
    
}
//MARK:-UITextField delegates Methods
extension PartnerRequirementsVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension PartnerRequirementsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfAge.isFirstResponder {
            return ageData.count
        } else if tfHeight.isFirstResponder {
            return heightDataArr.count
        } else if tfPhysicalStatus.isFirstResponder {
            return physicalStatusArr.count
        } else if tfMaritalStatus.isFirstResponder {
            return getMaritalStatus.count
        } else if tfReligion.isFirstResponder {
            return getReligionData.count
        } else if tfMotherTongue.isFirstResponder {
            return getMotherTongue.count
        } else if tfCaste.isFirstResponder {
            return getCasteData.count
        } else if tfCountryLivingIn.isFirstResponder {
            return getCountryData.count
        } else if tfStateLivingIn.isFirstResponder {
            return getStateData.count
        } else if tfCityLivingIn.isFirstResponder {
            return getCityData.count
        } else if tfEducation.isFirstResponder {
            return educationDataArr.count
        } else if tfOccupation.isFirstResponder {
            return occuptionArr.count
        } else if tfAnnualIncome.isFirstResponder {
            return annualIncomeArr.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // return residentialStatusArr[row]
        if tfAge.isFirstResponder {
            return ageData[row]
        } else if tfHeight.isFirstResponder {
            return heightDataArr[row]
        } else if tfPhysicalStatus.isFirstResponder {
            return physicalStatusArr[row]
        } else if tfMaritalStatus.isFirstResponder {
            return getMaritalStatus[row].name
        } else if tfReligion.isFirstResponder {
            return getReligionData[row].name
        } else if tfMotherTongue.isFirstResponder {
            return getMotherTongue[row].name
        } else if tfCaste.isFirstResponder {
            return getCasteData[row].casteName
        } else if tfCountryLivingIn.isFirstResponder {
            return getCountryData[row].name
        } else if tfStateLivingIn.isFirstResponder {
            return getStateData[row].name
        } else if tfCityLivingIn.isFirstResponder {
            return getCityData[row].name
        } else if tfEducation.isFirstResponder {
            return educationDataArr[row]
        } else if tfOccupation.isFirstResponder {
            return occuptionArr[row]
        } else if tfAnnualIncome.isFirstResponder {
            return annualIncomeArr[row]
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension PartnerRequirementsVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tfAge.isFirstResponder{
            let itemselected = ageData[row]
            tfAge.text = itemselected
        } else if tfHeight.isFirstResponder {
            let stauts = heightDataArr[row]
            tfHeight.text = stauts
        }else if tfMaritalStatus.isFirstResponder {
            let stauts = getMaritalStatus[row].name
            tfMaritalStatus.text = stauts
        }else if tfPhysicalStatus.isFirstResponder {
            let stauts = physicalStatusArr[row]
            tfPhysicalStatus.text = stauts
        }else if tfReligion.isFirstResponder {
            let stauts = getReligionData[row].name
            tfReligion.text = stauts
        }else if tfCaste.isFirstResponder {
            let stauts = getCasteData[row].casteName
            tfCaste.text = stauts
        }else if tfCountryLivingIn.isFirstResponder {
            let stauts = getCountryData[row].name
            self.getCountryID = getCountryData[row].countryID
            apiStateLivingIn()
            tfCountryLivingIn.text = stauts
        }else if tfStateLivingIn.isFirstResponder {
            let stauts = getStateData[row].name
            self.getStateID = getStateData[row].stateID
             apiCityLivingIn()
            tfStateLivingIn.text = stauts
        }else if tfCityLivingIn.isFirstResponder {
            let stauts = getCityData[row].name
            tfCityLivingIn.text = stauts
        }else if tfEducation.isFirstResponder {
            let status = educationDataArr[row]
            tfEducation.text = status
        }else if tfOccupation.isFirstResponder {
            let status = occuptionArr[row]
            tfOccupation.text = status
        }else if tfAnnualIncome.isFirstResponder {
            let status = annualIncomeArr[row]
            tfAnnualIncome.text = status
        }
        
    }
}
//MARK:- Api calling
extension PartnerRequirementsVC {
    //MARK: API Calling for Getting Country Living in
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
        
    //MARK:-API Calling for Getting State Living In
        func apiStateLivingIn() {
        let param: [String: Any] = ["country_id": getCountryID]
         print(param)
            if let getRequest = API.GETSTATE.request(method: .post, with: param, forJsonEncoding: true){
                //Global.showLoadingSpinner()
                getRequest.responseJSON { response in
                    //Global.dismissLoadingSpinner()
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
                            self.getStateData = try decoder.decode([GetStateModel].self, from: jsonData)
                            print(self.getStateData)
                            
                        } catch let err{
                            print("Err", err)
                        }
                        
                    })
                }
            }
        }
        
    //MARK:-API Calling for Getting City Living In
        func apiCityLivingIn() {
        let param: [String: Any] = ["state_id": getStateID]
         print(param)
            if let getRequest = API.GETCITY.request(method: .post, with: param, forJsonEncoding: true){
               // Global.showLoadingSpinner()
                getRequest.responseJSON { response in
                 //   Global.dismissLoadingSpinner()
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
                            self.getCityData = try decoder.decode([GetCityModel].self, from: jsonData)
                            print(self.getCityData)
                            
                        } catch let err{
                            print("Err", err)
                        }
                        
                    })
                }
            }
        }
}
