//
//  Help&SupportVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 23/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class Help_SupportVC: UIViewController {
    
    var pickerView : UIPickerView?
    var issueTypesArr = ["Choose one","Contacting My Matches","My Profile And Photos related","My partner Search","Registration And Login","Membership Plans & Payments","Refund","Privacy & Confidentiality","Product Feedback","Report abuse/misuse","Other"]
   //MARK: Outlets for Text fields and Text View
    @IBOutlet weak var tfIssueType: UITextField!
    @IBOutlet weak var tvIssueDescription: UITextView!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        tfIssueType.inputView = pickerView
        tvIssueDescription.delegate = self
        self.pickerView = pickerView
        tfIssueType.text = issueTypesArr[self.pickerView?.selectedRow(inComponent: 0) ?? 0]
        //setRightImage()
    }
    //MARK: Apperance of View (Navigation bar code)
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
          self.setNavigationbarThemeGradientColor()
        }
        navigationController?.navigationBar.isHidden = false
        setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), isImage: true)
        title = "Help & Support"
        
    }
    //MARK: Navigation back button action
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
  //MARK:- submit button action
    @IBAction func btnSubmitPressed(_ sender: UIButton) {
    }
    //    func setRightImage() {
//
//        //let textfield = UITextField()
//
//        let rightButton = UIButton(type: .custom)
//            rightButton.setImage(UIImage(named: "Blackarrow"), for: .normal)
//            rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
//            rightButton.frame = CGRect(x: CGFloat(tfIssueType.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
//            tfIssueType.rightView = rightButton
//            tfIssueType.rightViewMode = .always
//    }

}
//MARK:- UItextView Methods
extension Help_SupportVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if tvIssueDescription.textColor == UIColor.lightGray {
            tvIssueDescription.text = nil
            tvIssueDescription.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tvIssueDescription.text.isEmpty {
            tvIssueDescription.text = "Description"
            tvIssueDescription.textColor = UIColor.lightGray
        }
    }
}
//MARK:- UIPickerView Datasource Methods
extension Help_SupportVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return issueTypesArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return issueTypesArr[row]
    }
    
}
//MARK:- UIViewPicker Datasource Methods
extension Help_SupportVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if tfIssueType.isFirstResponder {
            let issues = issueTypesArr[row]
            tfIssueType.text = issues
        }
    }
}
