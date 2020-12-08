//
//  Stories.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import Foundation

struct Stories: Codable{
    let user: UserInsta
    let isWatched: Bool?
    
    enum CodingKeys: String, CodingKey{
        case user
        case isWatched = "is_watched"
    }
}
