//
//  PrefEducationVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 09/05/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PrefEducationVC: UIViewController {
    
   // var getPrefEducation = [FollowedMemberElement]()
    var UserNameArr = ["Varun T","Tarun T","Arjun T","XXXXX","Suneel T","Hansa T"]
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: BaseView!
    @IBOutlet weak var bkgViewImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        headerView.delegate = self
        bkgViewImage.isHidden = true
       // prefEduApi()
    }
    
}
// MARK: - Table view data source Methods
extension PrefEducationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrefEduTableCell") as! PrefEduTableCell
        cell.lblUserName.text = UserNameArr[indexPath.row]
        
        return cell
    }
    
}
// MARK: - Table view delegates methods
extension PrefEducationVC: UITableViewDelegate {
    
}

//MARK:- Table View Cell Classes
class PrefEduTableCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblProfession: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var imgProfileImage: UIImageView!
    
}
//MARK:- Calling the protocol delegates for custom view buttons
extension PrefEducationVC : CellDelegate {
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
//// MARK:- Api calling
//extension PrefEducationVC {
//    //MARK:- API CAlling For Followed
//    func prefEduApi() {
//           guard let id = MemberModel.getMemberModel()?.memberID else {
//               return
//           }
//           let param: [String: Any] = ["member_id": id ,"request_type": "short_list"]
//           print(param)
//           if let getRequest = API.APIFOLLOWED.request(method: .post, with: param, forJsonEncoding: false) {
//               Global.showLoadingSpinner()
//               getRequest.responseJSON { response in
//                   Global.dismissLoadingSpinner()
//                   API.APIFOLLOWED.validatedResponse(response, completionHandler: { (jsonObject,error) in
//                       guard error == nil else {
//                           return
//                       }
//                       guard let getData = jsonObject?["data"] as? [[String:Any]] else {
//                           Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
//                           return
//                       }
//                       do{
//                           let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
//                           let decoder = JSONDecoder()
//                           self.getPrefEducation = try decoder.decode([FollowedMemberElement].self, from: jsonData)
//                           if self.getPrefEducation.count > 0 {
//                               self.tableView.isHidden = false
//                               self.bkgViewImage.isHidden = true
//                           } else {
//                               self.tableView.isHidden = true
//                               self.bkgViewImage.isHidden = false
//                           }
//                           print(self.getPrefEducation)
//                       } catch let err{
//                           print("Err", err)
//                       }
//                   })
//               }
//           }
//       }
//}

