//
//  Spiritual&SocialVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class Spiritual_SocialVC: UIViewController {

    
    var pickerView : UIPickerView?
    var zodiacArr = ["Choose One","Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio","Sagittarius","Capricorn","Aquarius","Pisces"]
    var getReligionData = [ReligionModel]()
    var getCasteData = [GetCasteModel]()
    var subCasteData = [SubCasteModel]()
    var getFamilyValue = [FamilyValuesModel]()
    var getFamilyStatus = [FamilyStatusModel]()
    var getDecisionData = [DecisionModel]()
    var getSpiritualSocialInfo: SpritualAndSocialModel?
    var casteId = ""
    var religionId = ""


    @IBOutlet weak var tfReligion: UITextField!
    @IBOutlet weak var tfCaste: UITextField!
    @IBOutlet weak var tfZodiac: UITextField!
    @IBOutlet weak var tfTimeOfBirth: UITextField!
    @IBOutlet weak var tfCityOfBirth: UITextField!
    @IBOutlet weak var tfPersonalValue: UITextField!
    @IBOutlet weak var tfCommunityValue: UITextField!
    @IBOutlet weak var tfManglik: UITextField!
    @IBOutlet weak var tfEthnicity: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
        apiReligion()
        apiDecisionData()
        apiSpiritualSocialInfo()
        tfReligion.addImageTo(txtField: tfReligion, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfCaste.addImageTo(txtField: tfCaste, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfZodiac.addImageTo(txtField: tfZodiac, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
        tfManglik.addImageTo(txtField: tfManglik, andImage: #imageLiteral(resourceName: "SlpDropDown"), isLeft: false)
       
       
        tfZodiac.text = self.zodiacArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        

    }
    override func viewWillAppear(_ animated: Bool) {
               DispatchQueue.main.async {
                   self.setNavigationbarThemeGradientColor()
               }
                navigationController?.navigationBar.isHidden = false
                setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
                title = "Spiritual And Social Background"
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

       tfReligion.delegate = self
       tfCaste.delegate = self
       tfZodiac.delegate = self
       tfManglik.delegate = self

       tfReligion.inputView = pickerView
       tfCaste.inputView = pickerView
       tfZodiac.inputView = pickerView
       tfManglik.inputView = pickerView


       self.pickerView = pickerView
   }
//MARK:- Update Button Pressed
    @IBAction func btnUpdatePressed(_ sender: UIButton) {

        pickerView?.selectRow(1, inComponent: 0, animated: true)
        apiSpiritualSocialInfoUpdate()
    }

}
//MARK:-UITextField delegates Methods
extension Spiritual_SocialVC: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {

        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension Spiritual_SocialVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfReligion.isFirstResponder {
            return getReligionData.count
        } else if tfCaste.isFirstResponder {
            return getCasteData.count
        } else if tfZodiac.isFirstResponder {
            return zodiacArr.count
        } else if tfManglik.isFirstResponder {
            return getDecisionData.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if tfReligion.isFirstResponder {
            return getReligionData[row].name
        } else if tfCaste.isFirstResponder {
            return getCasteData[row].casteName
        } else if tfZodiac.isFirstResponder {
            return zodiacArr[row]
        } else if tfManglik.isFirstResponder {
            return getDecisionData[row].name
        }
    
        return nil
   }
}
//MARK:- Uipicker Delegate Method
extension Spiritual_SocialVC: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tfReligion.isFirstResponder {
            let status = getReligionData[row].name
            self.religionId = getReligionData[row].religionID
            apiCaste()
            tfReligion.text = status
        } else if tfCaste.isFirstResponder {
            let status = getCasteData[row].casteName
            self.casteId = getCasteData[row].casteID
            tfCaste.text = status
        } else if tfZodiac.isFirstResponder {
            let status = zodiacArr[row]
            tfZodiac.text = status
        } else if tfManglik.isFirstResponder {
            let status = getDecisionData[row].name
            tfManglik.text = status
        }

    }
}
//MARK:-API Calling for Getting Religion Data
extension Spiritual_SocialVC {
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
                         self.getReligionData = try decoder.decode([ReligionModel].self, from: jsonData)
                        self.tfReligion.text = self.getReligionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                         print(self.getReligionData)
                     }catch let err {
                         print("Err", err)
                     }
                 })
             }
         }
     }
