//
//  TopMenuModel.swift
//  SweetLifePartner
//
//  Created by angrej singh on 22/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation


struct TopMenuModel {
    
    var title : String?
    var isSelected = false
    
    init(dict : [String:Any]) {
        self.title = dict["title"] as? String ?? ""
    }
}
