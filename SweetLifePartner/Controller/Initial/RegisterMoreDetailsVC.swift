//
//  RegisterMoreDetailsVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 20/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class RegisterMoreDetailsVC: UIViewController {
    
    var heightDataArr = ["4.0-4.4","4.4-4.8","4.8-5.2","5.2-5.6","5.6-6.0","6.0-6.4","6.4-6.8","6.8-7.2"]
    var physicalStatusArr = ["Choose One","Normal","Physically Challenged"]
    var educationDataArr = ["Choose One","B.Arch","B.A.","B.A.M.S.","B.B.A.","B.Com.","B.C.A.","B.D.S.","B.Des. / B.D.","B.Ed.","B.E./B.Tech.","BFA / BVA","B.F.Sc./ B.Sc. (Fisheries).","B.H.M.S."," L.L.B.","B.Lib. / B.Lib.Sc."," B.M.C. / B.M.M.","M.B.B.S.","Bachelor of Nursing","B.Pharm / B.Pharma.","B.P.Ed.","B.P.T.","B.Sc.","BSW / B.A. (SW)","B.V.Sc. &amp; A.H. / B.V.Sc","M.D.","M.D. (Homoeopathy)","Pharm.D","Ph.D.","D.M.","M.Arch.","M.A.","M.B.A.","M.Ch.","M.Com.","M.C.A.","M.D.S.","M.Des./ M.Design.","M.Ed.","M.E./ M.Tech.","MFA / MVA","L.L.M.","M.Lib./ M.Lib.Sc.","M.M.C / M.M.M.","M.Pharm","M.Phil","M.P.Ed. / M.P.E.","M.P.T.","M.Sc.","M.S.W. / M.A. (SW)","M.Sc.(Agriculture)","M.S.","M.V.Sc."]
    var employedInArr = ["Government Sector","Private Sector"]
    var occuptionArr = ["Choose One","Chiropractor","Dentist","Dietitian or  Nutritionist","Optometrist","Pharmacist","Physician","Physician Assistant","Podiatrist", "Registered Nurse", "Therapist", "Veterinarian", "Health Technologist or Technician", "Other Healthcare Practitioners and Technical Occupation","Nursing, Psychiatric, or Home Health Aide", "Occupational and Physical Therapist Assistant or Aide", "Other Healthcare Support Occupation","Chief Executive", "General and Operations Manager", "Advertising, Marketing, Promotions, Public Relations, and Sales Manager", "Operations Specialties Manager (e.g., IT or HR Manager)","Construction Manager", "Engineering Manager", "Accountant, Auditor", "Business Operations or Financial Specialist", "Business Owner","Other Business, Executive, Management, Financial Occupation", "Architect, Surveyor, or Cartographer", "Engineer", "Other Architecture and Engineering Occupation","Postsecondary Teacher (e.g., College Professor)", "Primary, Secondary, or Special Education School Teacher", "Other Teacher or Instructor","Other Education, Training, and Library Occupation", "Arts, Design, Entertainment, Sports, and Media Occupation", "Computer Specialist, Mathematical Science","Counselor, Social Worker, or Other Community and Social Service Specialist", "Lawyer,Judge", "Life Scientist (e.g., Animal, Food, Soil, or Biological Scientist, Zoologist)","Physical Scientist (e.g., Astronomer, Physicist, Chemist, Hydrologist)", "Religious Worker(e.g., Clergy, Director of Religious Activities or Education)","Social Scientist and Related Worker","Other Professional Occupation","Supervisor of Administrative Support Workers","Financial Clerk","Secretary or Administrative Assistant","Material Recording, Scheduling, and Dispatching Worker","Other Office and Administrative Support Occupation","Protective Service (e.g., Fire Fighting, Police Officer, Correctional Officer)","Chef or Head Cook","Cook or Food Preparation Worker","Food and Beverage Serving Worker (e.g., Bartender, Waiter, Waitress)","Building and Grounds Cleaning and Maintenance","Personal Care and Service (e.g., Hairdresser, Flight Attendant, Concierge)","Sales Supervisor, Retail Sales","Retail Sales Worker","Insurance Sales Agent","Sales Representative","Real Estate Sales Agent","Other Services Occupation","Construction and Extraction (e.g., Construction Laborer, Electrician)","Farming, Fishing, and Forestry","Installation, Maintenance, and Repair","Production Occupations","Other Agriculture, Maintenance, Repair, and Skilled Crafts Occupation","Aircraft Pilot or Flight Engineer","Motor Vehicle Operator (e.g., Ambulance, Bus, Taxi, or Truck Driver)","Other Transportation Occupation","Military","Homemaker","Other Occupation","Don't Know","Not Applicable"]
    
    var moneyTypeArr = ["INR","USD","Euro"]
    var pickerView : UIPickerView?
    var transparentView = UIView()
    var NumberofCharacter = Int()
    var familyStatusData = [FamilyStatusModel]()
    var familyValuesData = [FamilyValuesModel]()
    var radioValue = "0"
    var param: [String: Any]!
    
    @IBOutlet weak var tfHeightData: UITextField!
    @IBOutlet weak var tfPhysicalStatus: UITextField!
    @IBOutlet weak var tfEducationData: UITextField!
    @IBOutlet weak var tfEmployedIn: UITextField!
    @IBOutlet weak var tfOccupation: UITextField!
    @IBOutlet weak var tfMoneyType: UITextField!
    @IBOutlet weak var tfAnnualIncome: UITextField!
    @IBOutlet weak var tfIncomePerMonth: UILabel!
    @IBOutlet weak var tfFamilyStatus: UITextField!
    @IBOutlet weak var tfFamilyValues: UITextField!
    @IBOutlet var otpVerifyView: UIView!
    @IBOutlet weak var tfOTPEntryField: UITextField!
    @IBOutlet weak var lblCharacterCount: UILabel!
    @IBOutlet weak var tvAboutMyself: UITextView!
    @IBOutlet weak var btnRadioJoint: UIButton!
    @IBOutlet weak var btnRadioNuclear: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfHeightData.text = self.heightDataArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        tfPhysicalStatus.text = self.physicalStatusArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        tfEducationData.text = self.educationDataArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        tfEmployedIn.text = self.employedInArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        tfOccupation.text = self.occuptionArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        tfMoneyType.text = self.moneyTypeArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        setDownImage()
        tvAboutMyself.delegate = self
        PickerViewConnection()
        apiFamilyStatus()
        apiFamilyValues()
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
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Setting The Text Fields Right Image
    func setDownImage() {
        tfHeightData.addImageTo(txtField: tfHeightData, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfPhysicalStatus.addImageTo(txtField: tfPhysicalStatus, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfEducationData.addImageTo(txtField: tfEducationData, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfEmployedIn.addImageTo(txtField:  tfEmployedIn, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfOccupation.addImageTo(txtField:  tfOccupation, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfMoneyType.addImageTo(txtField:  tfMoneyType, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfHeightData.addImageTo(txtField: tfHeightData, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfFamilyStatus.addImageTo(txtField: tfFamilyStatus, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfFamilyValues.addImageTo(txtField: tfFamilyValues, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
       
    }
    
    //MARK:- complete button action
    @IBAction func btnCompletePressed(_ sender: UIButton) {
        
        if Validation.isBlank(for: tfHeightData.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyHeight, alertType: .error)
            return
        } else if Validation.isBlank(for: tfPhysicalStatus.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyPhysicalStatus, alertType: .error)
            return
        } else if Validation.isBlank(for: tfEducationData.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyEducation, alertType: .error)
            return
        } else if Validation.isBlank(for: tfEmployedIn.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyEmployedIn, alertType: .error)
            return
        } else if Validation.isBlank(for: tfOccupation.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyOccupation, alertType: .error)
            return
        } else if Validation.isBlank(for: tfMoneyType.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyCurrencyType, alertType: .error)
            return
        } else if Validation.isBlank(for: tfFamilyStatus.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyFamilyStatus, alertType: .error)
            return
        } else if Validation.isBlank(for: tfFamilyValues.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyFamilyValues, alertType: .error)
            return
        }
    //MARK:-OTP verify page Animation Setup
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        let screen = UIScreen.main.bounds.size
        self.otpVerifyView.frame = CGRect(x: 0, y: screen.height, width: UIScreen.main.bounds.width, height: self.otpVerifyView.height)
        window?.addSubview(self.otpVerifyView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.7
            self.otpVerifyView.frame = CGRect(x: 0, y: screen.height - self.otpVerifyView.height, width: screen.width, height: self.otpVerifyView.height)
        }, completion: nil)
        
    }
    //MARK:- Tap gesture method action
    @objc func onClickTransparentView() {
        let screen = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.otpVerifyView.frame = CGRect(x: 0, y: screen.height, width: screen.width, height: self.otpVerifyView.height)
        }, completion: nil)
        
    }
   //MARK:- To Close Otp Verify Page Btn Action
    @IBAction func btnCancelPressed(_ sender: UIButton) {
        self.otpVerifyView.removeFromSuperview()
        self.transparentView.removeFromSuperview()
    }
    
    
    //MARK:-Action for verify button pressed(otp page)
    @IBAction func btnSubmitPressed(_ sender: UIButton) {
        if sender.tag == 1 {
           
           param["height"] = tfHeightData.text!.trim()
           param["physical_status"] = tfPhysicalStatus.text!.trim()
           param["education"] = tfEducationData.text!.trim()
           param["employeed_in"] = tfEmployedIn.text!.trim()
           param["occupation"] = tfOccupation.text!.trim()
           param["currency_type"] = tfMoneyType.text!.trim()
           param["annual_income"] = tfAnnualIncome.text!.trim()
           param["family_status"] = self.familyStatusData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].familyStatusID
           param["family_type"] = radioValue
           param["family_Values"] = self.familyValuesData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].familyValueID
           param["about_myself"] = tvAboutMyself.text.trim()
           param["otp"] = "\(tfOTPEntryField.text!.trim())"
           apiUserRegister()
            self.otpVerifyView.removeFromSuperview()
            self.transparentView.removeFromSuperview()
          //MARK: Skip Otp Button Action
        } else {
            
            param["height"] = tfHeightData.text!.trim()
            param["physical_status"] = tfPhysicalStatus.text!.trim()
            param["education"] = tfEducationData.text!.trim()
            param["employeed_in"] = tfEmployedIn.text!.trim()
            param["occupation"] = tfOccupation.text!.trim()
            param["currency_type"] = tfMoneyType.text!.trim()
            param["annual_income"] = tfAnnualIncome.text!.trim()
            param["family_status"] = self.familyStatusData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].familyStatusID
            param["family_type"] = radioValue
            param["family_Values"] = self.familyValuesData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].familyValueID
            param["about_myself"] = tvAboutMyself.text.trim()
            param["skip_otp"] = "1"
            apiUserRegister()
             self.otpVerifyView.removeFromSuperview()
             self.transparentView.removeFromSuperview()
             
            
        }
       
        
    }
    //MARK:- UIPickerView Delegates assigning
    func PickerViewConnection() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tfHeightData.delegate = self
        tfPhysicalStatus.delegate = self
        tfEducationData.delegate = self
        tfEmployedIn.delegate = self
        tfOccupation.delegate = self
        tfMoneyType.delegate = self
        tfFamilyStatus.delegate = self
        tfFamilyValues.delegate = self
        
        
        tfHeightData.inputView = pickerView
        tfPhysicalStatus.inputView = pickerView
        tfEducationData.inputView = pickerView
        tfEmployedIn.inputView = pickerView
        tfOccupation.inputView = pickerView
        tfMoneyType.inputView = pickerView
        tfFamilyStatus.inputView = pickerView
        tfFamilyValues.inputView = pickerView
        
        self.pickerView = pickerView
    }
    //MARK:- Resend Otp Button
    @IBAction func btnResendOtpPressed(_ sender: UIButton) {
        
    }
    
