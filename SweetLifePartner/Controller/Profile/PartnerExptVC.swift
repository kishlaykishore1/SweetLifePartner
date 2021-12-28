//
//  PartnerExptVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PartnerExptVC: UIViewController {

    
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
   
    
    
    @IBOutlet weak var tfGeneralRequirement: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    @IBOutlet weak var tfHeight: UITextField!
    @IBOutlet weak var tfWeight: UITextField!
    @IBOutlet weak var tfMaritalStatus: UITextField!
    @IBOutlet weak var tfWithChildAccept: UITextField!
    @IBOutlet weak var tfCountryOfResidence: UITextField!
    @IBOutlet weak var tfReligion: UITextField!
    @IBOutlet weak var tfCaste: UITextField!
    @IBOutlet weak var tfSubcaste: UITextField!
    @IBOutlet weak var tfEducation: UITextField!
    @IBOutlet weak var tfProfession: UITextField!
    @IBOutlet weak var tfDrinkingHabits: UITextField!
    @IBOutlet weak var tfSmokingHabits: UITextField!
    @IBOutlet weak var tfDiet: UITextField!
    @IBOutlet weak var tfBodyType: UITextField!
    @IBOutlet weak var tfPersonalValue: UITextField!
    @IBOutlet weak var tfAnyDisability: UITextField!
    @IBOutlet weak var tfFamilyValue: UITextField!
    @IBOutlet weak var tfManglik: UITextField!
    @IBOutlet weak var tfMotherTongue: UITextField!
    @IBOutlet weak var tfPreferedCountry: UITextField!
    @IBOutlet weak var tfPreferedState: UITextField!
    @IBOutlet weak var tfPreferedStatus: UITextField!
    @IBOutlet weak var tfComplexion: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        PickerViewConnection()
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
             title = "Partner Expectation"
    }
    //MARK:- Back Button Action
    override func backBtnTapAction() {
          self.navigationController?.popViewController(animated: true)
    }

//MARK:- Update Button Pressed
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        pickerView?.selectedRow(inComponent: 0)
       apiPartnerPrefUpdate()
    }
//MARK:- UIPickerView Delegates assigning
func PickerViewConnection() {
    let pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.dataSource = self
 
    tfMaritalStatus.delegate = self
    tfWithChildAccept.delegate = self
    tfCountryOfResidence.delegate = self
    tfReligion.delegate = self
    tfCaste.delegate = self
    tfSubcaste.delegate = self
    tfDrinkingHabits.delegate = self
    tfSmokingHabits.delegate = self
    tfFamilyValue.delegate = self
    tfManglik.delegate = self
    tfMotherTongue.delegate = self
    tfPreferedCountry.delegate = self
    tfPreferedState.delegate = self

    tfMaritalStatus.inputView = pickerView
    tfWithChildAccept.inputView = pickerView
    tfCountryOfResidence.inputView = pickerView
    tfReligion.inputView = pickerView
    tfCaste.inputView = pickerView
    tfSubcaste.inputView = pickerView
    tfDrinkingHabits.inputView = pickerView
    tfSmokingHabits.inputView = pickerView
    tfManglik.inputView = pickerView
    tfMotherTongue.inputView = pickerView
    tfPreferedCountry.inputView = pickerView
    tfPreferedState.inputView = pickerView
   
    
    self.pickerView = pickerView
}
}
//MARK:-UITextField delegates Methods
extension PartnerExptVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        self.pickerView?.reloadAllComponents()
    }
}
//MARK:- Uipicker DataSource Method
extension PartnerExptVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if tfMaritalStatus.isFirstResponder {
            return getMaritalStatus.count
        } else if tfWithChildAccept.isFirstResponder {
            return getDecisionData.count
        } else if tfCountryOfResidence.isFirstResponder {
            return getcountryData.count
        } else if tfReligion.isFirstResponder {
            return getreligionData.count
        } else if tfCaste.isFirstResponder {
            return getcasteData.count
        }  else if tfSubcaste.isFirstResponder {
            return getsubData.count
        } else if tfDrinkingHabits.isFirstResponder {
            return getDecisionData.count
        } else if tfSmokingHabits.isFirstResponder {
            return getDecisionData.count
        } else if tfManglik.isFirstResponder {
            return getDecisionData.count
        } else if tfMotherTongue.isFirstResponder {
            return getmotherTongue.count
        } else if tfPreferedCountry.isFirstResponder {
            return getcountryData.count
        } else if tfPreferedState.isFirstResponder {
            return stateData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if tfMaritalStatus.isFirstResponder {
            return getMaritalStatus[row].name
        } else if tfWithChildAccept.isFirstResponder {
            return getDecisionData[row].name
        } else if tfCountryOfResidence.isFirstResponder {
            return getcountryData[row].name
        } else if tfReligion.isFirstResponder {
            return getreligionData[row].name
        } else if tfCaste.isFirstResponder {
            return getcasteData[row].casteName
        }  else if tfSubcaste.isFirstResponder {
            return getsubData[row].subCasteName
        } else if tfDrinkingHabits.isFirstResponder {
            return getDecisionData[row].name
        } else if tfSmokingHabits.isFirstResponder {
            return getDecisionData[row].name
        } else if tfManglik.isFirstResponder {
            return getDecisionData[row].name
        } else if tfMotherTongue.isFirstResponder {
            return getmotherTongue[row].name
        } else if tfPreferedCountry.isFirstResponder {
            return getcountryData[row].name
        } else if tfPreferedState.isFirstResponder {
            return stateData[row].name
        }
        return nil
    }
}
//MARK:- Uipicker Delegate Method
extension PartnerExptVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if tfMaritalStatus.isFirstResponder {
            let status = getMaritalStatus[row].id
            tfMaritalStatus.text = status
        } else if tfWithChildAccept.isFirstResponder {
            let status = getDecisionData[row].decisionID
            tfWithChildAccept.text = status
        } else if tfCountryOfResidence.isFirstResponder {
             let status = getcountryData[row].name
             tfCountryOfResidence.text = status
        } else if tfReligion.isFirstResponder {
            let status = getreligionData[row].name
            self.religionID = getreligionData[row].religionID
            apiCaste()
            tfReligion.text = status
        } else if tfCaste.isFirstResponder {
            let status = getcasteData[row].casteName
            self.casteID = getcasteData[row].casteID
            apiSubCaste()
            tfCaste.text = status
        } else if tfSubcaste.isFirstResponder {
            let status = getsubData[row].subCasteName
            tfSubcaste.text = status
        } else if tfDrinkingHabits.isFirstResponder {
            let status = getDecisionData[row].name
            tfDrinkingHabits.text = status
        } else if tfSmokingHabits.isFirstResponder {
            let status = getDecisionData[row].name
            tfSmokingHabits.text = status
        } else if tfManglik.isFirstResponder {
            let status = getDecisionData[row].name
            tfManglik.text = status
        } else if tfMotherTongue.isFirstResponder {
            let status = getmotherTongue[row].name
            tfMotherTongue.text = status
        } else if tfPreferedCountry.isFirstResponder {
            let status = getcountryData[row].name
            self.countryID = getcountryData[row].countryID
            apiStateLivingIn()
            tfPreferedCountry.text = status
        } else if tfPreferedState.isFirstResponder {
            let status = stateData[row].name
            tfPreferedState.text = status
        }
    }
}

