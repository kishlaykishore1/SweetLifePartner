//
//  ViewDetailsVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 16/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class ViewDetailsVC: UIViewController {

    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblFullName: UILabel!
    //MARK:Outlets For Introduction
    @IBOutlet weak var lblIntroduction: UILabel!
  //MARK:Outlets For Basic Information
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblChildren: UILabel!
    @IBOutlet weak var lblSelf: UILabel!
    @IBOutlet weak var lblDateOfBirth: UILabel!
    @IBOutlet weak var lblMaritalStatus: UILabel!
  //MARK:Outlets For Present Address
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblPostalCode: UILabel!
  //MARK:Outlets For Education& Career
    @IBOutlet weak var lblHighestEducation: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    @IBOutlet weak var lblAnnualIncome: UILabel!
  //MARK:Outlets For Spiritual & Social Background
    @IBOutlet weak var lblReligion: UILabel!
    @IBOutlet weak var lblCaste: UILabel!
    @IBOutlet weak var lblSubCaste: UILabel!
    @IBOutlet weak var lblEthnicity: UILabel!
    @IBOutlet weak var lblPersonalValue: UILabel!
    @IBOutlet weak var lblFamilyValue: UILabel!
    @IBOutlet weak var lblCommunityValue: UILabel!
    @IBOutlet weak var lblFamilyStatus: UILabel!
    @IBOutlet weak var lblManglik: UILabel!
  //MARK:Outlets For Partner Expectation
    @IBOutlet weak var lblGeneralReq: UILabel!
    @IBOutlet weak var lblPartnerAge: UILabel!
    @IBOutlet weak var lblPartnerHeight: UILabel!
    @IBOutlet weak var lblPartnerWeight: UILabel!
    @IBOutlet weak var lblPartnerMaritalStatus: UILabel!
    @IBOutlet weak var lblChildAcceptance: UILabel!
    @IBOutlet weak var lblCountryOfRes: UILabel!
    @IBOutlet weak var lblPartnerCaste: UILabel!
    @IBOutlet weak var lblPartnerSubCaste: UILabel!
    @IBOutlet weak var lblPartnerEducation: UILabel!
    @IBOutlet weak var lblPartnerProfession: UILabel!
    @IBOutlet weak var lblDrinkingHabit: UILabel!
    @IBOutlet weak var lblSmokingHabit: UILabel!
    @IBOutlet weak var lblPartnerDiet: UILabel!
    @IBOutlet weak var lblBodyType: UILabel!
    @IBOutlet weak var lblPartnerPersonalValue: UILabel!
    @IBOutlet weak var lblPartnerManglik: UILabel!
    @IBOutlet weak var lblAnyDisability: UILabel!
    @IBOutlet weak var lblPartMotherTongue: UILabel!
    @IBOutlet weak var lblPartFamilyValue: UILabel!
    @IBOutlet weak var lblPartPreferedCountry: UILabel!
    @IBOutlet weak var lblPartPreferedState: UILabel!
    @IBOutlet weak var lblComplexion: UILabel!
    @IBOutlet weak var lblPreferedStatus: UILabel!
  //MARK:Outlets For Buttons
    @IBOutlet weak var btnExpressInterest: UIButton!
    @IBOutlet weak var btnShortlisted: UIButton!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var btnEnableMessaging: UIButton!
    @IBOutlet weak var btnIgnore: UIButton!
    @IBOutlet weak var btnReported: UIButton!
    
    var recentVisitorID = ""
    var getMemberData:MemberDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiMemberData()
       
    }
    override func viewWillAppear(_ animated: Bool) {
                  DispatchQueue.main.async {
                      self.setNavigationbarThemeGradientColor()
                  }
                   navigationController?.navigationBar.isHidden = false
                   setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
                   title = "Profile Details"
          }
          //MARK: Back Button Action
          override func backBtnTapAction() {
                self.navigationController?.popViewController(animated: true)
          }
    
    //MARK:- DAta SEt For Member Details
    func dataSet() {
        lblFullName.text = "\(getMemberData?.firstName ?? "") \(getMemberData?.lastName ?? "")"
        if let url = URL(string: getMemberData?.profileImage ?? "") {
                   imgProfilePic.af_setImage(withURL: url)
               } else {
                  imgProfilePic.image = #imageLiteral(resourceName: "screen")
               }
               lblIntroduction.text = getMemberData?.introduction
               lblFirstName.text = getMemberData?.firstName
               lblLastName.text = getMemberData?.lastName
               lblGender.text = getMemberData?.gender
               
               lblAge.text = "\(getMemberData?.age ?? 0)"
               lblChildren.text = getMemberData?.basicInfo?.numberOfChildren
               lblSelf.text = getMemberData?.basicInfo?.onBehalf
               lblDateOfBirth.text = getMemberData?.dateOfBirth
               lblMaritalStatus.text = getMemberData?.basicInfo?.maritalStatus
               lblCountry.text = getMemberData?.presentAddress?.country
               lblState.text = getMemberData?.presentAddress?.state
               lblCity.text = getMemberData?.presentAddress?.city
               lblPostalCode.text = getMemberData?.presentAddress?.postalCode
                
               lblHighestEducation.text = getMemberData?.educationAndCareer?.highestEducation
               lblOccupation.text = getMemberData?.educationAndCareer?.occupation
               lblAnnualIncome.text = getMemberData?.educationAndCareer?.annualIncome
               
               lblReligion.text = getMemberData?.spiritualAndSocialBackground?.religion
               lblCaste.text = getMemberData?.spiritualAndSocialBackground?.caste
              
               lblEthnicity.text = getMemberData?.spiritualAndSocialBackground?.ethnicity
               lblPersonalValue.text = getMemberData?.spiritualAndSocialBackground?.personalValue
              
               lblCommunityValue.text = getMemberData?.spiritualAndSocialBackground?.communityValue
               
               lblManglik.text = getMemberData?.spiritualAndSocialBackground?.uManglik
               
              // lblGeneralReq.text = getMemberData?.partnerExp
               lblPartnerAge.text = getMemberData?.partnerExp?.partnerAge
               lblPartnerHeight.text = getMemberData?.partnerExp?.partnerHeight
              //lblPartnerWeight.text = getMemberData?.partnerExp?
               lblPartnerMaritalStatus.text = getMemberData?.partnerExp?.partnerMaritalStatus
               lblChildAcceptance.text = ""
             //  lblCountryOfRes.text = getMemberData?.partnerExp?.
               lblPartnerCaste.text = getMemberData?.partnerExp?.partnerCaste
              // lblPartnerSubCaste.text = getMemberData?.partnerExp?
               lblPartnerEducation.text = getMemberData?.partnerExp?.partnerEducation
               lblPartnerProfession.text = getMemberData?.partnerExp?.partnerProfession
               lblDrinkingHabit.text = getMemberData?.partnerExp?.partnerDrink
               lblSmokingHabit.text = getMemberData?.partnerExp?.partnerSmoke
               lblPartnerDiet.text = getMemberData?.partnerExp?.partnerDiet
               lblBodyType.text = getMemberData?.partnerExp?.partnerBodyType
             //  lblPartnerPersonalValue.text = getMemberData?.partnerExp?.
               lblPartnerManglik.text = getMemberData?.partnerExp?.manglik
              // lblAnyDisability.text = getMemberData?.partnerExp?.
               lblPartMotherTongue.text = getMemberData?.partnerExp?.partnerMotherTongue
           //    lblPartFamilyValue.text = getMemberData?.partnerExp?.
               lblPartPreferedCountry.text = getMemberData?.partnerExp?.preferedCountry
               lblPartPreferedState.text = getMemberData?.partnerExp?.preferedState
               lblComplexion.text = getMemberData?.partnerExp?.partnerComplexion
             //  lblPreferedStatus.text = getMemberData?.partnerExp?.
            if getMemberData?.interestExpress == "1" {
                  btnExpressInterest.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                  btnExpressInterest.setTitle("Expressed Interest", for: .normal)
            } else {
                  btnExpressInterest.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
                  btnExpressInterest.setTitle("Express Interest", for: .normal)
            }
             if getMemberData?.isShortlisted == "1" {
                 btnShortlisted.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                 btnShortlisted.setTitle("Shortlisted", for: .normal)
            } else {
                 btnShortlisted.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
                 btnShortlisted.setTitle("Shortlist", for: .normal)
            }
             if getMemberData?.isFollow == "1" {
                 btnFollow.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                 btnFollow.setTitle("Followed", for: .normal)
             } else {
                 btnFollow.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
                 btnFollow.setTitle("Follow", for: .normal)
             }
            if getMemberData?.enableMessage == "1" {
                 btnEnableMessaging.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                 btnEnableMessaging.setTitle("Messaging Enabled", for: .normal)
            } else {
                 btnEnableMessaging.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
                 btnEnableMessaging.setTitle("Enable Messaging", for: .normal)
            }
           
           if getMemberData?.isReported == "1" {
                btnReported.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                btnReported.setTitle("Reported", for: .normal)
           } else {
                 btnReported.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
                 btnReported.setTitle("Report", for: .normal)
           }
               
    }
