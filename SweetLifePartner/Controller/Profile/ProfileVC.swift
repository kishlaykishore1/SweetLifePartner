//
//  ProfileVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 21/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit
import StoreKit

class ProfileVC: UIViewController {
    
    @IBOutlet var footerView: UIView!
    @IBOutlet weak var btnUpgradeProfile: DesignableButton!
    @IBOutlet var topNevView: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var UserMemberId: UILabel!
    @IBOutlet weak var lblAccountType: UILabel!
    @IBOutlet weak var imgUserProfileImage: UIImageView!
    
    
     var section1Images :  [String] = ["notification","gallery","happy-story","privacy","rate-the-app","Partner-Preference","Partner-Preference","Change-Password"]
    var dataSetSection1 = ["Notifications","Gallery","Happy Story","Picture Privacy", "Rate The App","Help & Support","Account Settings","Logout"]
    var getRecentVisitors = [RecentVisitorsModel]()
    var MyIndex = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        apiRecentVisitors()
        navigationController?.navigationBar.isHidden = true
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 148)
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.frame = headerView.frame
        
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 120)
        tableView.tableFooterView = footerView
        tableView.tableFooterView?.frame = footerView.frame
        lblUserName.text = MemberModel.getMemberModel()?.firstName
        if let url = URL(string: MemberModel.getMemberModel()?.profileImage ?? "") {
            imgUserProfileImage.af_setImage(withURL: url)
        } else {
            imgUserProfileImage.image = #imageLiteral(resourceName: "screen")
        }
        UserMemberId.text = MemberModel.getMemberModel()?.memberProfileID
        
        
        
        
        
        
        DispatchQueue.main.async {
            self.view.applyGradient(withColours: [#colorLiteral(red: 0.9137254902, green: 0.1176470588, blue: 0.3882352941, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.4235294118, blue: 0.6156862745, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.4235294118, blue: 0.6156862745, alpha: 1)], gradientOrientation: .horizontal)
            self.btnUpgradeProfile.applyGradient(withColours: [#colorLiteral(red: 0.9137254902, green: 0.1176470588, blue: 0.3882352941, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.4235294118, blue: 0.6156862745, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.4235294118, blue: 0.6156862745, alpha: 1)], gradientOrientation: .horizontal)
            self.topNevView.applyGradient(withColours: [#colorLiteral(red: 0.9137254902, green: 0.1176470588, blue: 0.3882352941, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.4235294118, blue: 0.6156862745, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.4235294118, blue: 0.6156862745, alpha: 1)], gradientOrientation: .horizontal)
            self.headerView.applyGradient(withColours: [#colorLiteral(red: 0.4078431373, green: 0.3490196078, blue: 0.3607843137, alpha: 1), #colorLiteral(red: 0.1843137255, green: 0.3803921569, blue: 0.3843137255, alpha: 1)], gradientOrientation: .horizontal)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func actionBtnEditProfile(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        if let getNav =  UIApplication.topViewController()?.navigationController {
            let rootNavView = UINavigationController(rootViewController: settingsVC)
            rootNavView.modalPresentationStyle = .fullScreen
            getNav.present( rootNavView, animated: true, completion: nil)
        }
    }
    
    //MARK:- Review Window Function
    func DisplayReviewController() {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        }
    }
    //MARK:- Header Upgrade button pressed
    @IBAction func actionBtnUpgradeProfile(_ sender: UIButton) {
        
    }
}
//MARK:- Table view delegates methods
extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
//MARK:- Table view dataSource Methods
extension ProfileVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataSetSection1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTbCell", for: indexPath) as! CollectionTbCell
            cell.profilVC = self
            cell.getRecentVisitors = getRecentVisitors
            cell.collectionView.reloadData()
            if getRecentVisitors.count > 0 {
                cell.cellHeight.constant = 250.0
            } else {
                cell.cellHeight.constant = 0.0
            }
            
            return cell
        } else {
            if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "tableDetails2Cell", for: indexPath) as! tableDetails2Cell
                cell.lblTitle.text = dataSetSection1[indexPath.row]
                cell.lblSubTile.text = "Make your opinion count"
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "tableDetailsCell", for: indexPath) as! tableDetailsCell
                cell.lblTitle.text = dataSetSection1[indexPath.row]
                cell.ivTitle.image = UIImage(named: section1Images[indexPath.row])
                
                return cell
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            MyIndex = indexPath.row
            switch MyIndex {
            case 0:
                let vc = storyboard?.instantiateViewController(withIdentifier: "NotifiactionsVC") as! NotifiactionsVC
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = storyboard?.instantiateViewController(withIdentifier: "GalleryVC") as! GalleryVC
                navigationController?.pushViewController(vc, animated: true)
            case 2:
                let vc = storyboard?.instantiateViewController(withIdentifier: "HappyStoryVC") as! HappyStoryVC
                navigationController?.pushViewController(vc, animated: true)
            case 3:
                let vc = storyboard?.instantiateViewController(withIdentifier: "PicturePrivacyVC") as! PicturePrivacyVC
                navigationController?.pushViewController(vc, animated: true)
            case 4:
                DisplayReviewController()
            case 5:
                let vc = storyboard?.instantiateViewController(withIdentifier: "Help_SupportVC") as! Help_SupportVC
                navigationController?.pushViewController(vc, animated: true)
            case 6:
                let vc = storyboard?.instantiateViewController(withIdentifier: "AccountSettingsVC") as! AccountSettingsVC
                navigationController?.pushViewController(vc, animated: true)
            case 7:
                Global.clearAllAppUserDefaults()
                Constants.kAppDelegate.isUserLogin(false)
            default:
                print("You are done")
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Complete your profile"
        } else {
            return "Options and Settings"
        }
    }
}
//MARK: Table view cell classes
class tableDetailsCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var ivTitle: UIImageView!
}
class tableDetails2Cell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTile: UILabel!
    @IBOutlet weak var ivTitle: UIImageView!
}

