//
//  EditProfileVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit


class EditProfileVC: BaseImagePicker {
    
    //var sections: [String] = ["My Profile","Setting"]
    
    var section0placeHolder : [String] = ["First Name","Last Name","DOB","Email Id","Phone Number","Gender","On Behalf Of","Marital Status","Number Of Children"]
    var imgArry = [#imageLiteral(resourceName: "Name"),#imageLiteral(resourceName: "Name"),#imageLiteral(resourceName: "calendar"),#imageLiteral(resourceName: "Mail"),#imageLiteral(resourceName: "Call"),#imageLiteral(resourceName: "Male"),#imageLiteral(resourceName: "Self"),#imageLiteral(resourceName: "Family-Information"),#imageLiteral(resourceName: "Physical_Attributes")]
    var image: UIImage?
    
    var section0Images :  [String] = ["facebook","facebook","facebook","calendar","facebook","facebook","facebook"]
    
    var section1Titles : [String] = ["Education And Career","Physical Attributes", "Language","Hobbies And Interests","Residency Information","Spiritual And Social Background","Life Style","Present Address","Family Information","Partner Expectation"]
    
    var section1Images :  [String] = ["Education-And-Career","Physical_Attributes","Language","Hobbies-And-Interests","residentional-information","Astronomic-Information","life-style","parmanent-address","Family-Information","Partner-Preference"]
    var section0Titles : [String] = ["","","","","","","","",""]
    
    var genderData = ["Male","Female"]
    var profileFor = [ProfileCreatedForModel]()
    var getMaritalStatus = [MaritalStatusModel]()
    var MyIndex = 0
    var pickerView  = UIPickerView()
    var pickerView1  = UIPickerView()
    var pickerView2   = UIPickerView()
    
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImg: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiMaritalStatus()
        apiProfileCreatedFor()
        PickerViewConnection()
        headerConfiguration()
        if let url = URL(string: MemberModel.getMemberModel()?.profileImage ?? "" ) {
            profileImg.imageView?.af_setImage(withURL: url)
        } else {
            profileImg.imageView?.image = #imageLiteral(resourceName: "screen")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton;
        let updateButton: UIBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(update))
        self.navigationItem.rightBarButtonItem = updateButton;
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        super.viewWillAppear(animated);
        title = "Profile"
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func update() {
        uploadImage()
    }
    
    //MARK:- UIPickerView Delegates assigning
    func PickerViewConnection() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
    }
    
    @IBAction func btnEditImagePressed(_ sender: UIButton) {
        openOptions()
    }
    override func selectedImage(chooseImage: UIImage) {
        image = chooseImage
        profileImg.setImage(image, for: .normal)
    }
}

