//
//  RecntVisitorsModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 16/03/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - Datum
struct RecentVisitorsModel: Codable {
    let memberID, firstName, lastName: String?
    let image: String?
    let age: Int?
    var country: String? = ""
    var state: String? = ""
    let height: String? = ""
    let language: String? = ""

    enum CodingKeys: String, CodingKey {
        case memberID = "member_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case image, age, country, state, height, language
    }
}
