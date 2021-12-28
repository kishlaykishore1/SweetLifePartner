//
//  RecentlyViewedVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 18/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class RecentlyViewedVC: UIViewController {
    
    var UserNameArr = ["Varun T","Tarun T","Arjun T","XXXXX","Suneel T","Hansa T"]
    
    @IBOutlet weak var headerView: BaseView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        headerView.delegate = self
    }
    
}
// MARK: - Table view data source Methods
extension RecentlyViewedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentViewsTableCell") as! RecentViewsTableCell
        cell.lblUserName.text = UserNameArr[indexPath.row]
        return cell
    }
    
}
// MARK: - Table view delegates methods
extension RecentlyViewedVC: UITableViewDelegate {
    
}

//MARK:- Table View Cell Classes
class RecentViewsTableCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    
}
//MARK:- Calling the protocol delegates for custom view buttons
extension RecentlyViewedVC : CellDelegate {
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
            let vc = storyboard?.instantiateViewController(withIdentifier: "RecentlyViewedVC") as! RecentlyViewedVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        case 6 :
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyFollowerVC") as! MyFollowerVC
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        default:
            print("You Are done")
            break
        }
        
    }
}
