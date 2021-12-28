//
//  RegisterMoreDetailsModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 30/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - FamilyStatusModel
struct FamilyStatusModel: Codable {
    let familyStatusID, name: String

    enum CodingKeys: String, CodingKey {
        case familyStatusID = "family_status_id"
        case name
    }
}

// MARK: - FamilyValuesModel
struct FamilyValuesModel: Codable {
    let familyValueID, name: String

    enum CodingKeys: String, CodingKey {
        case familyValueID = "family_value_id"
        case name
    }
}
