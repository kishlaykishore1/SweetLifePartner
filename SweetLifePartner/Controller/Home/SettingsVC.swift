import UIKit
import IQKeyboardManagerSwift
import MessageUI
import AlamofireImage
import StoreKit
//import FirebaseAuth

class SettingsVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var btnProfileImg: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var navBarBtnEnRegister: UIBarButtonItem!
    @IBOutlet weak var navBarBtnBack: UIBarButtonItem!
    
    //MARK: PRIVATE PROPERTIES
    var sections: [String] = ["Basic Info","My Profile"]
    var section0Titles : [String] = ["","","","","",""]
    var section0placeHolder : [String] = ["","Votre entreprise","Adresse de votre société","Votre email","Votre téléphone",""]
    var section0Images :  [String] = ["user","hastag","address","mail","phone","eco"]
   
    var section2Titles : [String] = ["Nous suivre sur Facebook","Nous suivre sur Instagram", "Voir notre site internet","Notez l’application !","Signaler un bug","Nous contacter","Conditions Générales d’Utilisation","Confidentialité"]
    var section2Images :  [String] = ["fb_setting","instagram","world","premium","bug","speech","signing","padlock"]
    private var returnKeyHandler : IQKeyboardReturnKeyHandler!
    
    private var firstName = ""
    private var lastName = ""
    private var noOfCar = ""
    private var carName = ""
    private var isPasserPremium = true
    private var isNewRequest = true
    private var isWarnedFirst = false
    private var isNewInApp = true
    private var isBasicUser = false
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setUserProfile()
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyType.done
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setNavigationBarImage(for: nil, color: .clear)
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.9137254902, green: 0.1176470588, blue: 0.3882352941, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.4235294118, blue: 0.6156862745, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.4235294118, blue: 0.6156862745, alpha: 1)])
        self.title = "Edit Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 16)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navBarBtnEnRegister.setTitleTextAttributes (
            [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .normal)
        navBarBtnBack.setTitleTextAttributes (
            [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 16)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .normal)
//        self.lblVersion.text = Constants.kAppDelegate.appVersion
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: fillUserDataFromDefualt
    private func setUserProfile() {
//        if let userData = UserModel.getUserModel() {
//            if let getProfileUrl = userData.image.makeUrl() {
//                self.btnProfileImg.af_setImage(for: .normal, url: getProfileUrl)
//                self.btnProfileImg.imageView?.contentMode = .scaleAspectFill
//            }
//            section0Titles = ["",userData.companyName,userData.address,userData.email,userData.phone,""]
//            self.firstName = userData.firstName
//            self.lastName = userData.lastName
//            self.noOfCar = userData.vahicleNumber
//            self.carName = userData.vahicleType
//            self.isPasserPremium = userData.isPremium
//            self.isNewRequest = userData.isRideAvailable
//            self.isWarnedFirst = userData.beWarnedFirst
//            self.isNewInApp = userData.isNotificationFromAdmin
//
//            if userData.role == 3 {
//                isBasicUser = true
//            }
//        }
    }
}