//MARK: UITextFieldDelegate
extension EditProfileVC: UITextFieldDelegate {
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 5 {
            let index5 = IndexPath(row: 5, section: 0)
            let motherTongueCell = tableView.cellForRow(at: index5)! as! MyProfileCell
            motherTongueCell.tfMyProfileInputs.inputView = pickerView
            self.pickerView.reloadAllComponents()
            
        }else if textField.tag == 6 {
            let index6 = IndexPath(row: 6, section: 0)
            let languageCell = tableView.cellForRow(at: index6)! as! MyProfileCell
            languageCell.tfMyProfileInputs.inputView = pickerView1
            self.pickerView2.reloadAllComponents()
            
        }else if textField.tag == 7 {
            let index7 = IndexPath(row: 7, section: 0)
            let speakCell = tableView.cellForRow(at: index7)! as! MyProfileCell
            speakCell.tfMyProfileInputs.inputView = pickerView2
            self.pickerView2.reloadAllComponents()
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            self.section0Titles[0] = textField.text?.trim() ?? ""
        } else if textField.tag == 1 {
            self.section0Titles[1] = textField.text?.trim() ?? ""
        } else if textField.tag == 2 {
            self.section0Titles[2] = textField.text?.trim() ?? ""
        } else if textField.tag == 3 {
            self.section0Titles[3] = textField.text?.trim() ?? ""
        } else if textField.tag == 4 {
            self.section0Titles[4] = textField.text?.trim() ?? ""
        } else if textField.tag == 5 {
            self.section0Titles[5] = textField.text?.trim() ?? ""
        } else if textField.tag == 6 {
            self.section0Titles[6] = textField.text?.trim() ?? ""
        } else if textField.tag == 7 {
            self.section0Titles[7] = textField.text?.trim() ?? ""
        } else if textField.tag == 8 {
            self.section0Titles[8] = textField.text?.trim() ?? ""
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

//MARK:- TableView DataSource Methods
extension EditProfileVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section0placeHolder.count
        }else {
            return section1Titles.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileCell") as! MyProfileCell
            let data = MemberModel.getMemberModel()
            cell.tfMyProfileInputs.addLeftImageTo(txtField: cell.tfMyProfileInputs, andImage: imgArry[indexPath.row])
            cell.tfMyProfileInputs.tag = indexPath.row
            cell.tfMyProfileInputs.delegate = self
            cell.tfMyProfileInputs.placeholder = section0placeHolder[indexPath.row]
            //cell.tfMyProfileInputs.addImageTo(txtField: cell.tfMyProfileInputs, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
            switch indexPath.row {
            case 0:
                cell.tfMyProfileInputs.text = data?.firstName
            case 1:
                cell.tfMyProfileInputs.text = data?.lastName
            case 2:
                cell.tfMyProfileInputs.text = data?.dateOfBirth
            case 3:
                cell.tfMyProfileInputs.text = data?.email
            case 4:
                cell.tfMyProfileInputs.text = data?.mobile
            case 5:
                if data?.gender == "1" {
                    cell.tfMyProfileInputs.text = "Male"
                }else {
                    cell.tfMyProfileInputs.text = "Female"
                }
                cell.tfMyProfileInputs.addImageTo(txtField: cell.tfMyProfileInputs, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
            case 6:
                if data?.onBehalf == "1" {
                    cell.tfMyProfileInputs.text = "Self"
                } else if data?.onBehalf == "2" {
                    cell.tfMyProfileInputs.text = "Daughter/Son"
                }
                cell.tfMyProfileInputs.addImageTo(txtField: cell.tfMyProfileInputs, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
            case 7:
                cell.tfMyProfileInputs.addImageTo(txtField: cell.tfMyProfileInputs, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
            case 8:
                cell.tfMyProfileInputs.text = "Number Of Children"
            default:
                break
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingEditProfileCell", for: indexPath) as! SettingEditProfileCell
            
            cell.lblSettingName.text = section1Titles[indexPath.row]
            cell.lblSettingName.isEnabled = false
            cell.accessoryType = .disclosureIndicator
            cell.imgSettingLogo.image = UIImage(named: section1Images[indexPath.row])
            return cell
        }
        
    }
}
//MARK:- To Set The header View Configuration
extension EditProfileVC {
    func headerConfiguration() {
        
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 160)
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.frame = headerView.frame
    }
}
//MARK:- TableView Delegates Methods
extension EditProfileVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        if indexPath.section == 1 {
            MyIndex = indexPath.row
            switch MyIndex {
            case 0:
                let vc = storyboard?.instantiateViewController(withIdentifier: "Education_CareerVC") as! Education_CareerVC
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = storyboard?.instantiateViewController(withIdentifier: "PhysicalAttributesVC") as! PhysicalAttributesVC
                navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
                navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = storyboard?.instantiateViewController(withIdentifier: "Hobbies_InterestVC") as! Hobbies_InterestVC
                navigationController?.pushViewController(vc, animated: true)
            case 4:
                let vc = storyboard?.instantiateViewController(withIdentifier: "ResidencyInfoVC") as! ResidencyInfoVC
                navigationController?.pushViewController(vc, animated: true)
            case 5:
                let vc = storyboard?.instantiateViewController(withIdentifier: "Spiritual_SocialVC") as! Spiritual_SocialVC
                navigationController?.pushViewController(vc, animated: true)
            case 6:
                let vc = storyboard?.instantiateViewController(withIdentifier: "LifeStyleVC") as! LifeStyleVC
                navigationController?.pushViewController(vc, animated: true)
            case 7:
                let vc = storyboard?.instantiateViewController(withIdentifier: "PermanentAddVC") as! PermanentAddVC
                navigationController?.pushViewController(vc, animated: true)
            case 8:
                let vc = storyboard?.instantiateViewController(withIdentifier: "FamilyInfoVC") as! FamilyInfoVC
                navigationController?.pushViewController(vc, animated: true)
            case 9:
                let vc = storyboard?.instantiateViewController(withIdentifier: "PartnerExpectationVC") as! PartnerExpectationVC
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "My Profile"
        } else {
            return "Settings"
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARRK: Upload image Api
extension EditProfileVC {
    
    func uploadImage()  {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let gender = MemberModel.getMemberModel()?.gender
        let onBehalf = MemberModel.getMemberModel()?.onBehalf
    
        let param: [String: Any] = ["member_id": id,"first_name": section0Titles[0],"last_name": section0Titles[1],"email": section0Titles[3] ,"mobile": section0Titles[4] ,"gender": gender ?? "" ,"on_behalf": onBehalf ?? "" ,"date_of_birth": section0Titles[2] ,"marital_status": self.getMaritalStatus[self.pickerView2.selectedRow(inComponent: 0)].id ,"number_of_children": section0Titles[8]]
         API.UPADTEPROFILE.requestUpload( with: param, files: ["profile_image": self.profileImg.imageView?.image ?? ""]) { (jsonObject, error) in
            guard error == nil, (jsonObject?["status"] as! Bool ) else {
                Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                return
            }
            Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
            self.tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

//MARK:- Table View Cell Classes
class MyProfileCell: UITableViewCell {
    
    // var imgArry = [#imageLiteral(resourceName: "right_check"),#imageLiteral(resourceName: "right_check"),#imageLiteral(resourceName: "premium-star"),#imageLiteral(resourceName: "reminder"),#imageLiteral(resourceName: "facebook"),#imageLiteral(resourceName: "view-contact"),#imageLiteral(resourceName: "wirte-message")]
    var section0Images :  [String] = ["fb_setting","instagram","world","calendar","bug","speech","signing","padlock","fb_setting","instagram","world","premium","bug"]
    @IBOutlet weak var tfMyProfileInputs: UITextField!
    
    override class func awakeFromNib() {
        
    }
}

class SettingEditProfileCell: UITableViewCell {
    
    @IBOutlet weak var imgSettingLogo: UIImageView!
    @IBOutlet weak var lblSettingName: UILabel!
    
}

//MARK:- Uipicker DataSource Method
extension EditProfileVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerView {
            return genderData.count
        } else if pickerView == pickerView1 {
            return profileFor.count
        } else if pickerView == pickerView2 {
            return getMaritalStatus.count
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.pickerView {
            return genderData[row]
        } else if pickerView == pickerView1 {
            return profileFor[row].name
        } else if pickerView == pickerView2 {
            return getMaritalStatus[row].name
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension EditProfileVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.pickerView {
            let index5 = IndexPath(row: 5 , section: 0)
            let motherTongueCell = tableView.cellForRow(at: index5)! as! MyProfileCell
            motherTongueCell.tfMyProfileInputs.text = genderData[row]
            
        } else if pickerView == pickerView1 {
            let index6 = IndexPath(row: 6 , section: 0)
            let languageCell = tableView.cellForRow(at: index6)! as! MyProfileCell
            languageCell.tfMyProfileInputs.text = profileFor[row].name
            
        } else if pickerView == pickerView2 {
            let index7 = IndexPath(row: 7, section: 0)
            let speakCell = tableView.cellForRow(at: index7)! as! MyProfileCell
            speakCell.tfMyProfileInputs.text = getMaritalStatus[row].name
            
        }
    }
}

//MARK:-API Calling for Getting MaritalStatus
extension EditProfileVC {
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
                        //                        if self.getMaritalStatus.count > 0 {
                        //                        self.pickerView.selectRow(0, inComponent:0, animated: true)
                        //                        self.tfMaritalStatus.text = self.dataSource[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        //                        }
                        print(self.getMaritalStatus)
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
    }
    
    //MARK:-API Calling for Getting On BEhalf
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
                        //                           if self.profileFor.count > 0 {
                        //                               self.pickerView?.selectRow(0, inComponent:0, animated: true)
                        //                               self.tfProfileCreatedFor.text =     self.profileFor[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        //                           }
                        print(self.profileFor)
                    }catch let err {
                        print("Err", err)
                    }
                })
            }
        }
    }
}
