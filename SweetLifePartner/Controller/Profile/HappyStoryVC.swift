//
//  HappyStoryVC.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 10/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class HappyStoryVC: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tfStoryTitle: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
   
    var totalLines:CGFloat = 5
    var maxHeight:CGFloat?
    var imgArry = [#imageLiteral(resourceName: "screen"),#imageLiteral(resourceName: "mainImage"),#imageLiteral(resourceName: "screen"),#imageLiteral(resourceName: "mainImage"),#imageLiteral(resourceName: "Empty-Image"),#imageLiteral(resourceName: "mainImage"),#imageLiteral(resourceName: "screen"),#imageLiteral(resourceName: "mainImage")]
    var currentIndex = 0
    var getstoryData = [GetHappyStoryElement]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        apiGetHappyStory()
        maxHeight = (textView.font!.lineHeight * totalLines)
        textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: maxHeight ?? 2))
        pageController.pageIndicatorTintColor = #colorLiteral(red: 0.9960784314, green: 0.2039215686, blue: 0.431372549, alpha: 1)
        pageController.numberOfPages = getstoryData.count
        pageController.currentPage = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async {
                self.setNavigationbarThemeGradientColor()
            }
             navigationController?.navigationBar.isHidden = false
             setBackButton(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , isImage: true)
             title = "Happy Story"
    }
    //MARK: Back Button Action
    override func backBtnTapAction() {
          self.navigationController?.popViewController(animated: true)
    }

}
//MARK:-Collection View Datasource Methods
extension HappyStoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getstoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HappyStorycollectionCell", for: indexPath) as! HappyStorycollectionCell
        if let url = URL(string: getstoryData[indexPath.row].img?[indexPath.row] ?? "" ) {
          cell.storyImages.af_setImage(withURL: url)
         } else {
             cell.storyImages.image = #imageLiteral(resourceName: "screen")
         }
        self.tfStoryTitle.text = getstoryData[indexPath.row].title
        self.textView.text = self.getstoryData[indexPath.row].getHappyStoryDescription
        return cell
        
    }
}
//MARK:-Collection View DataFlow Delegates
extension HappyStoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
//MARK:-Collection View Delegates Methods
extension HappyStoryVC:UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / collectionView.frame.size.width)
        pageController.currentPage = currentIndex
    }
}
//MARK:-Collection view cell class
class HappyStorycollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var storyImages: UIImageView!
    
}

extension HappyStoryVC {
    //MARK:- API CAlling For Get Gallery
    func apiGetHappyStory() {
        guard let id = MemberModel.getMemberModel()?.memberID else {
            return
        }
        let param: [String: Any] = ["member_id": id]
        print(param)
        if let getRequest = API.GETHAPPYSTORY.request(method: .post, with: param, forJsonEncoding: true) {
            Global.showLoadingSpinner()
            getRequest.responseJSON { response in
                Global.dismissLoadingSpinner()
               API.GETHAPPYSTORY.validatedResponse(response, completionHandler: {(jsonObject, error) in
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
                        self.getstoryData = try decoder.decode([GetHappyStoryElement].self, from: jsonData)
                        
                        self.collectionView.reloadData()
                        print(self.getstoryData)
                        
                    } catch let err{
                        print("Err", err)
                    }
                })
            }
        }
    }
}