//  //MARK:- Skip Otp Button Action
//    @IBAction func btnSkipOtpPresed(_ sender: UIButton) {
//       param["height"] = tfHeightData.text!.trim()
//       param["physical_status"] = tfPhysicalStatus.text!.trim()
//       param["education"] = tfEducationData.text!.trim()
//       param["employeed_in"] = tfEmployedIn.text!.trim()
//       param["occupation"] = tfOccupation.text!.trim()
//       param["currency_type"] = tfMoneyType.text!.trim()
//       param["annual_income"] = tfAnnualIncome.text!.trim()
//       param["family_status"] = self.familyStatusData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].familyStatusID
//       param["family_type"] = radioValue
//       param["family_Values"] = self.familyValuesData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].familyValueID
//       param["about_myself"] = tvAboutMyself.text.trim()
//       param["skip_otp"] = "1"
//       apiUserRegister()
//        self.otpVerifyView.removeFromSuperview()
//        self.transparentView.removeFromSuperview()
//
//    }
    
    
    //MARK:- Family Type Actions
    @IBAction func btnFamilyTypePressed(_ sender: UIButton) {
        
              if sender.tag == 1 {
                   btnRadioJoint.setImage(#imageLiteral(resourceName: "checked_radio_button"), for: .normal)
                   btnRadioNuclear.setImage(#imageLiteral(resourceName: "unchecked_radio_button"), for: .normal)
                   radioValue = "1"
               } else {
                   btnRadioJoint.setImage(#imageLiteral(resourceName: "unchecked_radio_button"), for: .normal)
                   btnRadioNuclear.setImage(#imageLiteral(resourceName: "checked_radio_button"), for: .normal)
                   radioValue = "0"
               }
    }
}

//MARK:-character count functions
extension RegisterMoreDetailsVC: UITextViewDelegate {
    
    func updateCharacterCount() {
        
        let summaryCount = self.tvAboutMyself.text!.count
        NumberofCharacter = summaryCount
        lblCharacterCount.text = "Character Count \((0) + summaryCount)"
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.updateCharacterCount()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if(textView == tvAboutMyself){
            return textView.text.count +  (text.count - range.length) <= 500
        }
        return false
    }
}
//MARK:-UITextField delegates Methods
extension RegisterMoreDetailsVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView?.reloadAllComponents()
        let ammount = Int(tfAnnualIncome.text ?? "")
        tfIncomePerMonth.text = "(\(tfMoneyType.text ?? "") \((ammount ?? 0) / 12) per month)"
    }
}
//MARK:- UIPickerView Datasource Methods
extension RegisterMoreDetailsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfHeightData.isFirstResponder {
            return heightDataArr.count
        }else if tfPhysicalStatus.isFirstResponder {
            return physicalStatusArr.count
        }else if tfEducationData.isFirstResponder {
            return educationDataArr.count
        }else if tfEmployedIn.isFirstResponder {
            return employedInArr.count
        }else if tfOccupation.isFirstResponder {
            return occuptionArr.count
        }else if tfMoneyType.isFirstResponder {
            return moneyTypeArr.count
        }else if tfFamilyStatus.isFirstResponder {
            return familyStatusData.count
        }else if tfFamilyValues.isFirstResponder {
            return familyValuesData.count
        }else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if tfHeightData.isFirstResponder {
            return heightDataArr[row]
        }else if tfPhysicalStatus.isFirstResponder {
            return physicalStatusArr[row]
        }else if tfEducationData.isFirstResponder {
            return educationDataArr[row]
        }else if tfEmployedIn.isFirstResponder {
            return employedInArr[row]
        }else if tfOccupation.isFirstResponder {
            return occuptionArr[row]
        }else if tfMoneyType.isFirstResponder {
            return moneyTypeArr[row]
        }else if tfFamilyStatus.isFirstResponder {
            return familyStatusData[row].name
        }else if tfFamilyValues.isFirstResponder {
            return familyValuesData[row].name
        }else {
            return "Empty"
        }
        
        
    }
    
}
//MARK:- UIViewPicker Datasource Methods
extension RegisterMoreDetailsVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tfHeightData.isFirstResponder{
            let itemselected = heightDataArr[row]
            tfHeightData.text = itemselected
        }else if tfPhysicalStatus.isFirstResponder{
            let itemselected = physicalStatusArr[row]
            tfPhysicalStatus.text = itemselected
        }else if tfEducationData.isFirstResponder{
            let itemselected = educationDataArr[row]
            tfEducationData.text = itemselected
        }else if tfEmployedIn.isFirstResponder{
            let itemselected = employedInArr[row]
            tfEmployedIn.text = itemselected
        }else if tfOccupation.isFirstResponder{
            let itemselected = occuptionArr[row]
            tfOccupation.text = itemselected
        }else if tfMoneyType.isFirstResponder {
            let itemselected = moneyTypeArr[row]
            tfMoneyType.text = itemselected
        }else if tfFamilyStatus.isFirstResponder {
            let itemselected = familyStatusData[row].name
            tfFamilyStatus.text = itemselected
        }else if tfFamilyValues.isFirstResponder {
            let itemselected = familyValuesData[row].name
            tfFamilyValues.text = itemselected
        }
    }
}

