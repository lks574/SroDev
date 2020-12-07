//
//  BaseDataSource.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import Foundation

struct BaseDataSource: Codable{
    var myUser: User?
    var stories: [Stories]?
    var newsFeed: [NewsFeed]?
    
    enum CodingKeys: String, CodingKey {
        case myUser = "my_user"
        case stories
        case newsFeed = "news_feed"
    }
}
