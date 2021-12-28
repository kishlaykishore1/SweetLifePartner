//
//  InboxDataModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 29/03/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - InboxModelElement
struct InboxModelElement: Codable {
    let memberID, firstName, lastName: String
    let image: String
    let age: Int
    let country, state, height, occupation: String
    let messageThreadID, status: String

    enum CodingKeys: String, CodingKey {
        case memberID = "member_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case image, age, country, state, height, occupation
        case messageThreadID = "message_thread_id"
        case status
    }
}

// MARK: - FollowedMemberElement
struct FollowedMemberElement: Codable {
    let memberID, firstName, lastName: String?
    let image: String?
    let age: Int?
    let country, state, height, occupation: String?

    enum CodingKeys: String, CodingKey {
        case memberID = "member_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case image, age, country, state, height, occupation
    }
}
