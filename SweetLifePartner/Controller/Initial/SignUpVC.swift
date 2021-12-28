//
//  SignUpVC.swift
//  SweetLifePartner
//

import UIKit
import CountryList
//struct OnBehalfModel: Codable {
//    let id, name: String
//}

class SignUpVC: UIViewController {
    
    var date: UIDatePicker?
    var pickerView : UIPickerView?
    var profileFor = [ProfileCreatedForModel]()
    var genderData = ["Male","Female"]
    var getReligion = [ReligionModel]()
    var motherTongue = [MotherTongueModel]()
    var getReligionId = ""
    var countryList = CountryList()
    var gender = "2"
    
    @IBOutlet weak var tfProfileCreatedFor: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfGender: UITextField!
    @IBOutlet weak var tfDateOfBirth: UITextField!
    @IBOutlet weak var tfReligion: UITextField!
    @IBOutlet weak var tfMotherTongue: UITextField!
    @IBOutlet weak var tfCountryCode: UITextField!
    @IBOutlet weak var tfMobileNumber: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tfGender.text = self.genderData[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        setDownImage()
        apiProfileCreatedFor()
        apiReligion()
        setRightImage()
        apiMotherTongue()
        date = UIDatePicker()
        date?.datePickerMode = .date
        date?.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        tfDateOfBirth.inputView = date
        PickerViewConnection()
        countryList.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) , isImage: true)
        let logo = UIImage(named: "logo-white.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        let loginButton: UIBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(login))
        self.navigationItem.rightBarButtonItem = loginButton
        loginButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    //MARK:- Navigation Right button Action
    @objc func login() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- Back Button Action
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- Setting The Text Fields Right Image
    func setDownImage() {
        tfProfileCreatedFor.addImageTo(txtField: tfProfileCreatedFor, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfGender.addImageTo(txtField: tfGender, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfDateOfBirth.addImageTo(txtField: tfDateOfBirth, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfReligion.addImageTo(txtField:  tfReligion, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfMotherTongue.addImageTo(txtField:  tfMotherTongue, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfCountryCode.addImageTo(txtField:  tfCountryCode, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
    }
    //MARK:- Register Button Action
    @IBAction func btnRegisterFreePressed(_ sender: UIButton) {
        
        if Validation.isBlank(for: tfProfileCreatedFor.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyOnbefalf, alertType: .error)
            return
        } else if Validation.isBlank(for: tfFirstName.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyFirstName, alertType: .error)
            return
        } else if Validation.isBlank(for: tfLastName.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyLastName, alertType: .error)
            return
        } else if Validation.isBlank(for: tfGender.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyGender, alertType: .error)
            return
        } else if Validation.isBlank(for: tfDateOfBirth.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyDob, alertType: .error)
            return
        } else  if Validation.isBlank(for: tfReligion.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyReligion, alertType: .error)
            return
        } else  if Validation.isBlank(for: tfMotherTongue.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyMotherTongue, alertType: .error)
            return
        } else  if Validation.isBlank(for: tfCountryCode.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyCountryCode, alertType: .error)
            return
        } else  if Validation.isBlank(for: tfEmail.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyEmail, alertType: .error)
            return
        } else if Validation.isBlank(for: tfMobileNumber.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyTelephone, alertType: .error)
            return
        } else if Validation.isBlank(for: tfPassword.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyPassword, alertType: .error)
            return
        } else if Validation.isBlank(for: tfConfirmPassword.text ?? "") {
            Common.showAlertMessage(message: Messages.emptyConfirmPassword, alertType: .error)
            return
        } else if !Validation.isValidEmail(for: tfEmail.text ?? "") {
            Common.showAlertMessage(message: Messages.invalidEmail, alertType: .error)
            return
        } else if !Validation.isValidMobileNumber(value: tfMobileNumber.text ?? "") {
            Common.showAlertMessage(message: Messages.invalidMobile, alertType: .error)
            return
        } else if !Validation.isValidPassword(for: tfPassword.text ?? "") {
            Common.showAlertMessage(message: Messages.invalidPassword, alertType: .error)
            return
        } else if !Validation.isPasswordMatched(for: tfPassword.text ?? "", for: tfConfirmPassword.text ?? "") {
            Common.showAlertMessage(message: Messages.mismatchPassword, alertType: .error)
            return
        }
        apiCheckEmail()
        var gender = "2"
        if self.tfGender.text!.trim() == "Male" {
          gender = "1"
        }
        let date = convertDateFormater(self.tfDateOfBirth.text!.trim(),"yyyy-MM-dd", "yyyy-MM-dd")
          let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterDetailsVC") as! RegisterDetailsVC
          vc.religionID = getReligionId
         let param: [String: Any] = ["on_behalf": self.profileFor[self.pickerView?.selectedRow(inComponent: 0) ?? 0].id,"first_name":tfFirstName.text!.trim(),"last_name":tfLastName.text!.trim(),"gender":gender,"date_of_birth": date,"get_religion":self.getReligion[self.pickerView?.selectedRow(inComponent: 0) ?? 0].religionID,"mother_tongue":self.motherTongue[self.pickerView?.selectedRow(inComponent: 0) ?? 0].languageID,"country_code":tfCountryCode.text!.trim(),"mobile": tfMobileNumber.text!.trim(),"email":tfEmail.text!.trim(),"password":tfPassword.text!.trim(),"device_type": "ios", "device_token": "token"]
          vc.param = param
        print(param)
          navigationController?.pushViewController(vc, animated: true)
        
    }
    //MARK:- Password field show hide button action
    func setRightImage() {
        
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "passwordhide"), for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        rightButton.frame = CGRect(x: CGFloat(tfPassword.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        tfPassword.rightView = rightButton
        tfPassword.rightViewMode = .always
        rightButton.addTarget(self, action: #selector(ShowHideBtnPressed), for: .touchUpInside)
    }
    //MARK: Show Hide Button In password Field Action
    
    @objc func ShowHideBtnPressed(sender: UIButton!) {
        
        
        if (!self.tfPassword.isSecureTextEntry)
        {
            self.tfPassword.isSecureTextEntry = true
        }
        else
        {
            self.tfPassword.isSecureTextEntry = false
        }
        // self.tfPassword.isFirstResponder
    }
    
    
    //MARK: Date Picker Function
    @objc func dateChange(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        tfDateOfBirth.text = dateFormatter.string(from:datePicker.date)
    }
    
    //MARK:- UIPickerView Delegates assigning
    func PickerViewConnection() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        tfProfileCreatedFor.delegate = self
        tfGender.delegate = self
        tfReligion.delegate = self
        tfMotherTongue.delegate = self
        tfCountryCode.delegate = self
        
        tfProfileCreatedFor.inputView = pickerView
        tfGender.inputView = pickerView
        tfReligion.inputView = pickerView
        tfMotherTongue.inputView = pickerView
        
        self.pickerView = pickerView
    }
    
}
//MARK:-CountryCode delegates Methods
extension SignUpVC: CountryListDelegate {
    func selectedCountry(country: Country) {
        
      //  tfCountryCode.text = "\(country.flag!)   \(country.countryCode) + \(country.phoneExtension)"
        tfCountryCode.text = "+\(country.phoneExtension)"

    }
    
    
}
//MARK:-UITextField delegates Methods
extension SignUpVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfCountryCode {
            let vc = UINavigationController(rootViewController: countryList)
            self.present(vc, animated: true, completion: nil)
        }
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension SignUpVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfProfileCreatedFor.isFirstResponder {
            return profileFor.count
        } else if tfGender.isFirstResponder {
            return genderData.count
        } else if tfReligion.isFirstResponder {
            return getReligion.count
        } else if tfMotherTongue.isFirstResponder {
            return motherTongue.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if tfProfileCreatedFor.isFirstResponder {
            return profileFor[row].name
        } else if tfGender.isFirstResponder {
            return genderData[row]
        } else if tfReligion.isFirstResponder {
            return getReligion[row].name
        } else if tfMotherTongue.isFirstResponder {
            return motherTongue[row].name
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension SignUpVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tfProfileCreatedFor.isFirstResponder {
            let status = profileFor[row].name
            tfProfileCreatedFor.text = status
        } else if tfGender.isFirstResponder {
            let status = genderData[row]
            tfGender.text = status
        } else if tfReligion.isFirstResponder {
            let status = getReligion[row].name
            getReligionId = getReligion[row].religionID
            tfReligion.text = status
        } else if tfMotherTongue.isFirstResponder {
            let status = motherTongue[row].name
            tfMotherTongue.text = status
        }
        
    }
}
//MARK:- Api Calling for profileCreatedFor
extension SignUpVC {
    func apiProfileCreatedFor() {
        if let getRequest = API.PROFILECREATEDFOR.request(method: .get, with: nil, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.PROFILECREATEDFOR.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                        self.profileFor = try decoder.decode([ProfileCreatedForModel].self, from: jsonData)
                        if self.profileFor.count > 0 {
                            self.pickerView?.selectRow(0, inComponent:0, animated: true)
                            self.tfProfileCreatedFor.text = self.profileFor[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                        print(self.profileFor)
                    }catch let err {
                        print("Err", err)
                    }
                })
            }
        }
    }
    
    //MARK: Api Calling for Religion Text Field
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
                        self.getReligion = try decoder.decode([ReligionModel].self, from: jsonData)
                        if self.getReligion.count > 0 {
                            self.pickerView?.selectRow(0, inComponent:0, animated: true)
                            self.tfReligion.text = self.getReligion[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                        print(self.getReligion)
                    }catch let err {
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
                        self.motherTongue = try decoder.decode([MotherTongueModel].self, from: jsonData)
                        if self.motherTongue.count > 0 {
                            self.pickerView?.selectRow(0, inComponent:0, animated: true)
                            self.tfMotherTongue.text = self.motherTongue[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        }
                        print(self.motherTongue)
                    }catch let err {
                        print("Err", err)
                    }
                })
            }
        }
    }
    
    //MARK:- Api Calling for CheckEmail
    func apiCheckEmail() {
        let param: [String : Any] = ["email": tfEmail.text!.trim()]
        if let getRequest = API.CHECKEMAIL.request(method: .post, with: param, forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.CHECKEMAIL.validatedResponse(response, completionHandler: { (jsonObject, error) in
                    guard error == nil else {
                        return
                    }
                    guard jsonObject?["status"] as? Int == 1 else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                    Common.showAlertMessage(message: jsonObject?["message"]  as? String ?? "", alertType: .success)
                     var gender = "2"
                        if self.tfGender.text!.trim() == "Male" {
                          gender = "1"
                        }
                        let date = convertDateFormater(self.tfDateOfBirth.text!.trim(),"yyyy-MM-dd", "yyyy-MM-dd")
                   self.apiUserRegister(gender: gender, onBehalf: self.profileFor[self.pickerView?.selectedRow(inComponent: 0) ?? 0].id, Dob: date)
                })
                
            }
        }
    }
    //MARK:-Api Calling For User Registration
    func apiUserRegister(gender: String, onBehalf: String, Dob: String) {
        let param: [String: Any] = ["on_behalf": onBehalf,"first_name":tfFirstName.text!.trim(),"last_name":tfLastName.text!.trim(),"gender":gender,"date_of_birth": Dob,"get_religion":self.getReligion[self.pickerView?.selectedRow(inComponent: 0) ?? 0].religionID,"mother_tongue":self.motherTongue[self.pickerView?.selectedRow(inComponent: 0) ?? 0].languageID,"country_code":tfCountryCode.text!.trim(),"mobile": tfMobileNumber.text!.trim(),"email":tfEmail.text!.trim(),"password":tfPassword.text!.trim(),"device_type": "ios", "device_token": "token"]

        print(param)
        if let getRequest = API.SIGNUP.request(method: .post, with: param, forJsonEncoding: false) {
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

                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterDetailsVC") as! RegisterDetailsVC
                    vc.religionID = self.getReligionId
                    vc.param = param
                    self.navigationController?.pushViewController(vc, animated: true)
                })

            }
        }
    }
    
}

