//
//  PartnerExpectationVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/03/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PartnerExpectationVC: UIViewController {
    
    var pickerView : UIPickerView?
    var getPartnerExpect : PartnerExpectationModel?
    var getMaritalStatus = [MaritalStatusModel]()
    var getreligionData = [ReligionModel]()
    var religionID = ""
    var getcasteData = [GetCasteModel]()
    var casteID = ""
    var getsubData = [SubCasteModel]()
    var getDecisionData = [DecisionModel]()
    var getmotherTongue = [MotherTongueModel]()
    var getcountryData = [GetCountryModel]()
    var countryID = ""
    var stateData = [GetStateModel]()
    var heightDataArr = ["4.0-4.4","4.4-4.8","4.8-5.2","5.2-5.6","5.6-6.0","6.0-6.4","6.4-6.8","6.8-7.2"]
    var educationDataArr = ["B.Arch","B.A.","B.A.M.S.","B.B.A.","B.Com.","B.C.A.","B.D.S.","B.Des. / B.D.","B.Ed.","B.E./B.Tech.","BFA / BVA","B.F.Sc./ B.Sc. (Fisheries).","B.H.M.S."," L.L.B.","B.Lib. / B.Lib.Sc."," B.M.C. / B.M.M.","M.B.B.S.","Bachelor of Nursing","B.Pharm / B.Pharma.","B.P.Ed.","B.P.T.","B.Sc.","BSW / B.A. (SW)","B.V.Sc. &amp; A.H. / B.V.Sc","M.D.","M.D. (Homoeopathy)","Pharm.D","Ph.D.","D.M.","M.Arch.","M.A.","M.B.A.","M.Ch.","M.Com.","M.C.A.","M.D.S.","M.Des./ M.Design.","M.Ed.","M.E./ M.Tech.","MFA / MVA","L.L.M.","M.Lib./ M.Lib.Sc.","M.M.C / M.M.M.","M.Pharm","M.Phil","M.P.Ed. / M.P.E.","M.P.T.","M.Sc.","M.S.W. / M.A. (SW)","M.Sc.(Agriculture)","M.S.","M.V.Sc."]
    var physicalStatusArr = ["Choose One","Normal","Physically Challenged"]
    var occuptionArr = ["Choose One","Chiropractor","Dentist","Dietitian or  Nutritionist","Optometrist","Pharmacist","Physician","Physician Assistant","Podiatrist", "Registered Nurse", "Therapist", "Veterinarian", "Health Technologist or Technician", "Other Healthcare Practitioners and Technical Occupation","Nursing, Psychiatric, or Home Health Aide", "Occupational and Physical Therapist Assistant or Aide", "Other Healthcare Support Occupation","Chief Executive", "General and Operations Manager", "Advertising, Marketing, Promotions, Public Relations, and Sales Manager", "Operations Specialties Manager (e.g., IT or HR Manager)","Construction Manager", "Engineering Manager", "Accountant, Auditor", "Business Operations or Financial Specialist", "Business Owner","Other Business, Executive, Management, Financial Occupation", "Architect, Surveyor, or Cartographer", "Engineer", "Other Architecture and Engineering Occupation","Postsecondary Teacher (e.g., College Professor)", "Primary, Secondary, or Special Education School Teacher", "Other Teacher or Instructor","Other Education, Training, and Library Occupation", "Arts, Design, Entertainment, Sports, and Media Occupation", "Computer Specialist, Mathematical Science","Counselor, Social Worker, or Other Community and Social Service Specialist", "Lawyer,Judge", "Life Scientist (e.g., Animal, Food, Soil, or Biological Scientist, Zoologist)","Physical Scientist (e.g., Astronomer, Physicist, Chemist, Hydrologist)", "Religious Worker(e.g., Clergy, Director of Religious Activities or Education)","Social Scientist and Related Worker","Other Professional Occupation","Supervisor of Administrative Support Workers","Financial Clerk","Secretary or Administrative Assistant","Material Recording, Scheduling, and Dispatching Worker","Other Office and Administrative Support Occupation","Protective Service (e.g., Fire Fighting, Police Officer, Correctional Officer)","Chef or Head Cook","Cook or Food Preparation Worker","Food and Beverage Serving Worker (e.g., Bartender, Waiter, Waitress)","Building and Grounds Cleaning and Maintenance","Personal Care and Service (e.g., Hairdresser, Flight Attendant, Concierge)","Sales Supervisor, Retail Sales","Retail Sales Worker","Insurance Sales Agent","Sales Representative","Real Estate Sales Agent","Other Services Occupation","Construction and Extraction (e.g., Construction Laborer, Electrician)","Farming, Fishing, and Forestry","Installation, Maintenance, and Repair","Production Occupations","Other Agriculture, Maintenance, Repair, and Skilled Crafts Occupation","Aircraft Pilot or Flight Engineer","Motor Vehicle Operator (e.g., Ambulance, Bus, Taxi, or Truck Driver)","Other Transportation Occupation","Military","Homemaker","Other Occupation","Don't Know","Not Applicable"]
    var AnnualIncArr = ["Choose One","Below 40K","40K-60K","60K-80Lak","80K-100k","100k-125k","125K-150k","150K-200k","200K and above"]
    var ageArr = ["Choose one","45-50","50-55","55-60","60-65","65-70","70-75"]
    
    
    
    
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtMaritalStatus: UITextField!
    @IBOutlet weak var txtBodyType: UITextField!
    @IBOutlet weak var txtPartnerComp: UITextField!
    @IBOutlet weak var txtPhysicalStatus: UITextField!
    @IBOutlet weak var txtPartnerDrinking: UITextField!
    @IBOutlet weak var txtPartnerSmoking: UITextField!
    @IBOutlet weak var txtPartnerDiet: UITextField!
    @IBOutlet weak var txtReligion: UITextField!
    @IBOutlet weak var txtCaste: UITextField!
    @IBOutlet weak var txtManglik: UITextField!
    @IBOutlet weak var txtMotherTongue: UITextField!
    @IBOutlet weak var txtEduction: UITextField!
    @IBOutlet weak var txtOccupation: UITextField!
    @IBOutlet weak var txtAnnualIncome: UITextField!
    @IBOutlet weak var txtPreferedCountry: UITextField!
    @IBOutlet weak var txtPreferedState: UITextField!
    @IBOutlet weak var lblEducation: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDownImage()
        setText()
        PickerViewConnection()
        stringColourChange()
        apiReligion()
        apiMotherTongue()
        apiMaritalStatus()
        apiCountryLivingIn()
        apigetDecision()
        apiPartnerPref()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
        title = "PARTNER EXPECTATION"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Setting The Text Fields Right Image
       func setDownImage() {
           txtAge.addImageTo(txtField: txtAge, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtHeight.addImageTo(txtField: txtHeight, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtMaritalStatus.addImageTo(txtField: txtMaritalStatus, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtPhysicalStatus.addImageTo(txtField:  txtPhysicalStatus, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtPartnerDrinking.addImageTo(txtField:  txtPartnerDrinking, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtPartnerSmoking.addImageTo(txtField:  txtPartnerSmoking, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtReligion.addImageTo(txtField: txtReligion, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtCaste.addImageTo(txtField: txtCaste, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtManglik.addImageTo(txtField: txtManglik, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtMotherTongue.addImageTo(txtField: txtMotherTongue, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtEduction.addImageTo(txtField: txtEduction, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtOccupation.addImageTo(txtField: txtOccupation, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtAnnualIncome.addImageTo(txtField:  txtAnnualIncome, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtPreferedCountry.addImageTo(txtField:  txtPreferedCountry, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
           txtPreferedState.addImageTo(txtField:  txtPreferedState, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
          
       }
    //MARK:- Setting The Text Fields initial values
    func setText() {
        txtAge.text = self.ageArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtHeight.text = self.heightDataArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtPhysicalStatus.text = self.physicalStatusArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtEduction.text = self.educationDataArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtAnnualIncome.text = self.AnnualIncArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        txtOccupation.text = self.occuptionArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        
    }
    
  //MARK:-Setting Multiple Colour for Labels
    func stringColourChange() {
        //MARK: label Setting For Education Field
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "Century Gothic", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)]
        let attrString = NSAttributedString(string: "Education:", attributes: multipleAttributes)
        
        let multipleAttributes1: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "Century Gothic", size: 16) ?? UIFont.systemFont(ofSize: 14, weight: .regular)]
        let attrString1 = NSAttributedString(string: "- B.Sc IT/Computer Science", attributes: multipleAttributes1)
        
        let mergedAttrubutedString = NSMutableAttributedString()
        mergedAttrubutedString.append(attrString)
        mergedAttrubutedString.append(attrString1)
        
        lblEducation.attributedText = mergedAttrubutedString
        //MARK: label Setting For Occupation Field
        let multipleAttributes2: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "Century Gothic", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)]
        let attrString2 = NSAttributedString(string: "Occupation:", attributes: multipleAttributes2)
        
        let multipleAttributes3: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "Century Gothic", size: 16) ?? UIFont.systemFont(ofSize: 14, weight: .regular)]
        let attrString3 = NSAttributedString(string: "- Business Owner / Entrepreneur", attributes: multipleAttributes3)
        
        let mergedAttrubutedString1 = NSMutableAttributedString()
        mergedAttrubutedString1.append(attrString2)
        mergedAttrubutedString1.append(attrString3)
        
        lblOccupation.attributedText = mergedAttrubutedString1
    }
    
    //MARK:- UIPickerView Delegates assigning
    func PickerViewConnection() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
     
        txtAge.delegate = self
        txtHeight.delegate = self
        txtMaritalStatus.delegate = self
        txtPhysicalStatus.delegate = self
        txtPartnerDrinking.delegate = self
        txtPartnerSmoking.delegate = self
        txtReligion.delegate = self
        txtCaste.delegate = self
        txtManglik.delegate = self
        txtMotherTongue.delegate = self
        txtEduction.delegate = self
        txtOccupation.delegate = self
        txtAnnualIncome.delegate = self
        txtPreferedCountry.delegate = self
        txtPreferedState.delegate = self

        txtAge.inputView = pickerView
        txtHeight.inputView = pickerView
        txtMaritalStatus.inputView = pickerView
        txtPhysicalStatus.inputView = pickerView
        txtPartnerDrinking.inputView = pickerView
        txtPartnerSmoking.inputView = pickerView
        txtReligion.inputView = pickerView
        txtCaste.inputView = pickerView
        txtManglik.inputView = pickerView
        txtMotherTongue.inputView = pickerView
        txtEduction.inputView = pickerView
        txtOccupation.inputView = pickerView
        txtAnnualIncome.inputView = pickerView
        txtPreferedCountry.inputView = pickerView
        txtPreferedState.inputView = pickerView
       
        
        self.pickerView = pickerView
    }
    
    //MARK: Action For Update Button Pressed
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        apiPartnerPrefUpdate()
    }
    
}

//MARK:-UITextField delegates Methods
extension PartnerExpectationVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension PartnerExpectationVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if txtAge.isFirstResponder {
            return ageArr.count
        } else if txtHeight.isFirstResponder {
            return heightDataArr.count
        } else if txtMaritalStatus.isFirstResponder {
            return getMaritalStatus.count
        } else if txtPhysicalStatus.isFirstResponder {
            return physicalStatusArr.count
        } else if txtPartnerDrinking.isFirstResponder {
            return getDecisionData.count
        }  else if txtPartnerSmoking.isFirstResponder {
            return getDecisionData.count
        } else if txtReligion.isFirstResponder {
            return getreligionData.count
        } else if txtCaste.isFirstResponder {
            return getcasteData.count
        } else if txtManglik.isFirstResponder {
            return getDecisionData.count
        } else if txtMotherTongue.isFirstResponder {
            return getmotherTongue.count
        } else if txtEduction.isFirstResponder {
            return educationDataArr.count
        } else if txtOccupation.isFirstResponder {
            return occuptionArr.count
        } else if txtAnnualIncome.isFirstResponder {
            return AnnualIncArr.count
        } else if txtPreferedCountry.isFirstResponder {
            return getcountryData.count
        } else if txtPreferedState.isFirstResponder {
            return stateData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtAge.isFirstResponder {
            return ageArr[row]
        } else if txtHeight.isFirstResponder {
            return heightDataArr[row]
        } else if txtMaritalStatus.isFirstResponder {
            return getMaritalStatus[row].name
        } else if txtPhysicalStatus.isFirstResponder {
            return physicalStatusArr[row]
        } else if txtPartnerDrinking.isFirstResponder {
            return getDecisionData[row].name
        }  else if txtPartnerSmoking.isFirstResponder {
            return getDecisionData[row].name
        } else if txtReligion.isFirstResponder {
            return getreligionData[row].name
        } else if txtCaste.isFirstResponder {
            return getcasteData[row].casteName
        } else if txtManglik.isFirstResponder {
            return getDecisionData[row].name
        } else if txtMotherTongue.isFirstResponder {
            return getmotherTongue[row].name
        } else if txtEduction.isFirstResponder {
            return educationDataArr[row]
        } else if txtOccupation.isFirstResponder {
            return occuptionArr[row]
        } else if txtAnnualIncome.isFirstResponder {
            return AnnualIncArr[row]
        } else if txtPreferedCountry.isFirstResponder {
            return getcountryData[row].name
        } else if txtPreferedState.isFirstResponder {
            return stateData[row].name
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension PartnerExpectationVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if txtAge.isFirstResponder {
            let status = ageArr[row]
            txtAge.text = status
        } else if txtHeight.isFirstResponder {
            let status = heightDataArr[row]
            txtHeight.text = status
        } else if txtMaritalStatus.isFirstResponder {
             let status = getMaritalStatus[row].name
             txtMaritalStatus.text = status
        } else if txtPhysicalStatus.isFirstResponder {
            let status = physicalStatusArr[row]
            txtPhysicalStatus.text = status
        } else if txtPartnerDrinking.isFirstResponder {
            let status = getDecisionData[row].name
            txtPartnerDrinking.text = status
        } else if txtPartnerSmoking.isFirstResponder {
            let status = getDecisionData[row].name
            txtPartnerSmoking.text = status
        } else if txtReligion.isFirstResponder {
            let status = getreligionData[row].name
            self.religionID = getreligionData[row].religionID
            apiCaste()
            txtReligion.text = status
        } else if txtCaste.isFirstResponder {
            let status = getcasteData[row].casteName
            self.casteID = getcasteData[row].casteID
            txtCaste.text = status
        } else if txtManglik.isFirstResponder {
            let status = getDecisionData[row].name
            txtManglik.text = status
        } else if txtMotherTongue.isFirstResponder {
            let status = getmotherTongue[row].name
            txtMotherTongue.text = status
        } else if txtEduction.isFirstResponder {
            let status = educationDataArr[row]
            txtEduction.text = status
        } else if txtOccupation.isFirstResponder {
            let status = occuptionArr[row]
            txtOccupation.text = status
        } else if txtAnnualIncome.isFirstResponder {
            let status = AnnualIncArr[row]
            txtAnnualIncome.text = status
        } else if txtPreferedCountry.isFirstResponder {
            let status = getcountryData[row].name
            self.countryID = getcountryData[row].countryID
            apiStateLivingIn()
            txtPreferedCountry.text = status
        } else if txtPreferedState.isFirstResponder {
            let status = stateData[row].name
            txtPreferedState.text = status
        }
    }
}
//MARK:-API Calling for Getting Religion Data
extension PartnerExpectationVC {
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
                         self.getreligionData = try decoder.decode([ReligionModel].self, from: jsonData)
                        if self.getreligionData.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        self.txtReligion.text = self.getreligionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                         print(self.getreligionData)
                     }catch let err {
                         print("Err", err)
                     }
                 })
             }
         }
     }