//MARK:- All Buttons Functionality
    @IBAction func btnFunctionality(_ sender: UIButton) {
        btnClicked(sender)
    }
    

}
//MARK:- Functions For Button Action
extension ViewDetailsVC {
    func btnClicked (_ Sender: UIButton) {
        
        switch Sender.tag {
         case 1:
//            btnExpressInterest.isSelected = !btnExpressInterest.isSelected
//
//            if (btnExpressInterest.isSelected)
//            {
//                btnExpressInterest.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                btnExpressInterest.setTitle("Expressed Interest", for: .normal)
                 apiAddInterest()
//            }
//            else
//            {
//                btnExpressInterest.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
//                btnExpressInterest.setTitle("Express Interest", for: .normal)
//            }
                   
              
         case 2:
//           btnShortlisted.isSelected = !btnShortlisted.isSelected
//
//           if (btnShortlisted.isSelected)
//           {
//                btnShortlisted.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                btnShortlisted.setTitle("Shortlisted", for: .normal)
                apiAddShortlist()
               // apiMemberData()
//           }
//           else
//           {
//                btnShortlisted.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
//                btnShortlisted.setTitle("Shortlist", for: .normal)
//           }
                   
                
         case 3:
//            btnFollow.isSelected = !btnFollow.isSelected
//
//            if (btnFollow.isSelected)
//            {
//               btnFollow.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//               btnFollow.setTitle("Followed", for: .normal)
               apiAddFollow()
//            }
//            else
//            {
//               btnFollow.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
//               btnFollow.setTitle("Follow", for: .normal)
//            }
                   
                
          case 4:
//            btnIgnore.isSelected = !btnIgnore.isSelected
//
//            if (btnIgnore.isSelected)
//            {
//                btnIgnore.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                btnIgnore.setTitle("Ignored", for: .normal)
//                apiAddIgnore()
//            }
//            else
//            {
//                btnIgnore.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
//                btnIgnore.setTitle("Ignore", for: .normal)
//            }
                  apiEnableMessage()
                
          case 5:
            btnIgnore.isSelected = !btnIgnore.isSelected

                if (btnIgnore.isSelected)
                {
                    btnIgnore.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    btnIgnore.setTitle("Ignored", for: .normal)
                    apiAddIgnore()
                }
                else
                {
                    btnIgnore.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
                    btnIgnore.setTitle("Ignore", for: .normal)
                }
         case 6:
//            btnReported.isSelected = !btnReported.isSelected
//
//            if (btnReported.isSelected)
//            {
//                btnReported.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                btnReported.setTitle("Reported", for: .normal)
                apiReportMember()
//            }
//            else
//            {
//                btnReported.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.07450980392, blue: 0.3019607843, alpha: 1)
//                btnReported.setTitle("Report", for: .normal)
//            }
                     
                
        default:
            break
        }
    }
}
//MARK:- Api Calling for Report Member
extension ViewDetailsVC {
  func apiReportMember() {
       guard let id = MemberModel.getMemberModel()?.memberID else {
           return
       }
    let  param:[String:Any] = ["member_id":id,"report_member": self.recentVisitorID]
     print(param)
       if let getRequest = API.ADDREPORT.request(method: .post, with: param, forJsonEncoding: true){
           Global.showLoadingSpinner()
           getRequest.responseJSON { response in
               Global.dismissLoadingSpinner()
               API.ADDREPORT.validatedResponse(response, completionHandler: { (jsonObject, error) in
                   guard  error == nil else {
                       return
                   }
                   guard jsonObject?["status"] as? Int == 1 else {
                       Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                       return
                   }
                self.apiMemberData()
                   Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
               })
           }
       }
   }
    
