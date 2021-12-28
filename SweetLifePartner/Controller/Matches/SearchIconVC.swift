//
//  SearchIconVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 08/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

protocol ProfileDelegate : class {
    func btnProfileSearchPressed(_ tag: Int)
}
class SearchIconVC: UIViewController {
    
    var SearchArr = ["Age","Height","Marital status","Religion","Caste","Mother Tongue","Country Living in","State Living in","SearchType","Education and Career","Profession Area"]
    var PlaceholderArr = ["20-25","5.1-5.6","Choose One","Choose One","Choose One","Choose One","Choose One","Choose One","Choose One","Education","Work"]
    var enteredValue = ["","","","","","","","","","",""]
    var searchData = ["free_members","premium_members"]
    var getMotherTongue = [MotherTongueModel]()
    var getMaritalStatus = [MaritalStatusModel]()
    var getreligionData = [ReligionModel]()
    var religionID = ""
    var getcasteData = [GetCasteModel]()
    var getcountryData = [GetCountryModel]()
    var countryID = ""
    var stateData = [GetStateModel]()
    var pickerView  = UIPickerView()
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var pickerView3 = UIPickerView()
    var pickerView4 = UIPickerView()
    var pickerView5 = UIPickerView()
    var pickerView6 = UIPickerView()
    var StrSelectedValue : String = "General Search"
    var searchedData = [SearchedModelElement]()
    
    
    
    @IBOutlet weak var firstView: BaseView!
    @IBOutlet weak var btnGeneralSearch: UIButton!
    @IBOutlet weak var btnProfileIdSearch: UIButton!
    @IBOutlet var footerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        navigationController?.navigationBar.isHidden = true
        footerConfiguration()
        btnGeneralSearch.bottomLineColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        btnGeneralSearch.bottomLineWidth = 2
        firstView.delegate = self
        apiMaritalStatus()
        apiReligion()
        apiMotherTongue()
        apiCountryLivingIn()
    }
    
    //MARK:- UIPickerView Delegates assigning
    func PickerViewConnection() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        pickerView4.delegate = self
        pickerView4.dataSource = self
        
        pickerView5.delegate = self
        pickerView5.dataSource = self
        
        pickerView6.delegate = self
        pickerView6.dataSource = self
         
        
    }
    //MARK: General Button Pressed Action Defined
    @IBAction func btnGeneralSearchPressed(_ sender: UIButton) {
        StrSelectedValue = "General Search"
        
        self.btnGeneralSearch.setTitleColor(.systemPink, for: .normal)
        self.btnProfileIdSearch.bottomLineColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.btnProfileIdSearch.bottomLineWidth = 0
        self.btnProfileIdSearch.setTitleColor(#colorLiteral(red: 0.1058823529, green: 0.1490196078, blue: 0.1725490196, alpha: 1), for: .normal)
        self.btnGeneralSearch.bottomLineColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        self.btnGeneralSearch.bottomLineWidth = 2
        footerConfiguration()
        self.tableView.reloadData()
    }
    //MARK: Profile ID Search  Button Pressed Action Defined
    @IBAction func btnProfileSearchPressed(_ sender: UIButton) {
        StrSelectedValue = "Profile ID Search"
        
        self.btnProfileIdSearch.setTitleColor(.systemPink, for: .normal)
        self.btnProfileIdSearch.bottomLineColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        self.btnProfileIdSearch.bottomLineWidth = 2
        self.btnGeneralSearch.setTitleColor(#colorLiteral(red: 0.1058823529, green: 0.1490196078, blue: 0.1725490196, alpha: 1), for: .normal)
        self.btnGeneralSearch.bottomLineColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.btnGeneralSearch.bottomLineWidth = 0
        tableView.tableFooterView = UIView()
        self.tableView.reloadData()
    }
    //MARK:- Button Search Now Action
    @IBAction func btnSearchNowPressed(_ sender: UIButton) {
        
        if StrSelectedValue == "General Search" {
            guard let id = MemberModel.getMemberModel()?.memberID else {
                return
            }
            guard let profileId = MemberModel.getMemberModel()?.memberProfileID else {
                return
            }
            var  param: [String:Any] = ["member_id":id,"member_type": "","member_profile_id": profileId]
            
            for index in 0..<enteredValue.count {
                switch index {
                case 0:
                    if enteredValue[index] != "" {
                        param["age"] = enteredValue[index]
                    }
                    break
                case 1:
                    if enteredValue[index] != "" {
                        param["height"] = enteredValue[index]
                    }
                    break
                case 2:
                    if enteredValue[index] != "" {
                        param["marital_status"] = enteredValue[index]
                    }
                    break
                case 3:
                    if enteredValue[index] != "" {
                        param["religion"] = enteredValue[index]
                    }
                    break
                case 4:
                    if enteredValue[index] != "" {
                        param["caste"] = enteredValue[index]
                    }
                    break
                case 5:
                    if enteredValue[index] != "" {
                        param["language"] = enteredValue[index]
                    }
                    break
                case 6:
                    if enteredValue[index] != "" {
                        param["country"] = enteredValue[index]
                    }
                    break
                case 7:
                    if enteredValue[index] != "" {
                        param["state"] = enteredValue[index]
                    }
                    break
               case 8:
                   if enteredValue[index] != "" {
                       param["member_type"] = enteredValue[index]
                   } else {
                       param["member_type"] = "free_members"
                   }
                   break
               case 9:
                    if enteredValue[index] != "" {
                        param["education"] = enteredValue[index]
                    }
                    break
                case 10:
                    if enteredValue[index] != "" {
                        param["profession"] = enteredValue[index]
                    }
                    break
                default:
                    break
                }
            }
            
            apiGenearlSearch(param: param)
        }
    }
}
//MARK:- To Set The Footer View Configuration
extension SearchIconVC {
    func footerConfiguration() {
        
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height:footerView.frame.size.height)
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.frame = footerView.frame
    }
}
//MARK:- TableView DataSource Methods
extension SearchIconVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if StrSelectedValue == "General Search" {
            
