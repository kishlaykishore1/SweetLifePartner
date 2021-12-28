//
//  HomeVC.swift
//  SweetLifePartner
//
//  Created by angrej singh on 19/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var HomeCollection: UICollectionView!
    
    let arrImg = [#imageLiteral(resourceName: "mainImage"),#imageLiteral(resourceName: "mainImage"),#imageLiteral(resourceName: "mainImage"),#imageLiteral(resourceName: "mainImage"),#imageLiteral(resourceName: "mainImage")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as! HomeCollectionCell
        cell.img.image = arrImg[indexPath.row]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = HomeCollection.bounds.width
        return CGSize(width: collectionWidth/1  , height: collectionView.bounds.height )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
   
   

    @IBAction func btnLeftTap(_ sender: Any) {
        
        let visibleItems: NSArray = self.HomeCollection.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        if nextItem.row < arrImg.count {
            self.HomeCollection.scrollToItem(at: nextItem, at: .left, animated: true)
      }
        
   }
    
    @IBAction func btnRightTap(_ sender: Any) {
        
        let visibleItems: NSArray = self.HomeCollection.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        if nextItem.row < arrImg.count {
            self.HomeCollection.scrollToItem(at: nextItem, at: .right, animated: true)
    }
}
    
    
    
    @IBAction func did_CameraTap(_ sender: Any) {
        
    }
    
    
}
