//
//  SignupModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 28/01/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - ProfileCreatedForModel
struct ProfileCreatedForModel: Codable {
    let id, name: String
}

// MARK: - ReligionModel
struct ReligionModel: Codable {
    let religionID, name: String

    enum CodingKeys: String, CodingKey {
        case religionID = "religion_id"
        case name
    }
}

// MARK: - MotherTongueModel
struct MotherTongueModel: Codable {
    let languageID, name: String

    enum CodingKeys: String, CodingKey {
        case languageID = "language_id"
        case name
    }
}

// MARK: - GetCasteModel
struct GetCasteModel: Codable {
    let casteID, casteName, religionID: String

    enum CodingKeys: String, CodingKey {
        case casteID = "caste_id"
        case casteName = "caste_name"
        case religionID = "religion_id"
    }
}

// MARK: - GetCountryModel
struct GetCountryModel: Codable {
    let countryID, sortname, name, phonecode: String

    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case sortname, name, phonecode
    }
}

// MARK: - GetStateModel
struct GetStateModel: Codable {
    let stateID, name, countryID: String

    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case name
        case countryID = "country_id"
    }
}

// MARK: - GetCityModel
struct GetCityModel: Codable {
    let cityID, name, stateID: String

    enum CodingKeys: String, CodingKey {
        case cityID = "city_id"
        case name
        case stateID = "state_id"
    }
}
