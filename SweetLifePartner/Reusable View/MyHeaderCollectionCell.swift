//
//  MyHeaderCollectionCell.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 18/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit



class MyHeaderCollectionCell: UICollectionViewCell {

    
    
    @IBOutlet weak var lblHeaderCell: UILabel!
    @IBOutlet weak var sideView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override var isSelected: Bool {
//        didSet {
//            if self.isSelected {
//                self.lblHeaderCell.textColor = UIColor.black
//            } else {
//                self.lblHeaderCell.textColor = UIColor.white
//            }
//        }
//    }

}
