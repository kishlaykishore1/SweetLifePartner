//
//  RecivedTableCell.swift
//  SweetLifePartner
//
//  Created by angrej singh on 22/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class RecivedTableCell: UITableViewCell {

    @IBOutlet weak var imgProfileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPost: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//MARK:-action For see Message Button
    @IBAction func btnSeeMessagePressed(_ sender: UIButton) {
    }
}
