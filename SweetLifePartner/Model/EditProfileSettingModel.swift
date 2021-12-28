//
//  EditProfileSettingModel.swift
//  SweetLifePartner
//
//  Created by kishlay kishore on 05/02/20.
//  Copyright © 2020 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation

// MARK: - EducationCareerModel
struct EducationCareerModel: Codable {
    let highestEducation, occupation, annualIncome, schoolCollegeName: String
    let companyName, currency: String

    enum CodingKeys: String, CodingKey {
        case highestEducation = "highest_education"
        case occupation
        case annualIncome = "annual_income"
        case schoolCollegeName = "school_college_name"
        case companyName = "company_name"
        case currency
    }
}

// MARK: - PhysicalAttributeModel
struct PhysicalAttributeModel: Codable {
    let height, weight, eyeColor, hairColor: String
    let complexion, bloodGroup, bodyType, bodyArt: String
    let anyDisability: String

    enum CodingKeys: String, CodingKey {
        case height, weight
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case complexion
        case bloodGroup = "blood_group"
        case bodyType = "body_type"
        case bodyArt = "body_art"
        case anyDisability = "any_disability"
    }
}

// MARK: - ProfileLanguageModel
struct ProfileLanguageModel: Codable {
    let motherTongue, language, speak, read: String

    enum CodingKeys: String, CodingKey {
        case motherTongue = "mother_tongue"
        case language, speak, read
    }
}

// MARK: - HobbiesInterestModel
struct HobbiesInterestModel: Codable {
    let hobby, interest, music, books: String
    let movie, tvShow, sportsShow, fitnessActivity: String
    let cuisine, dressStyle: String

    enum CodingKeys: String, CodingKey {
        case hobby, interest, music, books, movie
        case tvShow = "tv_show"
        case sportsShow = "sports_show"
        case fitnessActivity = "fitness_activity"
        case cuisine
        case dressStyle = "dress_style"
    }
}

// MARK: - PersonalAttitudeModel
struct PersonalAttitudeModel: Codable {
    let affection, humor, politicalView, religiousService: String

    enum CodingKeys: String, CodingKey {
        case affection, humor
        case politicalView = "political_view"
        case religiousService = "religious_service"
    }
}

// MARK: - ResidencyInfoModel
struct ResidencyInfoModel: Codable {
    let birthCountry, residencyCountry, citizenshipCountry, growUpCountry: String
    let immigrationStatus: String

    enum CodingKeys: String, CodingKey {
        case birthCountry = "birth_country"
        case residencyCountry = "residency_country"
        case citizenshipCountry = "citizenship_country"
        case growUpCountry = "grow_up_country"
        case immigrationStatus = "immigration_status"
    }
}

// MARK: - SpritualAndSocialModel
struct SpritualAndSocialModel: Codable {
    let religion, caste, sunSign, timeOfBirth: String
    let cityOfBirth, ethnicity, personalValue, uManglik: String
    let communityValue: String

    enum CodingKeys: String, CodingKey {
        case religion, caste
        case sunSign = "sun_sign"
        case timeOfBirth = "time_of_birth"
        case cityOfBirth = "city_of_birth"
        case ethnicity
        case personalValue = "personal_value"
        case uManglik = "u_manglik"
        case communityValue = "community_value"
    }
}


// MARK: - LifestyleModel
struct LifestyleModel: Codable {
    let diet, drink, smoke, livingWith: String

    enum CodingKeys: String, CodingKey {
        case diet, drink, smoke
        case livingWith = "living_with"
    }
}

// MARK: - AstronomicDataModel
struct AstronomicDataModel: Codable {
    let sunSign, moonSign, timeOfBirth, cityOfBirth: String

    enum CodingKeys: String, CodingKey {
        case sunSign = "sun_sign"
        case moonSign = "moon_sign"
        case timeOfBirth = "time_of_birth"
        case cityOfBirth = "city_of_birth"
    }
}

// MARK: - PermanentAddModel
struct PermanentAddModel: Codable {
    let permanentCountry, permanentCity, permanentState, permanentPostalCode: String

    enum CodingKeys: String, CodingKey {
        case permanentCountry = "permanent_country"
        case permanentCity = "permanent_city"
        case permanentState = "permanent_state"
        case permanentPostalCode = "permanent_postal_code"
    }
}

// MARK: - FamilyInfoModel
struct FamilyInfoModel: Codable {
    let noOfBrothers, marriedBrothers, noOfSisters, marriedSisters: String?
    let fatherName, fatherOccupation, fatherStatus, motherName: String?
    let motherOccupation, motherStatus, familyStatus, familyValue: String?

    enum CodingKeys: String, CodingKey {
        case noOfBrothers = "no_of_brothers"
        case marriedBrothers = "married_brothers"
        case noOfSisters = "no_of_sisters"
        case marriedSisters = "married_sisters"
        case fatherName = "father_name"
        case fatherOccupation = "father_occupation"
        case fatherStatus = "father_status"
        case motherName = "mother_name"
        case motherOccupation = "mother_occupation"
        case motherStatus = "mother_status"
        case familyStatus = "family_status"
        case familyValue = "family_value"
    }
}

// MARK: - AdditionalPersonalModel
struct AdditionalPersonalModel: Codable {
    let homeDistrict, familyResidence, fathersOccupation, specialCircumstances: String

    enum CodingKeys: String, CodingKey {
        case homeDistrict = "home_district"
        case familyResidence = "family_residence"
        case fathersOccupation = "fathers_occupation"
        case specialCircumstances = "special_circumstances"
    }
}

