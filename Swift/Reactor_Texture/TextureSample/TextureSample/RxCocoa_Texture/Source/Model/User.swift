//
//  User.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/08.
//

import Foundation

class User: Decodable {
    var username: String = ""
    var profileURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case profileURL = "avatar_url"
    }
    
    func merge(_ user: User?) {
        guard let user = user else { return }
        self.username = user.username
        self.profileURL = user.profileURL
    }
}
