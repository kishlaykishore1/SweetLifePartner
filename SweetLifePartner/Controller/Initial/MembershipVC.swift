//
//  MembershipVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 20/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit
import Braintree
import EsewaSDK

class MembershipVC: UIViewController {
    
    var braintreeClient: BTAPIClient!
    var sdk: EsewaSDK!
    var paymentTypeArr = ["Paypal","Esewa"]
    var param: [String: Any]!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        braintreeClient = BTAPIClient(authorization: "sandbox_w3bdjn6c_zdvjxr358kvmnjj3")
        sdk = EsewaSDK(inViewController: self, environment: .production, delegate: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //            DispatchQueue.main.async {
        //           self.setNavigationbarThemeGradientColor()
        //            }
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.04705882353, green: 0.5803921569, blue: 0.3882352941, alpha: 1)
        self.navigationItem.setHidesBackButton(true, animated: true);
        let skipButton: UIBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skip))
        skipButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.rightBarButtonItem = skipButton
        title = "PREMIUM MEMBERSHIP"
        tableView.tableFooterView = UIView()
    }
    //MARK:- Navigation Right button Action
    @objc func skip() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalDetailsVC") as! PersonalDetailsVC
        vc.param = param
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- Back Button Action
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Table view data source Methods
extension MembershipVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentTypeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MembershipTableCell") as! MembershipTableCell
        cell.lblPaymentType.text = paymentTypeArr[indexPath.row]
        return cell
    }
    
}
// MARK: - Table view delegates methods
extension MembershipVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
            payPalDriver.viewControllerPresentingDelegate = self
            payPalDriver.appSwitchDelegate = self // Optional
            
            // Specify the transaction amount here. "2.32" is used in this example.
            let request = BTPayPalRequest(amount: "2.32")
            request.currencyCode = "USD" // Optional; see BTPayPalRequest.h for more options
            
            payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                    print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                    
                    // Access additional information
                    let email = tokenizedPayPalAccount.email
                    debugPrint(email)
                    let firstName = tokenizedPayPalAccount.firstName
                    debugPrint(firstName)
                    let lastName = tokenizedPayPalAccount.lastName
                    let phone = tokenizedPayPalAccount.phone
                    
                    // See BTPostalAddress.h for details
                    let billingAddress = tokenizedPayPalAccount.billingAddress
                    let shippingAddress = tokenizedPayPalAccount.shippingAddress
                } else if let error = error {
                    // Handle error here...
                } else {
                    // Buyer canceled payment approval
                }
            }
        } else if (indexPath.row) == 1 {
            //  sdk = EsewaSDK(inViewController: self, environment: .development, delegate: self)
            sdk.initiatePayment(merchantId: "NgMEBQpTKAoVCRYGAwgcBUVURSASEgQHSykQAxZFJwABHwscF0krJ0w2OEgqNTI3PCI8Jyk8JicsOC8=", merchantSecret: "FgQAEhVTBwwfAA==", productName: "Test Product", productAmount: "10", productId: "10", callbackUrl: "https://sweetlifepartner.com/home/esewa_success?q=su")
            
        }
        
    }
}

//MARK:- Table view cell class
class MembershipTableCell: UITableViewCell {
    
    @IBOutlet weak var paymentTypeImage: UIImageView!
    @IBOutlet weak var lblPaymentType: UILabel!
}

//MARK:-Brain tree Delegate to open safari
extension MembershipVC : BTViewControllerPresentingDelegate {
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}

//MARK:-Braintree Delegates
extension MembershipVC : BTAppSwitchDelegate {
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}
//MARK:-Esewa Sdk Delegate
extension MembershipVC : EsewaSDKPaymentDelegate {
    func onEsewaSDKPaymentSuccess(info: [String : Any]) {
        
    }
    
    func onEsewaSDKPaymentError(errorDescription: String) {
        
    }
    
    
}
