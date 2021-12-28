//
//  AllButtonVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 08/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class AllButtonVC: UIViewController {
    
    
    @IBOutlet weak var headerView: BaseView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bkgViewImage: UIImageView!
   
    var allMatchesData = [MatchesModelElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        headerView.delegate = self
        bkgViewImage.isHidden = false
        tableView.isHidden = true
        apiAllMatches()
    }
}
//MARK: - Table view data source Methods
extension AllButtonVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMatchesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllButtonCell") as! AllButtonCell
        if let url = URL(string: allMatchesData[indexPath.row].image ?? "" ) {
            cell.imgProfileImage.af_setImage(withURL: url)
           } else {
               cell.imgProfileImage.image = #imageLiteral(resourceName: "mainImage")
           }
          let des = "\(allMatchesData[indexPath.row].firstName ?? "") \(allMatchesData[indexPath.row].lastName ?? "")"
          cell.lblUserName.text = des
        //  cell.lblProfession.text = newMatchesData[indexPath.row].
          let resData = "\(allMatchesData[indexPath.row].state ?? ""),\(allMatchesData[indexPath.row].country ?? "")"
          cell.lblAddress.text = resData
        return cell
    }
}
// MARK: - Table view delegates methods
extension AllButtonVC: UITableViewDelegate {
    
}

//MARK:- Table View Class
class AllButtonCell: UITableViewCell {
    
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblProfession: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var imgProfileImage: UIImageView!
}

//MARK: Calling the protocol delegates for custom view buttons
extension AllButtonVC : CellDelegate {
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

extension AllButtonVC {
//MARK:- API CAlling For All Matches i.e, my Matches
func apiAllMatches() {
    guard let id = MemberModel.getMemberModel()?.memberID else {
        return
    }
    let param: [String: Any] = ["member_id": id, "matches_type": "all"]
    print(param)
    if let getRequest = API.GETMATCHES.request(method: .post, with: param, forJsonEncoding: true) {
        Global.showLoadingSpinner()
        getRequest.responseJSON { response in
            Global.dismissLoadingSpinner()
            API.GETMATCHES.validatedResponse(response, completionHandler: { (jsonObject,error) in
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
                    self.allMatchesData = try decoder.decode([MatchesModelElement].self, from: jsonData)
                    if self.allMatchesData.count > 0 {
                        self.tableView.isHidden = false
                        self.bkgViewImage.isHidden = true
                    } else {
                        self.tableView.isHidden = true
                        self.bkgViewImage.isHidden = false
                    }
                    print(self.allMatchesData)

                } catch let err{
                    print("Err", err)
                }
            })
        }
    }
  }
}
