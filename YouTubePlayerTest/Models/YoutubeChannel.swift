//
//  YoutubeProfile.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 24.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import Foundation

class YoutubeChannel {
    
    ///Youtube channel List
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

extension YoutubeChannel {
    
    ///Channel items in related list
    struct Items: Decodable {
        let contentDetails: ContentDetails
        let statistics: Statistics
        let snippet: Snippet
        
        enum CodingKeys: String, CodingKey {
            case contentDetails
            case statistics
            case snippet
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            contentDetails = try container.decode(ContentDetails.self, forKey: .contentDetails)
            statistics = try container.decode(Statistics.self, forKey: .statistics)
            snippet = try container.decode(Snippet.self, forKey: .snippet)
        }
    }
    
    ///Content Details of item in related list
    struct ContentDetails: Decodable {
        let relatedPlaylists: RelatedPlaylists
        
        enum CodingKeys: String, CodingKey {
            case relatedPlaylists
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            relatedPlaylists = try container.decode(RelatedPlaylists.self, forKey: .relatedPlaylists)
        }
    }
    
    ///Related Playlists in related content details
    struct RelatedPlaylists: Decodable {
        let uploads: String

        enum CodingKeys: String, CodingKey {
            case uploads
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            uploads = try container.decode(String.self, forKey: .uploads)
        }
    }
    
    ///Statistics of channel in relater list
    struct Statistics: Decodable {
        let subscriberCount: String
        
        enum CodingKeys: String, CodingKey {
            case subscriberCount
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            subscriberCount = try container.decode(String.self, forKey: .subscriberCount)
        }
    }
    
    ///Snippet data of item in related list
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
