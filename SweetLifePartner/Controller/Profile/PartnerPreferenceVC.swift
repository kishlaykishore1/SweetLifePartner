//
//  PartnerPreferenceVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 10/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class PartnerPreferenceVC: UIViewController {

    var SearchArr = ["Age","Height","Marital status","Religion","Community","Mother Tongou","Country Living in","State Living in","Education and Career","Profession Area"]
    var PlaceholderArr = ["20-25","5.1-5.6","Choose One","Choose One","Choose One","Choose One","Choose One","Choose One","Education","Work"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async {
                self.setNavigationbarThemeGradientColor()
            }
             navigationController?.navigationBar.isHidden = false
             setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
             title = "Partner Preference"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
          self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
    }
}
//MARK:- TableView DataSource Methods
extension PartnerPreferenceVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrefPartnerTableCell") as! PrefPartnerTableCell
        cell.lblSearchFields.text = SearchArr[indexPath.row]
        cell.tfSearchFieldInputs.placeholder = PlaceholderArr[indexPath.row]
        return cell
    }
    
    
}
//MARK:- TableView Delegates methods
extension PartnerPreferenceVC: UITableViewDelegate {
    
}
//MARK:- Table View second Cell Class
class PrefPartnerTableCell: UITableViewCell {
    
    @IBOutlet weak var lblSearchFields: UILabel!
    @IBOutlet weak var tfSearchFieldInputs: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      tfSearchFieldInputs.delegate = self
       tfSearchFieldInputs.setPadding(left: 10.0)
    }
}

//MARK:- Setting TextField Delegates for change in border colour
extension PrefPartnerTableCell : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
            tfSearchFieldInputs.layer.borderWidth = 1
            tfSearchFieldInputs.layer.borderColor = #colorLiteral(red: 0.9960784314, green: 0.2039215686, blue: 0.431372549, alpha: 1)
     }
     
     func textFieldDidEndEditing(_ textField: UITextField) {
        tfSearchFieldInputs.layer.borderWidth = 1
        tfSearchFieldInputs.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
     }
}
