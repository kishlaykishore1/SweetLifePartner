//
//  DecisionModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 11/02/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - DecisionModel
struct DecisionModel: Codable {
    let decisionID, name: String

    enum CodingKeys: String, CodingKey {
        case decisionID = "decision_id"
        case name
    }
}
