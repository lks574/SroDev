//
//  User.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import Foundation

struct User: Codable{
    let userId: Int?
    let username: String?
    let profileIcon: String?
    
    enum CodingKeys: String, CodingKey{
        case username
        case userId = "user_id"
        case profileIcon = "profile_image_url"
    }
}
