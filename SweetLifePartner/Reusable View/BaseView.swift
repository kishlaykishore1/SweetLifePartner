//
//  BaseView.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 08/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

protocol CellDelegate {
    func cellSelected(_ indexPath : IndexPath)
}
//protocol ButtonActionDelegate {
//   func btnSearchClicked(_ sender:UIButton)
//   func btnAllClicked(_ sender:UIButton)
//   func btnTodayMatchClicked(_ sender:UIButton)
//   func btnShortlistedClicked(_ sender:UIButton)
//}

@IBDesignable
class BaseView: UIView {
     var delegate : CellDelegate?
    
     var sectionTitles : [String] = ["Search","New Match","My Matches(All)","Near Me","My Shortlisted","My Follower","Preferred Profession","Preferred Education"]
     let nibName = "BaseView"
     var contentView:UIView?
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let nav = UINavigationController()
    
    override func awakeFromNib() {
         super.awakeFromNib()
        initCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    private func initCollectionView() {
      let nib = UINib(nibName: "MyHeaderCollectionCell", bundle: nil)
      collectionView.register(nib, forCellWithReuseIdentifier: "MyHeaderCollectionCell")
      collectionView.dataSource = self
      collectionView.delegate = self
    }
}
extension BaseView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyHeaderCollectionCell", for: indexPath) as! MyHeaderCollectionCell
        cell.lblHeaderCell.text = sectionTitles[indexPath.row]
        if indexPath.row == sectionTitles.count - 1 {
            cell.sideView.isHidden = true
        } else {
            cell.sideView.isHidden = false
        }
        
        return cell
    }
    
    
}
extension BaseView:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let cell = collectionView.cellForItem(at: indexPath) as? MyHeaderCollectionCell
               cell?.lblHeaderCell.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
         
          delegate?.cellSelected(indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
         let cell = collectionView.cellForItem(at: indexPath) as? MyHeaderCollectionCell
        cell?.lblHeaderCell.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         
    }
      
    
}
extension BaseView: UICollectionViewDelegateFlowLayout {
    
}