////MARK:- To Set Footer View Configuration
//extension SignUpVC {
//    func footerConfiguration() {
//        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerView.frame.size.height)
//        tableView.tableFooterView = footerView
//        tableView.tableFooterView?.frame = footerView.frame
//    }
//}



////MARK: Setting TextField Delegates for change in border colour
//extension SignupTableCell : UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//             tfSignupDataInput.layer.borderWidth = 1
//            tfSignupDataInput.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//     }
//
//     func textFieldDidEndEditing(_ textField: UITextField) {
//       tfSignupDataInput.layer.borderWidth = 1
//        tfSignupDataInput.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//     }
//}



//    @IBOutlet weak var txtFirstName: UITextField!
//    @IBOutlet weak var txtLastName: UITextField!
//    @IBOutlet weak var txtGendres: UITextField!
//    @IBOutlet weak var txtEmail: UITextField!
//    @IBOutlet weak var txtDob: UITextField!
//    @IBOutlet weak var txtOnBehalf: UITextField!
//    @IBOutlet weak var txtMobile: UITextField!
//    @IBOutlet weak var txtPassword: UITextField!
//    @IBOutlet weak var txtConfirmPassword: UITextField!


//    let pickerDataGender = ["Male", "Female"]
//    var pickerDataOnBehalf = [OnBehalfModel]()
//
//    let pickerView1 = UIPickerView()
//    let pickerView2 = UIPickerView()
//
//    lazy var datePicker: UIDatePicker = {
//        let picker = UIDatePicker()
//        picker.datePickerMode = .date
//        let date = Calendar.current.date(byAdding: .year, value: -18, to: Date())
//        picker.maximumDate = date
//
//        return picker
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getOnBehalfData()
//        txtFirstName.setLeftMargin()
//        txtLastName.setLeftMargin()
//        txtEmail.setLeftMargin()
//        txtDob.setLeftMargin()
//        txtMobile.setLeftMargin()
//        txtPassword.setLeftMargin()
//        txtConfirmPassword.setLeftMargin()
//        txtGendres.setLeftMargin()
//        txtOnBehalf.setLeftMargin()
//
//        txtDob.delegate = self
//        txtGendres.delegate = self
//        txtOnBehalf.delegate = self
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.navigationBar.isHidden = false
//        setBackButton(tintColor: .black, isImage: true)
//        setNavigationBarImage(for: UIImage(), color: .white)
//        title = "Registration"
//
//    }
//    // uiTextField Delegate//
//
//    override func backBtnTapAction() {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    @IBAction func did_tapSubmit(_ sender: Any) {
//
//        if Validation.isBlank(for: txtFirstName.text ?? "") {
//            Common.showAlertMessage(message: Messages.emptyFirstName, alertType: .error)
//            return
//        } else if Validation.isBlank(for: txtLastName.text ?? "") {
//            Common.showAlertMessage(message: Messages.emptyLastName, alertType: .error)
//            return
//        } else  if Validation.isBlank(for: txtGendres.text ?? "") {
//            Common.showAlertMessage(message: Messages.emptyGender, alertType: .error)
//            return
//        } else  if Validation.isBlank(for: txtEmail.text ?? "") {
//            Common.showAlertMessage(message: Messages.emptyEmail, alertType: .error)
//            return
//        } else  if Validation.isBlank(for: txtDob.text ?? "") {
//            Common.showAlertMessage(message: Messages.emptyDob, alertType: .error)
//            return
//        } else  if Validation.isBlank(for: txtOnBehalf.text ?? "") {
//            Common.showAlertMessage(message: Messages.emptyOnbefalf, alertType: .error)
//            return
//        } else if Validation.isBlank(for: txtMobile.text ?? "") {
//            Common.showAlertMessage(message: Messages.emptyTelephone, alertType: .error)
//            return
//        } else if Validation.isBlank(for: txtPassword.text ?? "") {
//            Common.showAlertMessage(message: Messages.emptyPassword, alertType: .error)
//            return
//        } else if Validation.isBlank(for: txtConfirmPassword.text ?? "") {
//            Common.showAlertMessage(message: Messages.emptyConfirmPassword, alertType: .error)
//            return
//        } else if !Validation.isValidEmail(for: txtEmail.text ?? "") {
//            Common.showAlertMessage(message: Messages.invalidEmail, alertType: .error)
//            return
//        } else if !Validation.isValidMobileNumber(value: txtMobile.text ?? "") {
//            Common.showAlertMessage(message: Messages.invalidMobile, alertType: .error)
//            return
//        } else if !Validation.isValidPassword(for: txtPassword.text ?? "") {
//            Common.showAlertMessage(message: Messages.invalidPassword, alertType: .error)
//            return
//        } else if !Validation.isPasswordMatched(for: txtPassword.text ?? "", for: txtConfirmPassword.text ?? "") {
//            Common.showAlertMessage(message: Messages.mismatchPassword, alertType: .error)
//            return
//        }
//        apiCheckEmail()
//    }
//}
//
////MARK: UITextFieldDelegate
//extension SignUpVC: UITextFieldDelegate {
//    @IBAction func textFieldEditing(_ sender: UITextField) {
//        if sender.tag == 3 {
//            self.pickerView1.delegate = self
//            sender.inputView = pickerView1
//        } else if sender.tag == 5 {
//            sender.inputView = datePicker
//        } else if sender.tag == 7 {
//            self.pickerView2.delegate = self
//            sender.inputView = pickerView2
//        }
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.tag == 3 {
//            let row = self.pickerView1.selectedRow(inComponent: 0)
//            textField.text = self.pickerDataGender[row]
//        } else if textField.tag == 5 {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = DateFormatter.Style.long
//            dateFormatter.timeStyle = DateFormatter.Style.none
//            let date =  dateFormatter.string(from: self.datePicker.date)
//            textField.text = date
//        } else if textField.tag == 7 {
//            let row = self.pickerView2.selectedRow(inComponent: 0)
//            textField.text = self.pickerDataOnBehalf[row].name
//        }
//        return true
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return view.endEditing(true)
//    }
//}
//
////MARK: UIPickerViewDelegate,UIPickerViewDataSource
//extension SignUpVC:UIPickerViewDelegate,UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == self.pickerView1 {
//            return self.pickerDataGender.count
//        } else{
//            return self.pickerDataOnBehalf.count
//        }
//    }
//
//    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView == self.pickerView1{
//            return pickerDataGender[row]
//        } else{
//            return pickerDataOnBehalf[row].name
//        }
//    }
//}
//MARK: API Call
//extension SignUpVC {
//    func getOnBehalfData() {
//        if let getRequest = API.ONBEHALF.request(method: .get, with: nil, forJsonEncoding: true) {
//            Global.showLoadingSpinner()
//            getRequest.responseJSON { (response) in
//                Global.dismissLoadingSpinner()
//                API.ONBEHALF.validatedResponse(response, completionHandler: { (jsonObject, error) in
//                    guard error == nil, let getData = jsonObject?["data"] as? [[String: Any]] else {
//                        return
//                    }
//                    do {
//                        let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
//                        let decoder = JSONDecoder()
//                        self.pickerDataOnBehalf =  try decoder.decode([OnBehalfModel].self, from: jsonData)
//                    } catch let err {
//                        print("Err", err)
//                    }
//                })
//            }
//
//        }
//    }
//
//    func apiCheckEmail() {
//        let param: [String : Any] = ["email": txtEmail.text!.trim()]
//        if let getRequest = API.CHECKEMAIL.request(method: .post, with: param, forJsonEncoding: true) {
//            Global.showLoadingSpinner()
//            getRequest.responseJSON { response in
//                Global.dismissLoadingSpinner()
//                API.CHECKEMAIL.validatedResponse(response, completionHandler: { (jsonObject, error) in
//                    guard error == nil else {
//                        return
//                    }
//                    var gender = "2"
//                    if self.txtGendres.text!.trim() == "Male" {
//                        gender = "1"
//                    }
//                    let date = convertDateFormater(self.txtDob.text!.trim(), "MMMM dd, yyyy", "yyyy-MM-dd")
//                    self.apiUserRegister(gender: gender, onBehalf: self.pickerDataOnBehalf[self.pickerView2.selectedRow(inComponent: 0)].id, Dob: date)
//                })
//
//            }
//        }
//    }
//
//
//    func apiUserRegister(gender: String, onBehalf: String, Dob: String) {
//        let param: [String : Any] = ["first_name": txtFirstName.text!.trim(), "last_name":txtLastName.text!.trim(), "gender": gender, "email": txtEmail.text!.trim(), "date_of_birth": Dob, "mobile": txtMobile.text!.trim(), "on_behalf": onBehalf, "password": txtPassword.text!.trim(), "device_type": "ios", "device_token": "token"]
//
//        if let getRequest = API.SIGNUP.request(method: .post, with: param, forJsonEncoding: true) {
//            Global.showLoadingSpinner()
//            getRequest.responseJSON { response in
//                Global.dismissLoadingSpinner()
//                API.SIGNUP.validatedResponse(response, completionHandler: { (jsonObject, error) in
//                    guard error == nil, let memberId = jsonObject?["member_id"] as? String else {
//                        Common.showAlertMessage(message: "Something went wrong please try again", alertType: .error)
//                        return
//                    }
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
//                    vc.memberId = memberId
//                    self.navigationController?.pushViewController(vc, animated: true)
//                })
//
//            }
//        }
//    }
//}
