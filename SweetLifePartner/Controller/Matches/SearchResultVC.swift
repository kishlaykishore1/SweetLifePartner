//
//  SearchResultVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 10/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var footerView: UIView!
   
    @IBOutlet weak var bkgViewImage: UIImageView!
   
    var getSearchedData = [SearchedModelElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        footerConfiguration()

        navigationController?.navigationBar.isHidden = true
        bkgViewImage.isHidden = true
    }
    
    @IBAction func btnGoBackPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true) {

            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    

    
}
//MARK:- To Set The Footer View Configuration
extension SearchResultVC {
    func footerConfiguration() {
        
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerView.frame.size.height)
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.frame = footerView.frame
    }
}

//MARK:- Table View Data source Methods
extension SearchResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getSearchedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as! SearchResultCell
        if let url = URL(string: getSearchedData[indexPath.row].image ?? "" ) {
          cell.imgProfileImage.af_setImage(withURL: url)
         } else {
             cell.imgProfileImage.image = #imageLiteral(resourceName: "mainImage")
         }
        let des = "\(getSearchedData[indexPath.row].firstName ?? "") \(getSearchedData[indexPath.row].lastName ?? "")"
        cell.lblUserName.text = des
        cell.lblProfession.text = getSearchedData[indexPath.row].occupation
        let resData = "\(getSearchedData[indexPath.row].state ?? ""),\(getSearchedData[indexPath.row].country ?? "")"
        cell.lblAddress.text = resData
        return cell
    }
}

//MARK:- Table view delegates methods
extension SearchResultVC: UITableViewDelegate {
    
}
//MARK:- Table view Cell class
class SearchResultCell: UITableViewCell {
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblProfession: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var imgProfileImage: UIImageView!
}





