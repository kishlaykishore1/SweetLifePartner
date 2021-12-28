//
//  InboxVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 22/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class InboxVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var inboxTable: UITableView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    var arrMenu = [[String:String]]()
    var arrTopMenu = [TopMenuModel]()
    var StrSelectedValue : String = "received"
    var inboxData = [InboxModelElement]()
    var followedData = [FollowedMemberElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inboxApi(type: StrSelectedValue)
        navigationController?.navigationBar.isHidden = true
        arrMenu = [["title":"Received"],["title":"Accepted"],["title":"Sent Item"],["title":"Follow"],["title":"Ignore"]]
        
        arrTopMenu = arrMenu.map({dict in
            return TopMenuModel.init(dict: dict)
        })
        topCollectionView.reloadData()
        arrTopMenu[0].isSelected = true
        
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        
        self.inboxTable.reloadData()
        
    }
    
    // Collection View Delegate Method//
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTopMenu.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopTabsCollectionCell", for: indexPath) as! TopTabsCollectionCell
        
        let model =  arrTopMenu[indexPath.row]
        
        if model.isSelected{
            cell.lblName.text = model.title
            cell.lblName.textColor = UIColor.white
        }
        else{
            cell.lblName.text = model.title
            cell.lblName.textColor = UIColor.black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (index ,_) in arrMenu.enumerated(){
            arrTopMenu[index].isSelected = false
        }
        arrTopMenu[indexPath.row].isSelected = true
        topCollectionView.reloadData()
        let MyIndex = indexPath.row
        
        switch MyIndex {
        case 0:
            self.StrSelectedValue = "received"
            inboxApi(type: StrSelectedValue )
            self.inboxTable.reloadData()
        case 1:
            self.StrSelectedValue = "accepted"
            inboxApi(type: StrSelectedValue )
            self.inboxTable.reloadData()
        case 2:
            self.StrSelectedValue = "sent"
            inboxApi(type: StrSelectedValue )
            self.inboxTable.reloadData()
        case 3:
             self.StrSelectedValue = "followed"
             followedApi(type:StrSelectedValue)
             self.inboxTable.reloadData()
        case 4:
            self.StrSelectedValue = "ignore"
            self.inboxTable.reloadData()
        default:
            break
        }
    }
    
    //---Table View DeleGate Method---//
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if StrSelectedValue == "received"{
            return 1
        }
        else if StrSelectedValue == "accepted"{
            return 1
        }
        else if StrSelectedValue == "sent"{
            return 1
        }
        else if StrSelectedValue == "followed"{
            return 1
        }
        else if StrSelectedValue == "ignore"{
            return 1
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if StrSelectedValue == "received"{
            return inboxData.count
        }
        if StrSelectedValue == "accepted"{
            return inboxData.count
        }
        if StrSelectedValue == "sent"{
            return inboxData.count
        }
        if StrSelectedValue == "followed"{
            return followedData.count
        }
        if StrSelectedValue == "ignore"{
            return 10
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if StrSelectedValue == "accepted"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AcceptedTableCell", for:
                indexPath) as! AcceptedTableCell
             if let url = URL(string: inboxData[indexPath.row].image ) {
              cell.imgImage.af_setImage(withURL: url)
             } else {
                 cell.imgImage.image = #imageLiteral(resourceName: "mainImage")
             }
            let des = "\(inboxData[indexPath.row].firstName) \(inboxData[indexPath.row].lastName)"
            cell.lblName.text = des
            cell.lblPost.text = inboxData[indexPath.row].occupation
            let resData = "\(inboxData[indexPath.row].state),\(inboxData[indexPath.row].country)"
            cell.lblAddress.text = resData
            return cell
        }
        else if StrSelectedValue == "received" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecivedTableCell", for:
                indexPath) as! RecivedTableCell
            if let url = URL(string: inboxData[indexPath.row].image ) {
              cell.imgProfileImage.af_setImage(withURL: url)
             } else {
                 cell.imgProfileImage.image = #imageLiteral(resourceName: "mainImage")
             }
            let des = "\(inboxData[indexPath.row].firstName) \(inboxData[indexPath.row].lastName)"
            cell.lblName.text = des
            cell.lblPost.text = inboxData[indexPath.row].occupation
            let resData = "\(inboxData[indexPath.row].state),\(inboxData[indexPath.row].country)"
            cell.lblCity.text = resData
            return cell
        }
        else if StrSelectedValue == "sent" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AcceptedTableCell", for:
                indexPath) as! AcceptedTableCell
            if let url = URL(string: inboxData[indexPath.row].image ) {
              cell.imgImage.af_setImage(withURL: url)
             } else {
                 cell.imgImage.image = #imageLiteral(resourceName: "mainImage")
             }
            let des = "\(inboxData[indexPath.row].firstName) \(inboxData[indexPath.row].lastName)"
            cell.lblName.text = des
            cell.lblPost.text = inboxData[indexPath.row].occupation
            let resData = "\(inboxData[indexPath.row].state),\(inboxData[indexPath.row].country)"
            cell.lblAddress.text = resData
            return cell
        }
        else if StrSelectedValue == "followed" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecivedTableCell", for:
                indexPath) as! RecivedTableCell
            return cell
        }
        else if StrSelectedValue == "ignore" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AcceptedTableCell", for:
                indexPath) as! AcceptedTableCell
            return cell
        }
        return UITableViewCell()
    }
}
 //MARK:- API CAlling For Inbox
extension InboxVC {
   
    func inboxApi(type:String) {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let param: [String: Any] = ["member_id": id ,"request_type": type]
        print(param)
        if let getRequest = API.APIINBOX.request(method: .post, with: param, forJsonEncoding: false) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.APIINBOX.validatedResponse(response, completionHandler: { (jsonObject,error) in
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
                        self.inboxData = try decoder.decode([InboxModelElement].self, from: jsonData)
                        print(self.inboxData)
                    } catch let err{
                        print("Err", err)
                    }
                })
            }
        }
    }
  //MARK:- API CAlling For Followed
    func followedApi(type:String) {
           guard let id = MemberModel.getMemberModel()?.memberID else {
               return
           }
           let param: [String: Any] = ["member_id": id ,"request_type": type]
           print(param)
           if let getRequest = API.APIFOLLOWED.request(method: .post, with: param, forJsonEncoding: false) {
               Global.showLoadingSpinner()
               getRequest.responseJSON { response in
                   Global.dismissLoadingSpinner()
                   API.APIFOLLOWED.validatedResponse(response, completionHandler: { (jsonObject,error) in
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
                           self.followedData = try decoder.decode([FollowedMemberElement].self, from: jsonData)
                           print(self.followedData)
                       } catch let err{
                           print("Err", err)
                       }
                   })
               }
           }
       }
}

