//
//  LanguageVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class LanguageVC: UIViewController {
    
    var getlanguage = [MotherTongueModel]()
    var getProfileLanguage : ProfileLanguageModel?
    var labelTitles : [String] = ["MOTHER TONGUE","LANGUAGE SPOKEN AT HOME","CAN SPEAK","CAN READ"]
    var pickerView  = UIPickerView()
    var pickerView1  = UIPickerView()
    var pickerView2   = UIPickerView()
    var pickerView3   = UIPickerView()
    var strMotherTongue: String?
    var strLanguage: String?
    var strSpeak: String?
    var strRead: String?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        
        apiMotherTongue()
        apiProfileLanguage()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
        title = "Language"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
    
        strMotherTongue = getlanguage[pickerView.selectedRow(inComponent: 0)].name
        strLanguage = getlanguage[pickerView1.selectedRow(inComponent: 0)].name
        strSpeak = getlanguage[pickerView2.selectedRow(inComponent: 0)].name
        strRead = getlanguage[pickerView3.selectedRow(inComponent: 0)].name
        apiProfileLanguageUpdate()
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
        
    }
}
//MARK:- TableView Datasource Methods
extension LanguageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableCell") as! LanguageTableCell
        cell.lblTitles.text = labelTitles[indexPath.row]
        cell.tfTitlesInput.setPadding(left: 8)
        cell.tfTitlesInput.placeholder = "Choose One"
        cell.tfTitlesInput.tag = indexPath.row
        cell.tfTitlesInput.addImageTo(txtField: cell.tfTitlesInput, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        cell.tfTitlesInput.delegate = self
        switch indexPath.row {
        case 0:
            cell.tfTitlesInput.text = getProfileLanguage?.motherTongue
        case 1:
            cell.tfTitlesInput.text = getProfileLanguage?.language
        case 2:
            cell.tfTitlesInput.text = getProfileLanguage?.speak
        case 3:
            cell.tfTitlesInput.text = getProfileLanguage?.read
            
        default:
            break
        }
        return cell
    }
}
//MARK:- TableView Delegates Methods
extension LanguageVC: UITableViewDelegate {
    
}

//MARK:-UITextField delegates Methods
extension LanguageVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 0 {
            let index0 = IndexPath(row: 0, section: 0)
            let motherTongueCell = tableView.cellForRow(at: index0)! as! LanguageTableCell
            motherTongueCell.tfTitlesInput.inputView = pickerView
            self.pickerView.reloadAllComponents()
            
        }else if textField.tag == 1 {
            let index1 = IndexPath(row: 1, section: 0)
            let languageCell = tableView.cellForRow(at: index1)! as! LanguageTableCell
            languageCell.tfTitlesInput.inputView = pickerView1
            self.pickerView2.reloadAllComponents()
            
        }else if textField.tag == 2 {
            let index2 = IndexPath(row: 2, section: 0)
            let speakCell = tableView.cellForRow(at: index2)! as! LanguageTableCell
            speakCell.tfTitlesInput.inputView = pickerView2
            self.pickerView2.reloadAllComponents()
            
        }else if textField.tag == 3 {
            let index3 = IndexPath(row: 3, section: 0)
            let readCell = tableView.cellForRow(at: index3)! as! LanguageTableCell
            readCell.tfTitlesInput.inputView = pickerView3
            self.pickerView3.reloadAllComponents()
        }
    }
}
//MARK:- Uipicker DataSource Method
extension LanguageVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerView {
            return getlanguage.count
        } else if pickerView == pickerView1 {
            return getlanguage.count
        } else if pickerView == pickerView2 {
            return getlanguage.count
        } else if pickerView == pickerView3 {
            return getlanguage.count
        }
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickerView {
            return getlanguage[row].name
        } else if pickerView == pickerView1 {
            return getlanguage[row].name
        } else if pickerView == pickerView2 {
            return getlanguage[row].name
        } else if pickerView == pickerView3 {
            return getlanguage[row].name
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension LanguageVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == self.pickerView {
            let index0 = IndexPath(row: 0 , section: 0)
            let motherTongueCell = tableView.cellForRow(at: index0)! as! LanguageTableCell
            motherTongueCell.tfTitlesInput.text = getlanguage[row].name
            
        } else if pickerView == pickerView1 {
            let index1 = IndexPath(row: 1 , section: 0)
            let languageCell = tableView.cellForRow(at: index1)! as! LanguageTableCell
            languageCell.tfTitlesInput.text = getlanguage[row].name
            
        } else if pickerView == pickerView2 {
            let index2 = IndexPath(row: 2, section: 0)
            let speakCell = tableView.cellForRow(at: index2)! as! LanguageTableCell
            speakCell.tfTitlesInput.text = getlanguage[row].name
            
        } else if pickerView == pickerView3 {
            let index3 = IndexPath(row: 3, section: 0)
            let readCell = tableView.cellForRow(at: index3)! as! LanguageTableCell
            readCell.tfTitlesInput.text = getlanguage[row].name
            
        }
        
        
        
    }
}
//MARK:- TableView Cell class
class LanguageTableCell: UITableViewCell {
    
    @IBOutlet weak var lblTitles: UILabel!
    @IBOutlet weak var tfTitlesInput: UITextField!
    
}

//MARK:- api calling for Language
extension LanguageVC {
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
                        self.getlanguage = try decoder.decode([MotherTongueModel].self, from: jsonData)
                        print(self.getlanguage)
                    }catch let err {
                        print("Err", err)
                    }
                })
            }
        }
    }
    //MARK:- api Calling For Profile Language
    func apiProfileLanguage() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        if let getRequest = API.PROFILELANGUAGE.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.PROFILELANGUAGE.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                        self.getProfileLanguage = try decoder.decode(ProfileLanguageModel.self, from: jsonData)
                        print(self.getProfileLanguage ?? "")
                        self.tableView.reloadData()
                    }  catch let err {
                        print("Err", err)
                    }
                    
                })
            }
            
        }
    }
    
    //MARK:- calling Update Api for Physical Attributes
    func apiProfileLanguageUpdate() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let  param:[String:Any] = ["member_id":id, "mother_tongue":strMotherTongue ?? "", "language":strLanguage ?? "", "speak":strSpeak ?? "","read":strRead ?? ""]
        
        if let getRequest = API.UPDATEPROFILELANGUAGE.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.UPDATEPROFILELANGUAGE.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