// MARK: Button actions and toggles
extension SettingsVC {
    @IBAction func backBtnTapAction(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func enRegisterTapAction(_ sender: UIBarButtonItem) {
        
        self.view.endEditing(true)
//        if Validation.isBlank(for: self.firstName) {
//            Common.showAlertMessage(message: Messages.emptyFirstName, alertType: .error)
//            return
//        } else if Validation.isBlank(for: self.lastName) {
//            Common.showAlertMessage(message: Messages.emptyLastName, alertType: .error)
//            return
//        } else if !isBasicUser{
//            if Validation.isBlank(for: self.section0Titles[1]) {
//                Common.showAlertMessage(message: Messages.emptyBussinessName, alertType: .error)
//                return }
//        } else if btnProfileImg.imageView?.image == UIImage(named: "add-photo") {
//            Common.showAlertMessage(message: Messages.emptyProfileImg, alertType: .error)
//            return
//        } else if !Validation.isBlank(for: self.section0Titles[2]) {
//            if !Validation.isValidEmail(for: self.section0Titles[2]) {
//                Common.showAlertMessage(message: Messages.validEmail, alertType: .error)
//                return
//            }
//        }
        
        apiEditProfile()
    }
    
}
//MARK: UITextFieldDelegate
extension SettingsVC: UITextFieldDelegate {
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            self.firstName = textField.text?.trim() ?? ""
        } else if textField.tag == 2 {
            self.lastName = textField.text?.trim() ?? ""
        } else if textField.tag == 3 {
            self.section0Titles[1] = textField.text?.trim() ?? ""
        } else if textField.tag == 4 {
            self.section0Titles[3] = textField.text?.trim() ?? ""
        } else if textField.tag == 5 {
            self.section0Titles[4] = textField.text?.trim() ?? ""
        } else if textField.tag == 6 {
            self.noOfCar = textField.text?.trim() ?? ""
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

//Mark: ProfileImage Action
extension SettingsVC {
    
    @IBAction func btnProfileImgAction(_ sender: UIButton) {
        self.showImagePickerView(sender)
    }
}


//Mark: UITableViewDataSource
extension SettingsVC :UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return section0placeHolder.count
        } else {
            return section2Titles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SettingNameCell", for: indexPath) as! SettingNameCell
                cell.accessoryType = .none
                cell.ivnNameIcon.image = UIImage(named: section0Images[indexPath.row])
                cell.selectionStyle = .none
                cell.accessoryType = .none
                cell.tfFirstName.text = firstName
                cell.tfFirstName.tag = 1
                cell.tfLastName.text = lastName
                cell.tfLastName.tag = 2
                cell.tfFirstName.delegate = self
                cell.tfLastName.delegate = self
                cell.tfLastName.setLeftMargin()
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
                cell.accessoryType = .none
//                cell.settingiconIv.image = UIImage(named: section0Images[indexPath.row])
                cell.settingTitleLb.placeholder = section0placeHolder[indexPath.row]
                cell.settingTitleLb.text = section0Titles[indexPath.row]
                cell.settingTitleLb.keyboardType = .default
                cell.settingTitleLb.delegate = self
                if indexPath.row == 1 {
                    cell.settingTitleLb.tag = 3
                    cell.settingTitleLb.isEnabled = !isBasicUser
                } else if indexPath.row == 3 {
                    cell.settingTitleLb.tag = 4
                    cell.settingTitleLb.keyboardType = .emailAddress
                    cell.settingTitleLb.isEnabled = true
                    cell.settingTitleLb.autocapitalizationType = .none
                } else if indexPath.row == 4 {
                    cell.settingTitleLb.tag = 5
                    cell.settingTitleLb.keyboardType = .phonePad
                    cell.settingTitleLb.isEnabled = false
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
            cell.settingTitleLb.text = section2Titles[indexPath.row]
            cell.settingTitleLb.isEnabled = false
            cell.accessoryType = .disclosureIndicator
            cell.settingiconIv.image = UIImage(named: section2Images[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}


//Mark: UITableViewDelegate
extension SettingsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "My Profile"
        } else {
            return "Settings"
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            if indexPath.row == 7 {
//                let strybd = UIStoryboard(name: "Home", bundle: nil)
//                let popvc = strybd.instantiateViewController(withIdentifier: "BuyPointsVC") as! BuyPointsVC
//                if let getNav =  UIApplication.topViewController()?.navigationController {
//                    let rootNavView = UINavigationController(rootViewController: popvc)
//                    rootNavView.providesPresentationContextTransitionStyle = true
//                    rootNavView.definesPresentationContext = true
//                    rootNavView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//                    rootNavView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//                    getNav.present( rootNavView, animated: true, completion: nil)
//                }
//            } else if indexPath.row == 8 {
//                if isPasserPremium {
//                    Global.showLoadingSpinner("", sender: self.view)
//                    IAPHandler.shared.restorePurchase(view: self.view, VC: self)
//                } else {
//                    let alertCntrlr = UIAlertController(title: "", message: "Vous n'avez jamais été utilisateur Premium sur ce compte. Vous ne pouvez pas restaurer un achat.", preferredStyle: .alert)
//
//                    let closeAction = UIAlertAction(title: Messages.txtCancel, style: .cancel) { (alert:UIAlertAction) -> Void in
//
//                    }
//                    alertCntrlr.addAction(closeAction)
//                    self.present(alertCntrlr, animated: true, completion: nil)
//                }
//
//            }
//        } else if indexPath.section == 1 {
//            if indexPath.row == 0 {
//                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                    return
//                }
//                if UIApplication.shared.canOpenURL(settingsUrl) {
//                    UIApplication.shared.open(settingsUrl, completionHandler: nil)
//                }
//            }
//        } else if indexPath.section == 2 {
//            switch indexPath.row {
//            case 0:
//                Global.openURL(Constants.kAppDelegate.fbUrl)
//                return
//            case 1:
//                Global.openURL(Constants.kAppDelegate.instaUrl)
//                return
//            case 2:
//                Global.openURL(Constants.kAppDelegate.siteUrl)
//                return
//            case 3:
//                //Global.openURL(linkdinCustomLink)
//                SKStoreReviewController.requestReview()
//                return
//            case 4:
//                showReportMessagePopup()
//                break
//            case 5:
//                sendMail()
//                break
//            case 6:
//                let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                let webViewController: WebViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//                webViewController.url = Constants.kAppDelegate.tAndCUrl
//                webViewController.navTitle = "Conditions Générales d’Utilisation"
//                navigationController?.pushViewController(webViewController, animated: true)
//                return
//            case 7:
//                let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                let webViewController: WebViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//                webViewController.url = Constants.kAppDelegate.privacyURl
//                webViewController.navTitle = "Confidentialité"
//                navigationController?.pushViewController(webViewController, animated: true)
//                return
//            default:
//                return
//            }
//        }
//    }
}

//MARK: Header Configration
extension SettingsVC {
    
    func configure() {
        //Mark: HeaderView
        self.profileView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        self.tableView.tableHeaderView = profileView
        self.tableView.tableHeaderView?.frame = profileView.frame
        self.tableView.tableFooterView = UIView()
    }
}

//MARK: UIImagePickerController Config
extension SettingsVC {
    
//    func openCamera() {
//
//        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.sourceType = UIImagePickerController.SourceType.camera
//            imagePicker.allowsEditing = true
//            imagePicker.delegate = self
//            self.present(imagePicker, animated: true, completion: nil)
//        } else {
//            Common.showAlertMessage(message: Messages.cameraNotFound, alertType: .warning)
//        }
//    }
    
//    func openGallary() {
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
//        imagePicker.allowsEditing = true
//        imagePicker.delegate = self
//        self.present(imagePicker, animated: true, completion: nil)
//    }
    
    func showImagePickerView(_ sender: UIButton) {
        
//        let alert = UIAlertController(title: Messages.photoMassage, message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title:  Messages.txtCamera, style: .default, handler: { _ in
//            self.openCamera()
//        }))
//
//        alert.addAction(UIAlertAction(title: Messages.txtGallery, style: .default, handler: { _ in
//            self.openGallary()
//        }))
//
//        alert.addAction(UIAlertAction.init(title: Messages.txtCancel, style: .cancel, handler: nil))
//
//        switch UIDevice.current.userInterfaceIdiom {
//        case .pad:
//            alert.popoverPresentationController?.sourceView = sender
//            alert.popoverPresentationController?.sourceRect = sender.bounds
//            alert.popoverPresentationController?.permittedArrowDirections = .up
//        default:
//            break
//        }
//
//        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: UIImagePickerControllerDelegate
extension SettingsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let  pickedImage = info[.originalImage] as? UIImage {
            self.btnProfileImg.setImage(pickedImage.imageOrientation(pickedImage), for: .normal)
            self.btnProfileImg.imageView?.contentMode = .scaleAspectFill
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: Api Calling
extension SettingsVC {
    
    func apiEditProfile() {
//        guard let userData = UserModel.getUserModel() else {return}
//        let param: [String: Any] = ["user_id": userData.userID, "first_name": firstName, "last_name": lastName, "company_name": section0Titles[1], "email": section0Titles[3], "is_premium": isPasserPremium, "is_ride_available": isNewRequest, "be_warned_first": isWarnedFirst, "is_notification_from_admin": isNewInApp,"siret_number": userData.siretNumber]
//
//        Global.showLoadingSpinner()
//        API.EDITPROFILE.requestUpload(with: param, files: ["profile_pic": self.btnProfileImg.imageView?.image ?? ""]) { (response, error) in
//            Global.dismissLoadingSpinner()
//
//            guard error == nil, let getData = response?["data"] as? [String: Any] else {
//                return
//            }
//            Common.showAlertMessage(message: response?["message"] as? String ?? "", alertType: .success)
//            UserModel.storeUserModel(value: getData)
//            self.dismiss(animated: true, completion: nil)
//        }
    }
}

//MARK: SettingNameCell
class SettingNameCell: UITableViewCell {
    @IBOutlet weak var ivnNameIcon: UIImageView!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
}

// MARK: SettingCell
class SettingCell: UITableViewCell {
    @IBOutlet weak var settingiconIv: UIImageView!
    @IBOutlet weak var settingTitleLb: UITextField!
    @IBOutlet var viewBottomConstraint: NSLayoutConstraint!
}
