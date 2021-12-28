//
//  PartnerExpectationModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 15/02/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - PartnerExpectationModel
struct PartnerExpectationModel: Codable {
    let partnerAge, partnerHeight, partnerMaritalStatus, partnerPhysicalStatus: String
    let partnerBodyType, partnerComplexion, partnerDrink, partnerDiet: String
    let partnerSmoke, partnerReligion, partnerCaste, partnerSunsign: String
    let partnerEducation, partnerProfession, partnerAnnualIncome, manglik: String
    let partnerMotherTongue, preferedCountry, preferedState, preferedCity: String

    enum CodingKeys: String, CodingKey {
        case partnerAge = "partner_age"
        case partnerHeight = "partner_height"
        case partnerMaritalStatus = "partner_marital_status"
        case partnerPhysicalStatus = "partner_physical_status"
        case partnerBodyType = "partner_body_type"
        case partnerComplexion = "partner_complexion"
        case partnerDrink = "partner_drink"
        case partnerDiet = "partner_diet"
        case partnerSmoke = "partner_smoke"
        case partnerReligion = "partner_religion"
        case partnerCaste = "partner_caste"
        case partnerSunsign = "partner_sunsign"
        case partnerEducation = "partner_education"
        case partnerProfession = "partner_profession"
        case partnerAnnualIncome = "partner_annual_income"
        case manglik
        case partnerMotherTongue = "partner_mother_tongue"
        case preferedCountry = "prefered_country"
        case preferedState = "prefered_state"
        case preferedCity = "prefered_city"
    }
}