 //MARK:- Api Calling for Report Member
    func apiAddInterest() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
      let  param:[String:Any] = ["member_id":id,"interest_member_id": self.recentVisitorID]
      print(param)
        if let getRequest = API.ADDINTEREST.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.ADDINTEREST.validatedResponse(response, completionHandler: { (jsonObject, error) in
                    guard  error == nil else {
                        return
                    }
                    guard jsonObject?["status"] as? Int == 1 else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                     self.apiMemberData()
                    Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                })
            }
        }
    }
    
//MARK:- Api Calling for Add Shortlist
    func apiAddShortlist() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        if getMemberData?.isShortlisted == "0" {
            let  param:[String:Any] = ["member_id":id,"shortlist_member": self.recentVisitorID ]
            print(param)
            if let getRequest = API.ADDSHORTLIST.request(method: .post, with: param, forJsonEncoding: true){
                   Global.showLoadingSpinner()
                   getRequest.responseJSON { response in
                       Global.dismissLoadingSpinner()
                       API.ADDSHORTLIST.validatedResponse(response, completionHandler: { (jsonObject, error) in
                           guard  error == nil else {
                               return
                           }
                           guard jsonObject?["status"] as? Int == 1 else {
                               Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                               return
                           }
                           Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                          self.apiMemberData()
                       })
                      
                   }
               }
        } else {
            let  param:[String:Any] = ["member_id":id,"unshort_member_id": self.recentVisitorID ]
            print(param)
            if let getRequest = API.REMOVESHORTLIST.request(method: .post, with: param, forJsonEncoding: true){
                   Global.showLoadingSpinner()
                   getRequest.responseJSON { response in
                       Global.dismissLoadingSpinner()
                       API.REMOVESHORTLIST.validatedResponse(response, completionHandler: { (jsonObject, error) in
                           guard  error == nil else {
                               return
                           }
                           guard jsonObject?["status"] as? Int == 1 else {
                               Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                               return
                           }
                           Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                         self.apiMemberData()
                       })
                   }
               }
        }
    }
    
  //MARK:- Api Calling for Add Ignore
    func apiAddIgnore() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
      let  param:[String:Any] = ["member_id":id,"ignore_member": self.recentVisitorID ]
      print(param)
        if let getRequest = API.ADDIGNORE.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.ADDIGNORE.validatedResponse(response, completionHandler: { (jsonObject, error) in
                    guard  error == nil else {
                        return
                    }
                    guard jsonObject?["status"] as? Int == 1 else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                   self.apiMemberData()
                    Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                })
            }
        }
    }
    
