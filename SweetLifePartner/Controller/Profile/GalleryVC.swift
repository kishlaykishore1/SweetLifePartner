//
//  GalleryVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 10/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController {

    var getGallerydata = [GetGalleryModelElement]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiGetGallery()
    }
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async {
                self.setNavigationbarThemeGradientColor()
            }
             navigationController?.navigationBar.isHidden = false
             setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
             title = "Gallery"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
          self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddToGalleryPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UploadImageVC") as! UploadImageVC
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated:true, completion: nil)
    }
}
//MARK:-Collection View DataSource Methods
extension GalleryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getGallerydata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionCell", for: indexPath) as! GalleryCollectionCell
        if let url = URL(string: getGallerydata[indexPath.row].image ) {
           cell.galleryImages.af_setImage(withURL: url)
          } else {
              cell.galleryImages.image = #imageLiteral(resourceName: "screen")
          }
        cell.lblImageName.text = getGallerydata[indexPath.row].title
        return cell
    }
    
}
//MARK:-Collection View FlowLayout delegates Methods
extension GalleryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let collectionWidth = collectionView.bounds.width
       //  let collectionHeight = collectionView.bounds.height
        return CGSize(width: collectionWidth / 3 - 5 , height: 100 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
//MARK:- Collection View Delegates Methods
extension GalleryVC: UICollectionViewDelegate {
    
    
}
//MARK:- CollectionView cell Class
class GalleryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryImages: UIImageView!
    @IBOutlet weak var lblImageName: UILabel!
    
}

extension GalleryVC {
    //MARK:- API CAlling For Get Gallery
    func apiGetGallery() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let param: [String: Any] = ["member_id": id]
        print(param)
        if let getRequest = API.GETGALLERY.request(method: .post, with: param, forJsonEncoding: false) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
               API.GETGALLERY.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                        self.getGallerydata = try decoder.decode([GetGalleryModelElement].self, from: jsonData)
                        self.collectionView.reloadData()
                        print(self.getGallerydata)
                        
                    } catch let err{
                        print("Err", err)
                    }
                })
            }
        }
    }
}


