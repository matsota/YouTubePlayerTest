//
//  PostStats.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 25.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import Foundation

class CertainPost {
    
    /// Result
    struct Result: Decodable {
        let items: [Items]
        let pageInfo: CommonModels.PageInfo
        
        enum CodingKeys: String, CodingKey {
            case items
            case pageInfo
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            items = try container.decode([Items].self, forKey: .items)
            pageInfo = try container.decode(CommonModels.PageInfo.self, forKey: .pageInfo)
        }
    }

}

extension CertainPost {
    
    /// Items
    struct Items: Decodable {
        let id: String
        let statistics: Statistics
        
        enum CodingKeys: String, CodingKey {
            case id
            case statistics
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            statistics = try container.decode(Statistics.self, forKey: .statistics)
        }
    }
    
    /// Statistics
    struct Statistics: Decodable {
        let viewCount: String
        let likeCount: String
        let dislikeCount: String
        let favoriteCount: String
        let commentCount: String
        
        enum CodingKeys: String, CodingKey {
            case viewCount
            case likeCount
            case dislikeCount
            case favoriteCount
            case commentCount
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewCount = try container.decode(String.self, forKey: .viewCount)
            likeCount = try container.decode(String.self, forKey: .likeCount)
            dislikeCount = try container.decode(String.self, forKey: .dislikeCount)
            favoriteCount = try container.decode(String.self, forKey: .favoriteCount)
            commentCount = try container.decode(String.self, forKey: .commentCount)
        }
    }
    
}

