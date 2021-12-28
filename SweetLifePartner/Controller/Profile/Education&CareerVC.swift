//
//  Education&CareerVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class Education_CareerVC: UIViewController {
    
    @IBOutlet weak var txtHighestQualify: UITextField!
    @IBOutlet weak var txtOccupation: UITextField!
    @IBOutlet weak var txtSchoolCollege: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtCurrency: UITextField!
    @IBOutlet weak var txtAnnualIncome: UITextField!
    
    //MARK:- Properties
    var educationCareer: EducationCareerModel?
    var pickerView : UIPickerView?
    var educationDataArr = ["Choose One","B.Arch", "B.A","B.A.M.S","B.B.A.","B.Com","B.C.A","B.D.S","B.Des.","B.Ed","B.E./B.Tech","BFA/BVA","B.F.Sc./B.Sc.","B.H.M.S.","L.L.B.","B.Lib./B.Lib.Sc","B.M.C./B.M.M.","M.B.B.S.","Bachelor of Nursing","B.Pharm/B.Pharma.","B.P.Ed.","B.P.T.","B.Sc.","BSW/B.A.(SW)","B.V.Sc","M.D", "M.D.(Homoeopathy)","Pharm.D","Ph.D.","D.M.","M.Arch.","M.A.","M.B.A.","M.Ch","M.Com","M.C.A.","M.D.S.","M.Des","M.Ed.","M.E./M.Tech.","MFA/MVA","M.Lib./M.Lib.Sc","M.M.C/M.M.M.","M.Pharm","M.Phil","M.P.Ed","M.P.T.","M.Sc.", "M.S.W./M.A.","M.S.", "M.V.Sc"]
    var occuptionArr = ["Choose One","Chiropractor", "Dentist","Dietitian or Nutritionist","Optometrist","Pharmacist","Physician","Physician Assistant","Podiatrist", "Registered Nurse", "Therapist", "Veterinarian", "Health Technologist or Technician", "Other Healthcare Practitioners and Technical Occupation","Nursing, Psychiatric, or Home Health Aide", "Occupational and Physical Therapist Assistant or Aide", "Other Healthcare Support Occupation","Chief Executive", "General and Operations Manager", "Advertising, Marketing, Promotions, Public Relations, and Sales Manager", "Operations Specialties Manager (e.g., IT or HR Manager)","Construction Manager", "Engineering Manager", "Accountant, Auditor", "Business Operations or Financial Specialist", "Business Owner", "Other Business, Executive, Management, Financial Occupation", "Architect, Surveyor, or Cartographer", "Engineer", "Other Architecture and Engineering Occupation", "Postsecondary Teacher (e.g., College Professor)", "Primary, Secondary, or Special Education School Teacher", "Other Teacher or Instructor", "Other Education, Training, and Library Occupation", "Arts, Design, Entertainment, Sports, and Media Occupation", "Computer Specialist, Mathematical Science","Counselor, Social Worker, or Other Community and Social Service Specialist", "Lawyer,Judge", "Life Scientist (e.g., Animal, Food, Soil, or Biological Scientist, Zoologist)","Physical Scientist (e.g., Astronomer, Physicist, Chemist, Hydrologist)", "Religious Worker(e.g., Clergy, Director of Religious Activities or Education)","Social Scientist and Related Worker","Other Professional Occupation","Supervisor of Administrative Support Workers","Financial Clerk","Secretary or Administrative Assistant","Material Recording, Scheduling, and Dispatching Worker","Other Office and Administrative Support Occupation","Protective Service (e.g., Fire Fighting, Police Officer, Correctional Officer)","Chef or Head Cook","Cook or Food Preparation Worker","Food and Beverage Serving Worker (e.g., Bartender, Waiter, Waitress)","Building and Grounds Cleaning and Maintenance","Personal Care and Service (e.g., Hairdresser, Flight Attendant, Concierge)","Sales Supervisor, Retail Sales","Retail Sales Worker","Insurance Sales Agent", "Sales Representative","Real Estate Sales Agent","Other Services Occupation","Construction and Extraction (e.g., Construction Laborer, Electrician)","Farming, Fishing, and Forestry","Installation, Maintenance, and Repair","Production Occupations","Other Agriculture, Maintenance, Repair, and Skilled Crafts Occupation","Aircraft Pilot or Flight Engineer","Motor Vehicle Operator (e.g., Ambulance, Bus, Taxi, or Truck Driver)","Other Transportation Occupation","Military","Homemaker","Other Occupation","Don't Know","Not Applicable"]
    var currencyArr = ["Choose One", "INR","RUPEE","UED","EUR"]
    var AnnualIncArr = ["Choose One","Below 40K","40K-60K","60K-80Lak","80K-100k","100k-125k","125K-150k","150K-200k","200K and above"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        apiEducationCareer()
        txtHighestQualify.addImageTo(txtField: txtHighestQualify, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtOccupation.addImageTo(txtField: txtOccupation, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtCurrency.addImageTo(txtField: txtCurrency, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtAnnualIncome.addImageTo(txtField: txtAnnualIncome, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        txtHighestQualify.text = self.educationDataArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtOccupation.text = self.occuptionArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtCurrency.text = self.currencyArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtAnnualIncome.text = self.AnnualIncArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
        title = "Education And Career"
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
        
        txtHighestQualify.delegate = self
        txtOccupation.delegate = self
        txtCurrency.delegate = self
        txtAnnualIncome.delegate = self
        
        
        txtHighestQualify.inputView = pickerView
        txtOccupation.inputView = pickerView
        txtCurrency.inputView = pickerView
        txtAnnualIncome.inputView = pickerView
        
        self.pickerView = pickerView
    }
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        
        apiEducationCareerUpdate()
    }
    
}

//MARK:-UITextField delegates Methods
extension Education_CareerVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension Education_CareerVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtHighestQualify.isFirstResponder {
            return educationDataArr.count
        } else if txtOccupation.isFirstResponder {
            return occuptionArr.count
        } else if txtCurrency.isFirstResponder {
            return currencyArr.count
        } else if txtAnnualIncome.isFirstResponder {
            return AnnualIncArr.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtHighestQualify.isFirstResponder {
            return educationDataArr[row]
        } else if txtOccupation.isFirstResponder {
            return occuptionArr[row]
        } else if txtCurrency.isFirstResponder {
            return currencyArr[row]
        } else if txtAnnualIncome.isFirstResponder {
            return AnnualIncArr[row]
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension Education_CareerVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if txtHighestQualify.isFirstResponder {
            let status = educationDataArr[row]
            txtHighestQualify.text = status
        } else if txtOccupation.isFirstResponder {
            let status = occuptionArr[row]
            txtOccupation.text = status
        } else if txtCurrency.isFirstResponder {
            let status = currencyArr[row]
            txtCurrency.text = status
        } else if txtAnnualIncome.isFirstResponder {
            let status = AnnualIncArr[row]
            txtAnnualIncome.text = status
        }
        
    }
}

//MARK:- Api Calling for Education&CareerVC
extension Education_CareerVC {
    func apiEducationCareer() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        // let  param:[String:Any] = ["member_id":id, "highest_education":strHighEducation ?? "", "occupation":strOccuption ?? "", "annual_income":strAnnual ?? ""]
        if let getRequest = API.EDUCATIONCAREER.request(method: .post, with: ["member_id":id], forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.EDUCATIONCAREER.validatedResponse(response, completionHandler: { (jsonObject, error) in
                    guard  error == nil else {
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
                        self.educationCareer = try decoder.decode(EducationCareerModel.self, from: jsonData)
                        print(self.educationCareer ?? "")
                        self.setData()
                    }catch let err {
                        print("Err", err)
                    }
                })
            }
        }
    }
    func setData() {
        txtHighestQualify.text = educationCareer?.highestEducation
        txtOccupation.text = educationCareer?.occupation
        txtSchoolCollege.text = educationCareer?.schoolCollegeName
        txtCompanyName.text = educationCareer?.companyName
        txtCurrency.text = educationCareer?.currency
        txtAnnualIncome.text = educationCareer?.annualIncome
    }
    
    //MARK:- Update Api
    func apiEducationCareerUpdate() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let  param:[String:Any] = ["member_id": id, "highest_education": txtHighestQualify.text?.trim() ?? "" , "occupation": txtOccupation.text?.trim() ?? "" , "annual_income":txtAnnualIncome.text?.trim() ?? "","school_college_name": txtSchoolCollege.text?.trim() ?? "","company_name": txtCompanyName.text?.trim() ?? "", "currency": txtCurrency.text?.trim() ?? "" ]
        if let getRequest = API.UPDATEEDUCATIONCAREER.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.UPDATEEDUCATIONCAREER.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
