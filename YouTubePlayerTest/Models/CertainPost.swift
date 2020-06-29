//
//  PostStats.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 25.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import Foundation

class CertainPost {
    
    ///List of items in certain video
    struct VideoData: Decodable {
        let items: [Items]
        
        enum CodingKeys: String, CodingKey {
            case items
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            items = try container.decode([Items].self, forKey: .items)
        }
    }

}

extension CertainPost {
    
    ///Items for related data
    struct Items: Decodable {
        let id: String
        let statistics: Statistics
        let snippet: Snippet
        
        enum CodingKeys: String, CodingKey {
            case id
            case statistics
            case snippet
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            statistics = try container.decode(Statistics.self, forKey: .statistics)
            snippet = try container.decode(Snippet.self, forKey: .snippet)
        }
    }
    
    ///Statistics data of current video
    struct Statistics: Decodable {
        let viewCount: String
        
        enum CodingKeys: String, CodingKey {
            case viewCount
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewCount = try container.decode(String.self, forKey: .viewCount)
        }
    }
    
    ///Snippet data of item in related video
    struct Snippet: Decodable {
        let title: String
        let thumbnails: CommonModels.Thumbnails
        
        enum CodingKeys: String, CodingKey {
            case title
            case thumbnails
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            title = try container.decode(String.self, forKey: .title)
            thumbnails = try container.decode(CommonModels.Thumbnails.self, forKey: .thumbnails)
        }
    }
    
}

