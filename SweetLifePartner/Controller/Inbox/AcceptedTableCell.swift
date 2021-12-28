//
//  AcceptedTableCell.swift
//  SweetLifePartner
//
//  Created by angrej singh on 22/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class AcceptedTableCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPost: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
      
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//MARK:- Acction For See Message Button
    @IBAction func btnSeeMessage(_ sender: UIButton) {
    }
}

