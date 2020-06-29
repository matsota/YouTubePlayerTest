//
//  MostPopular.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 27.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import Foundation

class MostPopular {
    
    /// List of popular videos
    struct List: Decodable {
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

extension MostPopular{
    
    /// Items related to most popular videos
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
    
    /// Snippet for items in related list
    struct Snippet: Decodable {
        let description: String
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case description
            case title
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            description = try container.decode(String.self, forKey: .description)
            title = try container.decode(String.self, forKey: .title)
        }
    }
    
}
