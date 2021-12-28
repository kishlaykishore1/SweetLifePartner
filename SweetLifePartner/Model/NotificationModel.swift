//
//  NotificationModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 16/03/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - Datum
struct NotificationModel: Codable {
    var by: String? = ""
    let profileImage: String?
    let type: String?
    let status: String?
    let isSeen, time: String?

    enum CodingKeys: String, CodingKey {
        case by
        case profileImage = "profile_image"
        case type, status
        case isSeen = "is_seen"
        case time
    }
}