            if section == 0{
                return SearchArr.count
            }
        }
        if StrSelectedValue == "Profile ID Search" {
            
            if section == 0{
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if StrSelectedValue == "General Search" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchOptionCell") as! SearchOptionCell
            cell.lblSearchFieldName.text = SearchArr[indexPath.row]
            cell.tfInputSearch.placeholder = PlaceholderArr[indexPath.row]
            if indexPath.row >= 2 && indexPath.row <= 8 {
                cell.tfInputSearch.addImageTo(txtField: cell.tfInputSearch, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
            }
            cell.tfInputSearch.text = enteredValue[indexPath.row]
            cell.tfInputSearch.tag = indexPath.row
            cell.tfInputSearch.delegate = self
            return cell
        } else if StrSelectedValue == "Profile ID Search" {
          
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileIdCell") as! ProfileIdCell
            cell.cellDelegate = self
            cell.btnSearchProfile.tag = indexPath.row
            return cell
        }
        return UITableViewCell()
    }
}
//MARK:- TableView Delegates methods
extension SearchIconVC: UITableViewDelegate {
    
}
//MARK:- Table View first Cell Classes
class SearchOptionCell : UITableViewCell {
    
    @IBOutlet weak var lblSearchFieldName: UILabel!
    @IBOutlet weak var tfInputSearch: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tfInputSearch.delegate = self
    }
    
    
}
//MARK: Setting TextField Delegates for change in border colour
extension SearchOptionCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tfInputSearch.layer.borderWidth = 1
        tfInputSearch.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.2039215686, blue: 0.431372549, alpha: 1)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        tfInputSearch.layer.borderWidth = 1
        tfInputSearch.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
}
//MARK:- Table View second Cell Classe
class ProfileIdCell : UITableViewCell  {
    
    @IBOutlet weak var tfProfileIdInput: UITextField!
    @IBOutlet weak var btnSearchProfile: DesignableButton!
    
var cellDelegate: ProfileDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        tfProfileIdInput.delegate = self
        tfProfileIdInput.setPadding(left: 10.0)
    }
    
    @IBAction func btnProfileSearchPressed(_ sender: UIButton!) {
        cellDelegate?.btnProfileSearchPressed(sender.tag)
        
    }
    
}
//MARK: Setting TextField Delegates for change in border colour
extension ProfileIdCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        tfProfileIdInput.layer.borderWidth = 1
        tfProfileIdInput.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.2039215686, blue: 0.431372549, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tfProfileIdInput.layer.borderWidth = 1
        tfProfileIdInput.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tfProfileIdInput = textField
        
    }
}
//MARK: Calling the protocol delegates for custom view buttons
extension SearchIconVC : CellDelegate {
    func cellSelected(_ indexPath: IndexPath) {
        switch indexPath.row {
        case 0 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "SearchIconVC") as! SearchIconVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
           
        case 1 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "MatchesVC") as! MatchesVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 2 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "AllButtonVC") as! AllButtonVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
           
        case 3 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "NearMeVC") as! NearMeVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 4 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "ShortlistedVC") as! ShortlistedVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 5 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyFollowerVC") as! MyFollowerVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 6 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "PrefProfessionVC") as! PrefProfessionVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        case 7 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "PrefEducationVC") as! PrefEducationVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        default:
            print("You Are done")
            break
        }
        
    }
}

