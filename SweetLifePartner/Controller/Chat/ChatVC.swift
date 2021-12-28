//
//  ChatVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 20/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatTable: UITableView!
    
    var StrSelectedValue : String = "Recent"
    var getRecentChatData = [RecentChatModelElement]()
    var profilePhoto:String?
    var profileName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiRecentChat()
        self.chatTable.tableFooterView = UIView()
       

        chatTable.delegate = self
        chatTable.dataSource = self
        
        chatTable.rowHeight = UITableView.automaticDimension
        chatTable.estimatedRowHeight = 110
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
      self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getRecentChatData.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentChatTableCell", for: indexPath) as! RecentChatTableCell
            if let url = URL(string: getRecentChatData[indexPath.row].profile ?? "") {
                cell.imgChatPerson.af_setImage(withURL: url)
            } else {
                cell.imgChatPerson.image = #imageLiteral(resourceName: "screen")
            }
            cell.lblName.text = getRecentChatData[indexPath.row].chatMemberName
            cell.lblMessage.text = getRecentChatData[indexPath.row].message
            cell.lblDesignation.text = ""
            return cell
            
        }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
              return 110.0
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatScreenVC") as! ChatScreenVC
         vc.msgThreadID = self.getRecentChatData[indexPath.row].messageThreadID
         vc.image = profilePhoto
         vc.name = profileName
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
 //MARK:- API CAlling For Recent Chat
extension ChatVC {
    func apiRecentChat() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let param: [String: Any] = ["member_id": id]
        print(param)
        if let getRequest = API.GETRECENTCHATS.request(method: .post, with: param, forJsonEncoding: false) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.GETRECENTCHATS.validatedResponse(response, completionHandler: { (jsonObject,error) in
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
                        self.getRecentChatData = try decoder.decode([RecentChatModelElement].self, from: jsonData)
                        for (index,_) in self.getRecentChatData.enumerated() {
                            self.profilePhoto = self.getRecentChatData[index].profile
                            self.profileName = self.getRecentChatData[index].chatMemberName
                        }
                        self.chatTable.reloadData()
                        print(self.getRecentChatData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                })
            }
        }
    }
}