//MARK:- Api Calling for Message Enable
    func apiEnableMessage() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
      let  param:[String:Any] = ["member_id":id,"message_to_member": self.recentVisitorID ]
      print(param)
        if let getRequest = API.MESSAGEENABLE.request(method: .post, with: param, forJsonEncoding: true){
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.MESSAGEENABLE.validatedResponse(response, completionHandler: { (jsonObject, error) in
                    guard  error == nil else {
                        return
                    }
                    guard jsonObject?["status"] as? Int == 1 else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                    self.apiMemberData()
                    Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                })
            }
        }
    }
    
  //MARK:- Api Calling for Add Follow
    func apiAddFollow() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        if getMemberData?.isFollow == "0"{
            let  param:[String:Any] = ["member_id":id,"follow_member_id": self.recentVisitorID ]
                 print(param)
                   if let getRequest = API.ADDFOLLOW.request(method: .post, with: param, forJsonEncoding: true){
                       Global.showLoadingSpinner()
                       getRequest.responseJSON { response in
                           Global.dismissLoadingSpinner()
                           API.ADDFOLLOW.validatedResponse(response, completionHandler: { (jsonObject, error) in
                               guard  error == nil else {
                                   return
                               }
                               guard jsonObject?["status"] as? Int == 1 else {
                                   Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                                   return
                               }
                               
                               Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                           })
                           self.apiMemberData()
                       }
                   }
        } else {
            let  param:[String:Any] = ["member_id":id,"unfollow_member_id": self.recentVisitorID ]
            print(param)
              if let getRequest = API.REMOVEFOLLOW.request(method: .post, with: param, forJsonEncoding: true){
                  Global.showLoadingSpinner()
                  getRequest.responseJSON { response in
                      Global.dismissLoadingSpinner()
                      API.REMOVEFOLLOW.validatedResponse(response, completionHandler: { (jsonObject, error) in
                          guard  error == nil else {
                              return
                          }
                          guard jsonObject?["status"] as? Int == 1 else {
                              Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                              return
                          }
                          self.apiMemberData()
                          Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                      })
                  }
              }
        }
     
    }
    
//MARK:- API CAlling For Recent Visitors
      func apiMemberData() {
          guard let id = MemberModel.getMemberModel()?.memberID else {
              return
          }
        let param: [String: Any] = ["member_id": id,"match_member_id": recentVisitorID]
          print(param)
          if let getRequest = API.GETMEMBERDETAILS.request(method: .post, with: param, forJsonEncoding: false) {
              Global.showLoadingSpinner()
              getRequest.responseJSON { response in
                  Global.dismissLoadingSpinner()
                  API.GETMEMBERDETAILS.validatedResponse(response, completionHandler: { (jsonObject,error) in
                      guard error == nil else {
                          return
                      }
                      guard let getData = jsonObject?["data"] as? [String:Any] else {
                          Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                          return
                      }
                      do{
                          let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
                          let decoder = JSONDecoder()
                          self.getMemberData = try decoder.decode(MemberDetailsModel.self, from: jsonData)
                        print(self.getMemberData ?? "")
                        self.dataSet()
                      } catch let err{
                          print("Err", err)
                      }
                  })
              }
          }
      }
}