class CollectionTbCell: UITableViewCell {
    // weak var delegate:ProfileDetailsDelegate?
    
    var profilVC: ProfileVC?
    var getRecentVisitors = [RecentVisitorsModel]()
    var recentVisitorID = ""
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
}
extension CollectionTbCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getRecentVisitors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        if let url = URL(string: getRecentVisitors[indexPath.row].image ?? "") {
            cell.imgVisitorPicture.af_setImage(withURL: url)
        } else {
            cell.imgVisitorPicture.image = #imageLiteral(resourceName: "screen")
        }
        cell.lblVisitorName.text = getRecentVisitors[indexPath.row].firstName
        let des = "\(getRecentVisitors[indexPath.row].age ?? 24)yrs,\(getRecentVisitors[indexPath.row].height ?? "5'4"), \(getRecentVisitors[indexPath.row].language ?? "Hindi")\n \(getRecentVisitors[indexPath.row].lastName ?? "")\n \(getRecentVisitors[indexPath.row].state ?? "Rajasthan"), \(getRecentVisitors[indexPath.row].country ?? "India")"
        cell.lblVisitorData.text = des
        recentVisitorID = getRecentVisitors[indexPath.row].memberID ?? ""
        
        return cell
    }
}

extension CollectionTbCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewDetailsVC") as! ViewDetailsVC
        vc.recentVisitorID = getRecentVisitors[indexPath.row].memberID ?? ""
        self.profilVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension CollectionTbCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 2.2, height: self.collectionView.frame.height)
    }
    
}

//MARK:- Function for collection view cell tapped
class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var imgVisitorPicture: UIImageView!
    @IBOutlet weak var lblVisitorData: UILabel!
    @IBOutlet weak var lblVisitorName: UILabel!
    
    
}

extension ProfileVC {
    //MARK:- API CAlling For Recent Visitors
    func apiRecentVisitors() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let param: [String: Any] = ["member_id": id]
        print(param)
        if let getRequest = API.GETRECENTVISITORS.request(method: .post, with: param, forJsonEncoding: false) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
                API.GETRECENTVISITORS.validatedResponse(response, completionHandler: { (jsonObject,error) in
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
                        self.getRecentVisitors = try decoder.decode([RecentVisitorsModel].self, from: jsonData)
                        self.tableView.reloadData()
                        print(self.getRecentVisitors)
                        
                    } catch let err{
                        print("Err", err)
                    }
                })
            }
        }
    }
}