//MARK:-UITextField delegates Methods for Main View Controller
extension SearchIconVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 2 {
            let index2 = IndexPath(row: 2, section: 0)
            let maritalStatusCell = tableView.cellForRow(at: index2)! as! SearchOptionCell
            maritalStatusCell.tfInputSearch.inputView = pickerView
            pickerView.tag = textField.tag
            self.pickerView.reloadAllComponents()
            
        }else if textField.tag == 3 {
            let index3 = IndexPath(row: 3, section: 0)
            let religionCell = tableView.cellForRow(at: index3)! as! SearchOptionCell
            religionCell.tfInputSearch.inputView = pickerView1
            pickerView1.tag = textField.tag
            self.pickerView1.reloadAllComponents()
            
        }else if textField.tag == 4 {
            let index4 = IndexPath(row: 4, section: 0)
            let casteCell = tableView.cellForRow(at: index4)! as! SearchOptionCell
            casteCell.tfInputSearch.inputView = pickerView2
            pickerView2.tag = textField.tag
            self.pickerView2.reloadAllComponents()
            
        }else if textField.tag == 5 {
            let index5 = IndexPath(row: 5, section: 0)
            let motherTongueCell = tableView.cellForRow(at: index5)! as! SearchOptionCell
            motherTongueCell.tfInputSearch.inputView = pickerView3
            pickerView3.tag = textField.tag
            self.pickerView3.reloadAllComponents()
            
        }else if textField.tag == 6 {
            let index6 = IndexPath(row: 6, section: 0)
            let countryCell = tableView.cellForRow(at: index6)! as! SearchOptionCell
            countryCell.tfInputSearch.inputView = pickerView4
            pickerView4.tag = textField.tag
            self.pickerView4.reloadAllComponents()
            
        }else if textField.tag == 7 {
            let index7 = IndexPath(row: 7, section: 0)
            let stateCell = tableView.cellForRow(at: index7)! as! SearchOptionCell
            stateCell.tfInputSearch.inputView = pickerView5
            pickerView5.tag = textField.tag
            self.pickerView5.reloadAllComponents()
            
        }else if textField.tag == 8 {
            let index8 = IndexPath(row: 8, section: 0)
            let searchCell = tableView.cellForRow(at: index8)! as! SearchOptionCell
            searchCell.tfInputSearch.inputView = pickerView6
            pickerView6.tag = textField.tag
            self.pickerView6.reloadAllComponents()
        }
    }
    //MARK:- TExtfield End Editing Function
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            enteredValue[textField.tag] = textField.text ?? ""
        } else if textField.tag == 1 {
            enteredValue[textField.tag] = textField.text ?? ""
        } else if textField.tag == 9 {
            enteredValue[textField.tag] = textField.text ?? ""
        } else if textField.tag == 10 {
            enteredValue[textField.tag] = textField.text ?? ""
        }
    }
}
//MARK:- Uipicker DataSource Method
extension SearchIconVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == self.pickerView {
            return getMaritalStatus.count
        } else if pickerView == pickerView1 {
            return getreligionData.count
        } else if pickerView == pickerView2 {
            return getcasteData.count
        } else if pickerView == pickerView3 {
            return getMotherTongue.count
        } else if pickerView == pickerView4 {
            return getcountryData.count
        } else if pickerView == pickerView5 {
            return stateData.count
        } else if pickerView == pickerView6 {
            return searchData.count
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.pickerView {
            return getMaritalStatus[row].name
        } else if pickerView == pickerView1 {
            return getreligionData[row].name
        } else if pickerView == pickerView2 {
            return getcasteData[row].casteName
        } else if pickerView == pickerView3 {
            return getMotherTongue[row].name
        } else if pickerView == pickerView4 {
            return getcountryData[row].name
        } else if pickerView == pickerView5 {
            return stateData[row].name
        } else if pickerView == pickerView6 {
            return searchData[row]
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension SearchIconVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.pickerView {
            let index2 = IndexPath(row: 2, section: 0)
            let maritalStatusCell = tableView.cellForRow(at: index2)! as! SearchOptionCell
            maritalStatusCell.tfInputSearch.text = getMaritalStatus[row].name
            self.enteredValue[pickerView.tag] = maritalStatusCell.tfInputSearch.text ?? ""
            
        } else if pickerView == pickerView1 {
            let index3 = IndexPath(row: 3, section: 0)
            let religionCell = tableView.cellForRow(at: index3)! as! SearchOptionCell
            religionCell.tfInputSearch.text = getreligionData[row].name
            self.enteredValue[pickerView1.tag] =  religionCell.tfInputSearch.text ?? ""
            self.religionID = getreligionData[row].religionID
            apiCaste()
            
        } else if pickerView == pickerView2 {
            let index4 = IndexPath(row: 4, section: 0)
            let casteCell = tableView.cellForRow(at: index4)! as! SearchOptionCell
            casteCell.tfInputSearch.text = getcasteData[row].casteName
            self.enteredValue[pickerView2.tag] = casteCell.tfInputSearch.text ?? ""
            
        } else if pickerView == pickerView3 {
            let index5 = IndexPath(row: 5, section: 0)
            let motherTongueCell = tableView.cellForRow(at: index5)! as! SearchOptionCell
            motherTongueCell.tfInputSearch.text = getMotherTongue[row].name
            self.enteredValue[pickerView3.tag] = motherTongueCell.tfInputSearch.text ?? ""
            
        } else if pickerView == pickerView4 {
            let index6 = IndexPath(row: 6, section: 0)
            let countryCell = tableView.cellForRow(at: index6)! as! SearchOptionCell
            countryCell.tfInputSearch.text = getcountryData[row].name
            self.enteredValue[pickerView4.tag] = countryCell.tfInputSearch.text ?? ""
            self.countryID = getcountryData[row].countryID
            apiStateLivingIn()
            
        } else if pickerView == pickerView5 {
            let index7 = IndexPath(row: 7, section: 0)
            let stateCell = tableView.cellForRow(at: index7)! as! SearchOptionCell
            stateCell.tfInputSearch.text = stateData[row].name
            self.enteredValue[pickerView5.tag] = stateCell.tfInputSearch.text ?? ""
            
        } else if pickerView == pickerView6 {
            let index8 = IndexPath(row: 8, section: 0)
            let searchCell = tableView.cellForRow(at: index8)! as! SearchOptionCell
            searchCell.tfInputSearch.text = searchData[row]
            self.enteredValue[pickerView6.tag] = searchCell.tfInputSearch.text ?? ""
            
        }
        
    }
}
//MARK:-API Calling
extension SearchIconVC {
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
                        print(self.getMaritalStatus)
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
    }
    //MARK:-API Calling for Getting Religion Data
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
                        print(self.getreligionData)
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
                        print(self.getcasteData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                    
                })
            }
        }
    }
    //MARK:- APi CAlling For Mother Tongue
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
                        self.getMotherTongue = try decoder.decode([MotherTongueModel].self, from: jsonData)
                        print(self.getMotherTongue)
                    }catch let err {
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
    //MARK:- calling Search Api for General Serch Now Button
    
    func apiGenearlSearch(param: [String: Any]) {
        
      print(param)
      if let getRequest = API.GENERALSEARCH.request(method: .post, with: param, forJsonEncoding: false) {
          Global.showLoadingSpinner()
          getRequest.responseJSON { response in
              Global.dismissLoadingSpinner()
              API.GENERALSEARCH.validatedResponse(response, completionHandler: { (jsonObject,error) in
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
                      self.searchedData = try decoder.decode([SearchedModelElement].self, from: jsonData)
                    if self.searchedData.count > 0 {
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
                       
                       vc.modalTransitionStyle = .flipHorizontal
                       vc.modalPresentationStyle = .fullScreen
                       vc.getSearchedData = self.searchedData
                       self.present(vc, animated: true, completion: nil)
                    }
                      print(self.searchedData)

                  } catch let err{
                      print("Err", err)
                  }
              })
          }
      }
    }
}
//MARK:- Assigning the protocol delegate
extension SearchIconVC : ProfileDelegate {
    
    
    func btnProfileSearchPressed(_ tag: Int) {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let index = IndexPath(row:0, section: 0)
        let cell = tableView.cellForRow(at:index) as! ProfileIdCell
        let txt = cell.tfProfileIdInput.text
        let  param: [String:Any] = ["member_id":id,"member_type": "search_members" ,"member_profile_id": txt ?? ""]
        print(param)
        apiGenearlSearch(param: param)
    
        
        }
       
    }
    





