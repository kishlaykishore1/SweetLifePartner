//
//  LifeStyleVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class LifeStyleVC: UIViewController {

    
    var pickerView : UIPickerView?
    var getDecisionData = [DecisionModel]()
    var getLifeStyleData: LifestyleModel?
    var getDietData = ["Choose One","Vegetarian","Non-Vegetarian","Eggetatian"]
    
    @IBOutlet weak var tfDiet: UITextField!
    @IBOutlet weak var tfDrink: UITextField!
    @IBOutlet weak var tfSmoke: UITextField!
    @IBOutlet weak var tflivingWith: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        apiDecision()
        apiLifestyle()
        tfDiet.addImageTo(txtField: tfDiet, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfDrink.addImageTo(txtField: tfDrink, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfSmoke.addImageTo(txtField: tfSmoke, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfDiet.text = getDietData[0]

    }
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async {
                self.setNavigationbarThemeGradientColor()
            }
             navigationController?.navigationBar.isHidden = false
             setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
             title = "Life Style"
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
        
        tfDrink.delegate = self
        tfSmoke.delegate = self
        tfDiet.delegate = self
      
       
        
        tfDrink.inputView = pickerView
        tfSmoke.inputView = pickerView
        tfDiet.inputView = pickerView
       
        
        self.pickerView = pickerView
    }
    
//MARK:- Update Button Action
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        apiLifestyleUpdate() 
    }
}
//MARK:-UITextField delegates Methods
extension LifeStyleVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension LifeStyleVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfDrink.isFirstResponder {
            return getDecisionData.count
        } else if tfSmoke.isFirstResponder {
            return getDecisionData.count
        } else if tfDiet.isFirstResponder {
            return getDietData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if tfDrink.isFirstResponder {
            return getDecisionData[row].name
        } else if tfSmoke.isFirstResponder {
            return getDecisionData[row].name
        } else if tfDiet.isFirstResponder {
            return getDietData[row]
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension LifeStyleVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tfDrink.isFirstResponder {
            let status = getDecisionData[row].name
            tfDrink.text = status
        } else if tfSmoke.isFirstResponder {
            let status = getDecisionData[row].name
            tfSmoke.text = status
        } else if tfDiet.isFirstResponder {
            let status = getDietData[row]
            tfDiet.text = status
        }
    }
}
//MARK:-Api Calling For Getting Decision
extension LifeStyleVC {
    func apiDecision() {
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
                        self.tfDrink.text = self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        self.tfSmoke.text = self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                        
                           print(self.getDecisionData)
                       } catch let err{
                           print("Err", err)
                       }
                       
                   })
               }
           }
           
       }
    
//MARK:- api calling For Residency Info
    func apiLifestyle() {
             guard let id = MemberModel.getMemberModel()?.memberID else {
                 return
             }
             if let getRequest = API.LIFESTYLEINFO.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
                 Global.showLoadingSpinner()
                 getRequest.responseJSON { response in
                 Global.dismissLoadingSpinner()
                     API.LIFESTYLEINFO.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                            self.getLifeStyleData = try decoder.decode(LifestyleModel.self, from: jsonData)
                             print(self.getLifeStyleData ?? "")
                            self.setLifestyleInfoData()
                          }  catch let err {
                                print("Err", err)
                            }
                         
                     })
                 }
                 
             }
         }
      
      func setLifestyleInfoData() {
        tfDiet.text = getLifeStyleData?.diet
        tfDrink.text = getLifeStyleData?.drink
        tfSmoke.text = getLifeStyleData?.smoke
        tflivingWith.text = getLifeStyleData?.livingWith
         
      }
//MARK:- calling Update Api for Residency Info
    func apiLifestyleUpdate() {
          guard let id = MemberModel.getMemberModel()?.memberID else {
              return
          }
        let  param:[String:Any] = ["member_id":id, "diet":tfDiet.text?.trim() ?? "", "drink":  self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].decisionID, "smoke":self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].decisionID,"living_with":tflivingWith.text?.trim() ?? ""]
        
          if let getRequest = API.UPDATELIFESTYLEINFO.request(method: .post, with: param, forJsonEncoding: true){
              Global.showLoadingSpinner()
              getRequest.responseJSON { response in
                  Global.dismissLoadingSpinner()
                  API.UPDATELIFESTYLEINFO.validatedResponse(response, completionHandler: { (jsonObject, error) in
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



