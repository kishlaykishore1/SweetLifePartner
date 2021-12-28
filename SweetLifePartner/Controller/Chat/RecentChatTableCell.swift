//
//  RecentChatTableCell.swift
//  SweetLifePartner
//
//  Created by angrej singh on 20/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import UIKit

class RecentChatTableCell: UITableViewCell {

    @IBOutlet weak var imgChatPerson: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
