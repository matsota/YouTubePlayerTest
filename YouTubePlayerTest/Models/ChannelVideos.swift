//
//  ChannelVideos.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 24.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import Foundation

class ChannelVideos {
    
    ///Youtube PostList
    struct List: Decodable {
        let items: [Items]
        
        enum CodingKeys: String, CodingKey {
            case items
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            items = try container.decode([ChannelVideos.Items].self, forKey: .items)
        }
    }
}

extension ChannelVideos {
    
    ///Items for related List
    struct Items: Decodable {
        let id: String
        let snippet: Snippet
        
        enum CodingKeys: String, CodingKey {
            case id
            case snippet
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            snippet = try container.decode(Snippet.self, forKey: .snippet)
        }
    }

    ///Snippet data of item in related list
    struct Snippet: Decodable {
        let title: String
        let channelTitle: String
        let description: String
        let resourceId: CommonModels.ResourceID
        
        enum CodingKeys: String, CodingKey {
            case title
            case channelTitle
            case description
            case resourceId
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            title = try container.decode(String.self, forKey: .title)
            channelTitle = try container.decode(String.self, forKey: .channelTitle)
            description = try container.decode(String.self, forKey: .description)
            resourceId = try container.decode(CommonModels.ResourceID.self, forKey: .resourceId)
        }
    }
}




