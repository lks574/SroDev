//
//  NewsFeed.swift
//  TextureSample
//
//  Created by sro on 2020/12/07.
//

import Foundation

struct NewsFeed: Codable{
    let user: UserInsta?
    let imageUrl: String?
    let aspectRatio: Double?
    let likes: Int?
    let lastComment: Comment?
    let postId: Int
    
    enum CodingKeys: String, CodingKey{
        case user, likes
        case imageUrl = "image_url"
        case aspectRatio = "aspect_ratio"
        case lastComment = "last_comment"
        case postId = "post_id"
    }
    
}