//MARK:-API Calling for Getting Marital Status
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
                        self.getMaritalStatus = try decoder.decode([MaritalStatusModel].self, from: jsonData)
                        if self.getMaritalStatus.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        self.txtMaritalStatus.text = self.getMaritalStatus[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                                               }
                        print(self.getMaritalStatus)
                        
                    } catch let err{
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
       // Global.showLoadingSpinner()
        getRequest.responseJSON { response in
           // Global.dismissLoadingSpinner()
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
                    self.getcasteData = try decoder.decode([GetCasteModel].self, from: jsonData)
                    if self.getcasteData.count > 0 {
                    self.pickerView?.selectRow(0, inComponent:0, animated: true)
                    self.txtCaste.text = self.getcasteData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].casteName
                    }
                    print(self.getcasteData)
                    
                } catch let err{
                    print("Err", err)
                }
                
            })
        }
      }
    }
    
//MARK: Api Calling for MotherTongue Text Field
       func apiMotherTongue() {
           if let getRequest = API.MOTHERTONGUE.request(method: .get, with: nil, forJsonEncoding: true){
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
                   Global.dismissLoadingSpinner()
                   API.MOTHERTONGUE.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                           self.getmotherTongue = try decoder.decode([MotherTongueModel].self, from: jsonData)
                        if self.getmotherTongue.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        self.txtMotherTongue.text = self.getmotherTongue[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                           print(self.getmotherTongue)
                       }catch let err {
                           print("Err", err)
                       }
                   })
               }
           }
       }
    //MARK:-API Calling for Getting Country Living in
       func apigetDecision() {
           
           if let getRequest = API.DECISION.request(method: .get, with: nil, forJsonEncoding: true){
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
                   Global.dismissLoadingSpinner()
                   API.DECISION.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                           self.getDecisionData = try decoder.decode([DecisionModel].self, from: jsonData)
                           if self.getDecisionData.count > 0 {
                           self.pickerView?.selectRow(0, inComponent:0, animated: true)
                           self.txtPartnerDrinking.text = self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                           self.txtPartnerSmoking.text = self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                           self.txtManglik.text = self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                           }
                          print(self.getDecisionData)
                       } catch let err{
                           print("Err", err)
                       }
                       
                   })
               }
           }
           
       }
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
                        if self.getcountryData.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                            self.txtPreferedCountry.text = self.getcountryData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
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
                        if self.stateData.count > 0 {
                        self.pickerView?.selectRow(0, inComponent:0, animated: true)
                            self.txtPreferedState.text = self.stateData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                        print(self.stateData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
    }
    
//MARK:-api CAlling for Partner Expectation
        func apiPartnerPref() {
               guard let id = MemberModel.getMemberModel()?.memberID else {
                   return
               }
               if let getRequest = API.PARTNEREXPECTATION.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
                   Global.showLoadingSpinner()
                   getRequest.responseJSON { response in
                   Global.dismissLoadingSpinner()
                       API.PARTNEREXPECTATION.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                               self.getPartnerExpect = try decoder.decode(PartnerExpectationModel.self, from: jsonData)
                               print(self.getPartnerExpect ?? "")
                               self.setPartnerExpectData()
                            }  catch let err {
                                  print("Err", err)
                              }
                       })
                   }
                   
               }
           }
        func setPartnerExpectData() {
           txtAge.text = getPartnerExpect?.partnerAge
           txtHeight.text = getPartnerExpect?.partnerHeight
           txtMaritalStatus.text = getPartnerExpect?.partnerMaritalStatus
           txtPhysicalStatus.text = getPartnerExpect?.partnerPhysicalStatus
           txtPartnerDrinking.text = getPartnerExpect?.partnerDrink
           txtPartnerSmoking.text = getPartnerExpect?.partnerSmoke
           txtReligion.text = getPartnerExpect?.partnerReligion
           txtCaste.text = getPartnerExpect?.partnerCaste
           txtManglik.text = getPartnerExpect?.manglik
            txtMotherTongue.text = getPartnerExpect?.partnerMotherTongue
           txtEduction.text = getPartnerExpect?.partnerEducation
           txtOccupation.text = getPartnerExpect?.partnerProfession
            txtAnnualIncome.text = getPartnerExpect?.partnerAnnualIncome
           txtPreferedCountry.text = getPartnerExpect?.preferedCountry
           txtPreferedState.text = getPartnerExpect?.preferedState
            txtBodyType.text = getPartnerExpect?.partnerBodyType
            txtPartnerComp.text = getPartnerExpect?.partnerComplexion
            txtPartnerDiet.text = getPartnerExpect?.partnerDiet
           }
    //MARK:- calling Update Api for Partner Expectation
        func apiPartnerPrefUpdate() {
              guard let id = MemberModel.getMemberModel()?.memberID else {
                  return
              }
            let  param:[String:Any] = ["member_id":id,"partner_age":txtAge.text?.trim() ?? "", "partner_height": txtHeight.text?.trim() ?? "", "partner_marital_status":self.getMaritalStatus[self.pickerView?.selectedRow(inComponent: 0) ?? 0].id, "partner_physical_status":txtPhysicalStatus.text?.trim() ?? "","partner_body_type":txtBodyType.text?.trim() ?? "","partner_complexion":txtPartnerComp.text?.trim() ?? "","partner_drink":self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].decisionID,"partner_religion":self.getreligionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].religionID,"partner_caste":self.getcasteData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].casteID,"partner_diet":txtPartnerDiet.text?.trim() ?? "","partner_smoke":self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].decisionID,"partner_education":txtEduction.text?.trim() ?? "","partner_profession":txtOccupation.text?.trim() ?? "","partner_annual_income":txtAnnualIncome.text?.trim() ?? "","partner_mother_tongue":self.getmotherTongue[self.pickerView?.selectedRow(inComponent: 0) ?? 0].languageID,"manglik":self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].decisionID,"prefered_country":self.getcountryData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].countryID,"prefered_state":self.stateData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].stateID]
            print(param)
              if let getRequest = API.UPDATEPARTNEREXPECTATION.request(method: .post, with: param, forJsonEncoding: true){
                  Global.showLoadingSpinner()
                  getRequest.responseJSON { response in
                      Global.dismissLoadingSpinner()
                      API.UPDATEPARTNEREXPECTATION.validatedResponse(response, completionHandler: { (jsonObject, error) in
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