//MARK:-API Calling for Getting Caste
    func apiCaste() {
    let param: [String: Any] = ["religion_id": religionId]
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
                    self.getCasteData = try decoder.decode([GetCasteModel].self, from: jsonData)
                    self.tfCaste.text = self.getCasteData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].casteName
                    print(self.getCasteData)

                } catch let err{
                    print("Err", err)
                }

            })
        }
      }
    }



//MARK:- API CAlling For getting Decision Data
    func apiDecisionData() {
           if let getRequest = API.DECISION.request(method: .get, with: nil, forJsonEncoding: true) {
           Global.showLoadingSpinner()
               getRequest.responseJSON { response in
               Global.dismissLoadingSpinner()
                   API.DECISION.validatedResponse(response, completionHandler: { (jsonObject,error) in
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
                           self.getDecisionData = try decoder.decode([DecisionModel].self, from: jsonData)
                           self.tfManglik.text = self.getDecisionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].name
                           print(self.getDecisionData)
                       } catch let err{
                           print("Err", err)
                       }
                   })
               }
           }
       }
  //MARK:-api CAlling for Spritual&Social
    func apiSpiritualSocialInfo() {
           guard let id = MemberModel.getMemberModel()?.memberID else {
               return
           }
           if let getRequest = API.SPIRITUALSOCIALINFO.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
               Global.dismissLoadingSpinner()
                   API.SPIRITUALSOCIALINFO.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                           self.getSpiritualSocialInfo = try decoder.decode(SpritualAndSocialModel.self, from: jsonData)
                           print(self.getSpiritualSocialInfo ?? "")
                        self.setSpiritualInfoData()
                        }  catch let err {
                              print("Err", err)
                          }

                   })
               }

           }
       }

    func setSpiritualInfoData() {
        tfReligion.text = getSpiritualSocialInfo?.religion
        tfCaste.text = getSpiritualSocialInfo?.caste
        tfZodiac.text = getSpiritualSocialInfo?.sunSign
        tfTimeOfBirth.text = getSpiritualSocialInfo?.timeOfBirth
        tfCityOfBirth.text = getSpiritualSocialInfo?.cityOfBirth
        tfPersonalValue.text = getSpiritualSocialInfo?.personalValue
        tfCommunityValue.text = getSpiritualSocialInfo?.communityValue
        tfEthnicity.text = getSpiritualSocialInfo?.ethnicity
        tfManglik.text = getSpiritualSocialInfo?.uManglik
       }
//MARK:- calling Update Api for spiritual & SocialInfo
    func apiSpiritualSocialInfoUpdate() {
          guard let id = MemberModel.getMemberModel()?.memberID else {
              return
          }
        let  param:[String:Any] = ["member_id":id, "religion":self.getReligionData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].religionID , "tfCaste":self.getCasteData[self.pickerView?.selectedRow(inComponent: 0) ?? 0].casteID, "sun_sign":self.zodiacArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0],"time_of_birth":tfTimeOfBirth.text?.trim() ?? "","city_of_birth":tfCityOfBirth.text?.trim() ?? "","tfEthnicity":tfEthnicity.text?.trim() ?? "","tfPersonalValue":tfPersonalValue.text?.trim() ?? "","tfCommunityValue":tfCommunityValue.text?.trim() ?? "","u_manglik":tfManglik.text?.trim() ?? "",]
        print(param)
          if let getRequest = API.UPDATESPIRITUALSOCIALINFO.request(method: .post, with: param, forJsonEncoding: true){
              Global.showLoadingSpinner()
              getRequest.responseJSON { response in
                  Global.dismissLoadingSpinner()
                  API.UPDATESPIRITUALSOCIALINFO.validatedResponse(response, completionHandler: { (jsonObject, error) in
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



