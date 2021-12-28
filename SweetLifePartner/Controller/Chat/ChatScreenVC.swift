//
//  ChatScreenVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 23/03/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class ChatScreenVC: UIViewController {

    @IBOutlet var NavImageView: UIView!
    @IBOutlet weak var txtTypeMsg: UITextField!
    @IBOutlet weak var btnLeftNavBar: UIBarButtonItem!
    @IBOutlet weak var ImgChatProfile: UIImageView!
    @IBOutlet weak var lblChatName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var getChatData = [ReceiveChatModel]()
    var msgThreadID = ""
    var msgID = ""
    let id = MemberModel.getMemberModel()?.memberID
    var image:String?
    var name:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     apiReceiveChat()
   // tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        let imageView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        imageView.contentMode = .scaleAspectFit
        imageView.addSubview(NavImageView)
        self.navigationItem.titleView = imageView
        txtTypeMsg.setLeftMargin(nil, padding: 10)
        
        if let url = URL(string: image ?? "") {
            ImgChatProfile.af_setImage(withURL: url)
        } else {
            ImgChatProfile.image = #imageLiteral(resourceName: "screen")
        }
        lblChatName.text = name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setNavigationbarThemeGradientColor()
        }
        self.navigationController?.isNavigationBarHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
       
    }
   
//MARK: Back Button Action
    override func backBtnTapAction() {
     // self.navigationController?.setNavigationBarHidden(false, animated: false)
      self.navigationController?.popViewController(animated: true)
    }
    
   
//MARK:-SEnd button Action
    @IBAction func btnSend(_ sender: UIButton) {
        apiSendmsg()
        tableView.reloadData()
        txtTypeMsg.text = ""
    }
}
//MARK:- TableView Receiver Cell Class
class ReceiverMsgCell: UITableViewCell {
    @IBOutlet weak var lblReceiveText: UILabel!
    
}
//MARK:- TableView Sender Cell Class
class SenderMsgCell: UITableViewCell {
    @IBOutlet weak var lblSenderText: UILabel!
    
}
//MARK: TableView DataSource Methods
extension ChatScreenVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return getChatData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.msgID = getChatData[indexPath.row].messageFrom
       
        if msgID == id {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderMsgCell", for: indexPath) as! SenderMsgCell
           // cell.transform = CGAffineTransform(scaleX: 1, y: -1)

            cell.lblSenderText.text = getChatData[indexPath.row].messageText
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverMsgCell", for: indexPath) as! ReceiverMsgCell
         //   cell.transform = CGAffineTransform(scaleX: 1, y: -1)

            cell.lblReceiveText.text = getChatData[indexPath.row].messageText
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
//MARK: TableView DataSource Methods
extension ChatScreenVC: UITableViewDelegate {

}

//MARK:- API CAlling For Get Chat
extension ChatScreenVC {
    func apiReceiveChat() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
                   return
               }
        let param: [String: Any] = ["member_id": id , "message_thread_id": msgThreadID]
        print(param)
        if let getRequest = API.RECEIVECHATLIST.request(method: .post, with: param, forJsonEncoding: false) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.RECEIVECHATLIST.validatedResponse(response, completionHandler: { (jsonObject,error) in
                    guard error == nil else {
                        return
                    }
                    guard let getData = jsonObject?["message"] as? [[String:Any]] else {
                       // Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        self.getChatData = try decoder.decode([ReceiveChatModel].self, from: jsonData)
                        self.tableView.reloadData()
                        print(self.getChatData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                })
            }
        }
    }
    
    //MARK:- API CAlling For send chat
       func apiSendmsg() {
           
        guard let id = MemberModel.getMemberModel()?.memberID else {
                          return
                      }
        let param: [String: Any] = ["member_id": id , "message_thread_id": msgThreadID,"message_to":msgID,"message_text": txtTypeMsg.text?.trim() ?? ""]
               print(param)
              if let getRequest = API.SENDCHAT.request(method: .post, with: param, forJsonEncoding: false) {
               print(param)
                  Global.showLoadingSpinner()
                  getRequest.responseJSON { response in
                      Global.dismissLoadingSpinner()
                      API.SENDCHAT.validatedResponse(response, completionHandler: { (jsonObject, error) in
                          guard error == nil else {
                              return
                          }
                          guard jsonObject?["status"] as? Int == 1 else {
                          Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                           return
                           }
                          Common.showAlertMessage(message: jsonObject?["message"]  as? String ?? "", alertType: .success)
                         self.apiReceiveChat()
                      
                      })

                  }
              }
          }
}