//MARK:-API Calling for Getting Religion Data
extension PartnerExptVC {
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
//MARK:-API Calling for Getting Caste
    func apiSubCaste() {
    let param: [String: Any] = ["caste_id": casteID]
    print(param)
    if let getRequest = API.GETSUBCASTE.request(method: .post, with: param, forJsonEncoding: true){
       // Global.showLoadingSpinner()
        getRequest.responseJSON { response in
           // Global.dismissLoadingSpinner()
            API.GETSUBCASTE.validatedResponse(response, completionHandler: { (jsonObject, error) in
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
                    self.getsubData = try decoder.decode([SubCasteModel].self, from: jsonData)
                    print(self.getsubData)
                    
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
                            //self.setPartnerExpectData()
                            }  catch let err {
                                  print("Err", err)
                              }
                       })
                   }
                   
               }
           }
        
//        func setPartnerExpectData() {
//           tfReligion.text = getSpiritualSocialInfo?.religion
//           tfCaste.text = getSpiritualSocialInfo?.caste
//           tfSubCaste.text = getSpiritualSocialInfo?.subCaste
//           tfEthnicity.text = getSpiritualSocialInfo?.ethnicity
//           tfPersonalValue.text = getSpiritualSocialInfo?.personalValue
//           tfFamilyValue.text = getSpiritualSocialInfo?.familyValue
//           tfCommunityValue.text = getSpiritualSocialInfo?.communityValue
//           tfFamilyStatus.text = getSpiritualSocialInfo?.familyStatus
//           tfMangalik.text = getSpiritualSocialInfo?.uManglik
 //          }
    //MARK:- calling Update Api for Partner Expectation
        func apiPartnerPrefUpdate() {
              guard let id = MemberModel.getMemberModel()?.memberID else {
                  return
              }
            let  param:[String:Any] = ["member_id":id,"general_requirement":tfGeneralRequirement ?? "", "partner_age": tfAge ?? "", "partner_height":tfHeight.text?.trim() ?? "", "partner_weight":tfWeight.text?.trim() ?? "","partner_marital_status":tfMaritalStatus.text?.trim() ?? "","with_children_acceptables":tfWithChildAccept.text?.trim() ?? "","partner_country_of_residence":tfCountryOfResidence.text?.trim() ?? "","partner_religion":tfReligion.text?.trim() ?? "","partner_caste":tfCaste.text?.trim() ?? "","partner_sub_caste":tfSubcaste.text?.trim() ?? "","partner_complexion":tfComplexion.text?.trim() ?? "","partner_education":tfEducation.text?.trim() ?? "","partner_profession":tfProfession.text?.trim() ?? "","partner_drinking_habits":tfDrinkingHabits.text?.trim() ?? "","partner_smoking_habits":tfSmokingHabits.text?.trim() ?? "","partner_diet":tfDiet.text?.trim() ?? "","partner_body_type":tfBodyType.text?.trim() ?? "","partner_personal_value":tfPersonalValue.text?.trim() ?? "","manglik":tfManglik.text?.trim() ?? "","partner_any_disability":tfAnyDisability.text?.trim() ?? "","partner_mother_tongue":tfMotherTongue.text?.trim() ?? "","partner_family_value":tfFamilyValue.text?.trim() ?? "","prefered_country":tfPreferedCountry.text?.trim() ?? "","prefered_state":tfPreferedState.text?.trim() ?? "","prefered_status":tfPreferedStatus.text?.trim() ?? ""]
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


