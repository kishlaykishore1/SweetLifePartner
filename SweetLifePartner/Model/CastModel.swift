//
//  CastModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 27/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation
// MARK: - Datum
struct CastModel: Codable {
    let casteID, casteName, religionID: String

    enum CodingKeys: String, CodingKey {
        case casteID = "caste_id"
        case casteName = "caste_name"
        case religionID = "religion_id"
    }
}

// MARK: - SubCasteModel
struct SubCasteModel: Codable {
    let subCasteID, subCasteName, casteID: String

    enum CodingKeys: String, CodingKey {
        case subCasteID = "sub_caste_id"
        case subCasteName = "sub_caste_name"
        case casteID = "caste_id"
    }
}
