//
//  Hobbies&InterestVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 12/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class Hobbies_InterestVC: UIViewController {

     var labelTitles : [String] = ["Hobby","Interest","Music","Books","Movie","TV Show","Sports Show","Fitness Activity","Cuisine","Dress Style"]
    var getHobbiesAndinterest: HobbiesInterestModel?
    var strHobby: String?
    var strInterest: String?
    var strMusic: String?
    var strBooks: String?
    var strMovie: String?
    var strTVShow: String?
    var strSportsShow: String?
    var strFitnessActivity: String?
    var strCusine: String?
    var strDressstyle: String?
  
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiHobbiesInterest()

    }
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async {
                self.setNavigationbarThemeGradientColor()
            }
             navigationController?.navigationBar.isHidden = false
             setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
             title = "Hobbies And Interest"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
          self.navigationController?.popViewController(animated: true)
    }
//MARK:- Update Button Action
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        
       let index0 = IndexPath(row: 0, section: 0)
       let hobbyCell = tableView.cellForRow(at: index0)! as! HobbiesTableCell
       
       let index1 = IndexPath(row: 1, section: 0)
       let interestCell =  tableView.cellForRow(at: index1)! as! HobbiesTableCell
       
       let index2 = IndexPath(row: 2, section: 0)
       let musicCell =  tableView.cellForRow(at: index2)! as! HobbiesTableCell
       
       let index3 = IndexPath(row: 3, section: 0)
       let booksCell = tableView.cellForRow(at: index3)! as! HobbiesTableCell
       
       let index4 = IndexPath(row: 4, section: 0)
       let movieCell =  tableView.cellForRow(at: index4)! as! HobbiesTableCell
       
       let index5 = IndexPath(row: 5, section: 0)
       let tvShowcell =  tableView.cellForRow(at: index5)! as! HobbiesTableCell
       
       let index6 = IndexPath(row: 6, section: 0)
       let sportsShowCell = tableView.cellForRow(at: index6)! as! HobbiesTableCell
       
       let index7 = IndexPath(row: 7, section: 0)
       let fitnessActiveCell =  tableView.cellForRow(at: index7)! as! HobbiesTableCell
       
       let index8 = IndexPath(row: 8, section: 0)
       let cusineCell =  tableView.cellForRow(at: index8)! as! HobbiesTableCell
       
       let index9 = IndexPath(row: 8, section: 0)
       let dressStyleCell =  tableView.cellForRow(at: index9)! as! HobbiesTableCell
      
       strHobby = hobbyCell.tfTitlesDataInput.text!
       strInterest = interestCell.tfTitlesDataInput.text!
       strMusic = musicCell.tfTitlesDataInput.text!
       strBooks = booksCell.tfTitlesDataInput.text!
       strMovie = movieCell.tfTitlesDataInput.text!
       strTVShow = tvShowcell.tfTitlesDataInput.text!
       strSportsShow = sportsShowCell.tfTitlesDataInput.text!
       strFitnessActivity = fitnessActiveCell.tfTitlesDataInput.text!
       strCusine = cusineCell.tfTitlesDataInput.text!
       strDressstyle = dressStyleCell.tfTitlesDataInput.text!
       apiHobbiesInterestUpdate()
    }
}
//MARK:- TableView Datasource Methods
extension Hobbies_InterestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HobbiesTableCell") as! HobbiesTableCell
        cell.lblTitles.text = labelTitles[indexPath.row]
        cell.tfTitlesDataInput.setPadding(left: 10)
        switch indexPath.row {
        case 0:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.hobby
        case 1:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.interest
        case 2:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.music
        case 3:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.books
        case 4:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.movie
        case 5:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.tvShow
        case 6:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.sportsShow
        case 7:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.fitnessActivity
        case 8:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.cuisine
        case 9:
            cell.tfTitlesDataInput.text = getHobbiesAndinterest?.dressStyle
        default:
            break
        }
        return cell
    }
}
//MARK:- TableView Delegates Methods
extension Hobbies_InterestVC: UITableViewDelegate {
    
    
}
//MARK:- TableView Cell Class
class HobbiesTableCell: UITableViewCell {
    
    @IBOutlet weak var lblTitles: UILabel!
    @IBOutlet weak var tfTitlesDataInput: UITextField!
}

//MARK:- api calling for Getting Hobbies And Interest
extension Hobbies_InterestVC {
    func apiHobbiesInterest() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        if let getRequest = API.HOBBIESINTEREST.request(method: .post, with: ["member_id":id], forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
            Global.dismissLoadingSpinner()
                API.HOBBIESINTEREST.validatedResponse(response, completionHandler: {(jsonObject, error) in
                    guard error == nil else {
                        return
                    }
                    
                    guard jsonObject?["status"] as? Int == 1 else {
                    Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                      return
                    }
                    
                    guard let getData = jsonObject?["data"] as? [String: Any] else {
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                        return
                    }
                    do{
                        let jsonData = try JSONSerialization.data(withJSONObject: getData, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        self.getHobbiesAndinterest = try decoder.decode(HobbiesInterestModel.self, from: jsonData)
                        print(self.getHobbiesAndinterest ?? "")
                        self.tableView.reloadData()
                     }  catch let err {
                           print("Err", err)
                       }
                    
                })
            }
            
        }
    }
    
    //MARK:- calling Update Api for Hobbies And interest
        func apiHobbiesInterestUpdate() {
            guard let id = MemberModel.getMemberModel()?.memberID else {
                return
            }
          let  param:[String:Any] = ["member_id":id, "hobby":strHobby ?? "", "interest":strInterest ?? "", "music":strMusic ?? "","books":strBooks ?? "","movie":strMovie ?? "","tv_show":strTVShow ?? "","sports_show":strSportsShow ?? "","fitness_activity":strFitnessActivity ?? "", "cuisine":strCusine ?? "","dress_style":strDressstyle ?? ""]
          
            if let getRequest = API.UPDATEHOBBIESINTEREST.request(method: .post, with: param, forJsonEncoding: true){
                Global.showLoadingSpinner()
                getRequest.responseJSON { response in
                    Global.dismissLoadingSpinner()
                    API.UPDATEHOBBIESINTEREST.validatedResponse(response, completionHandler: { (jsonObject, error) in
                        guard  error == nil else {
                            return
                        }
                        guard jsonObject?["status"] as? Int == 1 else {
                            Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .error)
                            return
                        }
                        Common.showAlertMessage(message: jsonObject?["message"] as? String ?? "", alertType: .success)
                        self.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }
    
}
