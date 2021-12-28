//
//  searchModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 10/05/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - SearchedModelElement
struct SearchedModelElement: Codable {
    let memberID, profileID, status, firstName: String?
    let lastName, gender: String?
    let image: String?
    let age: Int?
    let occupation, country, state, height: String?
    let language, caste: String?

    enum CodingKeys: String, CodingKey {
        case memberID = "member_id"
        case profileID = "profile_id"
        case status
        case firstName = "first_name"
        case lastName = "last_name"
        case gender, image, age, occupation, country, state, height, language, caste
    }
}
