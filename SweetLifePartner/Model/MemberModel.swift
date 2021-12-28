//
//  MemberModel.swift
//  SweetLifePartner
//
//  Created by Nandkishor Mewara on 27/11/19.
//  Copyright © 2019 com.tp.sweetlifepartner. All rights reserved.
//

import Foundation
class MemberModel: Codable {
        let memberID, memberProfileID, status, firstName: String
        let lastName, gender, email, mobile: String
        let introduction, dateOfBirth: String
        let profileImage, thumb: String
        let onBehalf: String

        enum CodingKeys: String, CodingKey {
            case memberID = "member_id"
            case memberProfileID = "member_profile_id"
            case status
            case firstName = "first_name"
            case lastName = "last_name"
            case gender, email, mobile, introduction
            case dateOfBirth = "date_of_birth"
            case profileImage = "profile_image"
            case thumb
            case onBehalf = "on_behalf"
        }
    
    static func storeMemberModel(value: [String: Any]) {
        Constants.kUserDefaults.set(value, forKey: "Member")
        
    }
    
    static func getMemberModel() -> MemberModel? {
        if let getDate = Constants.kUserDefaults.value(forKey: "Member") as? [String: Any] {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: getDate, options: .prettyPrinted)
                do {
                    let decoder = JSONDecoder()
                    return try decoder.decode(MemberModel.self, from: jsonData)
                    
                } catch let err {
                    print("Err", err)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
}


