//
//  PrefProfessionVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 09/05/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PrefProfessionVC: UIViewController {
    
    var UserNameArr = ["Varun T","Tarun T","Arjun T","XXXXX","Suneel T","Hansa T"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: BaseView!
    @IBOutlet weak var bkgViewImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        headerView.delegate = self
        bkgViewImage.isHidden = true
    }
    
}
// MARK: - Table view data source Methods
extension PrefProfessionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrefProfessionTableCell") as! PrefProfessionTableCell
        cell.lblUserName.text = UserNameArr[indexPath.row]
        return cell
    }
    
}
// MARK: - Table view delegates methods
extension PrefProfessionVC: UITableViewDelegate {
    
}

//MARK:- Table View Cell Classes
class PrefProfessionTableCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblProfession: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var imgProfileImage: UIImageView!
    
}
//MARK:- Calling the protocol delegates for custom view buttons
extension PrefProfessionVC : CellDelegate {
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


