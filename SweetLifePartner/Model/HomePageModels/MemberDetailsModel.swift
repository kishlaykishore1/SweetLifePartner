//
//  MemberDetailsModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 18/03/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - MemberDetailsModel
struct MemberDetailsModel: Codable {
    let memberID, memberProfileID, status, firstName: String?
    let lastName, gender, email, mobile: String?
    let introduction, dateOfBirth: String?
    let age: Int?
    let profileImage, thumb: String?
    let basicInfo: BasicInfo?
    let educationAndCareer: EducationAndCareer?
    let presentAddress: PresentAddress?
    let spiritualAndSocialBackground: SpiritualAndSocialBackground?
    let partnerExp: PartnerExp?
    let isFollow, isShortlisted, interestExpress, enableMessage: String?
    let followers, isReported: String?

    enum CodingKeys: String, CodingKey {
        case memberID = "member_id"
        case memberProfileID = "member_profile_id"
        case status
        case firstName = "first_name"
        case lastName = "last_name"
        case gender, email, mobile, introduction
        case dateOfBirth = "date_of_birth"
        case age
        case profileImage = "profile_image"
        case thumb
        case basicInfo = "basic_info"
        case educationAndCareer = "education_and_career"
        case presentAddress = "present_address"
        case spiritualAndSocialBackground = "spiritual_and_social_background"
        case partnerExp = "partner_exp"
        case isFollow = "is_follow"
        case isShortlisted = "is_shortlisted"
        case interestExpress = "interest_express"
        case enableMessage = "enable_message"
        case followers
        case isReported = "is_reported"
    }
}

// MARK: - BasicInfo
struct BasicInfo: Codable {
    let numberOfChildren, maritalStatus, onBehalf: String?

    enum CodingKeys: String, CodingKey {
        case numberOfChildren = "number_of_children"
        case maritalStatus = "marital_status"
        case onBehalf = "on_behalf"
    }
}

// MARK: - EducationAndCareer
struct EducationAndCareer: Codable {
    let highestEducation, occupation, annualIncome, schoolCollegeName: String?
    let companyName, currency: String?

    enum CodingKeys: String, CodingKey {
        case highestEducation = "highest_education"
        case occupation
        case annualIncome = "annual_income"
        case schoolCollegeName = "school_college_name"
        case companyName = "company_name"
        case currency
    }
}

// MARK: - PartnerExp
struct PartnerExp: Codable {
    let partnerAge, partnerHeight, partnerMaritalStatus, partnerPhysicalStatus: String?
    let partnerBodyType, partnerComplexion, partnerDrink, partnerSmoke: String?
    let partnerDiet, partnerReligion, partnerCaste, sunSign: String?
    let partnerEducation, partnerProfession, partnerAnnualIncome, manglik: String?
    let partnerMotherTongue, preferedCountry, preferedState: String?

    enum CodingKeys: String, CodingKey {
        case partnerAge = "partner_age"
        case partnerHeight = "partner_height"
        case partnerMaritalStatus = "partner_marital_status"
        case partnerPhysicalStatus = "partner_physical_status"
        case partnerBodyType = "partner_body_type"
        case partnerComplexion = "partner_complexion"
        case partnerDrink = "partner_drink"
        case partnerSmoke = "partner_smoke"
        case partnerDiet = "partner_diet"
        case partnerReligion = "partner_religion"
        case partnerCaste = "partner_caste"
        case sunSign = "sun_sign"
        case partnerEducation = "partner_education"
        case partnerProfession = "partner_profession"
        case partnerAnnualIncome = "partner_annual_income"
        case manglik
        case partnerMotherTongue = "partner_mother_tongue"
        case preferedCountry = "prefered_country"
        case preferedState = "prefered_state"
    }
}

// MARK: - PresentAddress
struct PresentAddress: Codable {
    let country, city, state, postalCode: String?

    enum CodingKeys: String, CodingKey {
        case country, city, state
        case postalCode = "postal_code"
    }
}

// MARK: - SpiritualAndSocialBackground
struct SpiritualAndSocialBackground: Codable {
    let religion, caste, sunSign, timeOfBirth: String?
    let cityOfBirth, personalValue, communityValue, ethnicity: String?
    let uManglik: String?

    enum CodingKeys: String, CodingKey {
        case religion, caste
        case sunSign = "sun_sign"
        case timeOfBirth = "time_of_birth"
        case cityOfBirth = "city_of_birth"
        case personalValue = "personal_value"
        case communityValue = "community_value"
        case ethnicity
        case uManglik = "u_manglik"
    }
}