//MARK:- API CAlling For Family Status
extension RegisterMoreDetailsVC {
    func apiFamilyStatus() {
        
        if let getRequest = API.FAMILYSTATUS.request(method: .get, with: nil, forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.FAMILYSTATUS.validatedResponse(response, completionHandler: { (jsonObject,error) in
                    guard error == nil else {
                        return
                    }
                    guard let getData = jsonObject?["data"] as? [[String:Any]] else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        self.familyStatusData = try decoder.decode([FamilyStatusModel].self, from: jsonData)
                        if self.familyStatusData.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                            self.tfFamilyStatus.text = self.familyStatusData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                        print(self.familyStatusData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                })
            }
        }
    }
    
    //MARK:- API CAlling For Family Values
    func apiFamilyValues() {
        
        if let getRequest = API.FAMILYVALUES.request(method: .get, with: nil, forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.FAMILYVALUES.validatedResponse(response, completionHandler: { (jsonObject,error) in
                    guard error == nil else {
                        return
                    }
                    guard let getData = jsonObject?["data"] as? [[String:Any]] else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        self.familyValuesData = try decoder.decode([FamilyValuesModel].self, from: jsonData)
                        if self.familyValuesData.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        self.tfFamilyValues.text = self.familyValuesData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                        print(self.familyValuesData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                })
            }
        }
    }
    //MARK:- API CAlling For Registration
    func apiUserRegister() {
        
           if let getRequest = API.SIGNUP.request(method: .post, with: param, forJsonEncoding: false) {
            print(param ?? "")
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
                   Global.dismissLoadingSpinner()
                   API.SIGNUP.validatedResponse(response, completionHandler: { (jsonObject, error) in
                       guard error == nil else {
                           return
                       }
                       guard jsonObject?["status"] as? Int == 1 else {
                       Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                        }
                       Common.showAlertMessage(message: jsonObject?["message"]  as? String ?? "", alertType: .success)

                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MembershipVC") as! MembershipVC
                       vc.param = self.param
                       self.navigationController?.pushViewController(vc, animated: true)
                   })

               }
           }
       }
}

