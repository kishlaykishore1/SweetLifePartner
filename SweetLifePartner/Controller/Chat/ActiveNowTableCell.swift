//
//  ActiveNowTableCell.swift
//  SweetLifePartner
//
//  Created by angrej singh on 20/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class ActiveNowTableCell: UITableViewCell {

    @IBOutlet weak var imgActiveNow: UIImageView!
    @IBOutlet weak var lblActivePersonName: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    @IBOutlet weak var lblActivePersonResidence: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
