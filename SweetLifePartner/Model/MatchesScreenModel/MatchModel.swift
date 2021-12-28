//
//  MatchModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 09/05/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - MatchesModelElement
struct MatchesModelElement: Codable {
    let matchMemberID, firstName, lastName: String?
    let image: String?
    let age: Int?
    let country, state, height, language: String?

    enum CodingKeys: String, CodingKey {
        case matchMemberID = "match_member_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case image, age, country, state, height, language
    }
}
