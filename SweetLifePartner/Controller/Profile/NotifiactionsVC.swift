//
//  NotifiactionsVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 10/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class NotifiactionsVC: UIViewController {
     
    var getNotificationsData = [NotificationModel]()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiNotifications()
    }
    override func viewWillAppear(_ animated: Bool) {
               DispatchQueue.main.async {
                   self.setNavigationbarThemeGradientColor()
               }
                navigationController?.navigationBar.isHidden = true
                setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
                title = "Notifications"
       }
    //MARK: Back Button Action
       override func backBtnTapAction() {
             self.navigationController?.popViewController(animated: true)
       }

}
//MARK:- Tableview Datasource Methods
extension NotifiactionsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNotificationsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableCell") as! NotificationTableCell
        if let url = URL(string: getNotificationsData[indexPath.row].profileImage ?? "" ) {
            cell.imgNotificationcell.af_setImage(withURL: url)
           } else {
               cell.imgNotificationcell.image = #imageLiteral(resourceName: "screen")
           }
        cell.lblNotificationTime.text = getNotificationsData[indexPath.row].time
        cell.lblNotificationText.text = "\(getNotificationsData[indexPath.row].by ?? "") has viewed your Invitation"
        return cell
    }
}
//MARK:- Tableview Delegates Methods
extension NotifiactionsVC: UITableViewDelegate{
    
}
//MARK:- Table view Class
class NotificationTableCell: UITableViewCell {
    
    @IBOutlet weak var lblNotificationTime: UILabel!
    @IBOutlet weak var lblNotificationText: UILabel!
    @IBOutlet weak var imgNotificationcell: UIImageView!
}

extension NotifiactionsVC {
    //MARK:- API CAlling For Notifications
    func apiNotifications() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let param: [String: Any] = ["member_id": id]
        print(param)
        if let getRequest = API.GETNOTIFICATIONS.request(method: .post, with: param, forJsonEncoding: false) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
               API.GETNOTIFICATIONS.validatedResponse(response, completionHandler: {(jsonObject, error) in
                guard error == nil else {
                    return
                }
                
                guard jsonObject?["status"] as? Int == 1 else {
                Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                  return
                }
                    guard let getData = jsonObject?["data"] as? [[String:Any]] else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        self.getNotificationsData = try decoder.decode([NotificationModel].self, from: jsonData)
                        self.tableView.reloadData()
                        print(self.getNotificationsData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                })
            }
        }
    }
}

