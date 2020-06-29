//
//  YoutubeProfile.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 24.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import Foundation

/// Youtube Profile
class YoutubeChannel {
    
    /// Youtube profile List
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
    
    /// Profile items to related list
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
    
    /// Content Details of item in related list
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
    
    /// Related Playlists
    struct RelatedPlaylists: Decodable {
        let likes: String
        let favorites: String
        let uploads: String
        let watchHistory: String
        let watchLater: String
        
        enum CodingKeys: String, CodingKey {
            case likes
            case favorites
            case uploads
            case watchHistory
            case watchLater            
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            likes = try container.decode(String.self, forKey: .likes)
            favorites = try container.decode(String.self, forKey: .favorites)
            uploads = try container.decode(String.self, forKey: .uploads)
            watchHistory = try container.decode(String.self, forKey: .watchHistory)
            watchLater = try container.decode(String.self, forKey: .watchLater)
        }
    }
    
    /// Profile's Statistics
    struct Statistics: Decodable {
        let viewCount: String
        let commentCount: String
        let subscriberCount: String
        let hiddenSubscriberCount: Bool
        let videoCount: String
        
        enum CodingKeys: String, CodingKey {
            case viewCount
            case commentCount
            case subscriberCount
            case hiddenSubscriberCount
            case videoCount
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            viewCount = try container.decode(String.self, forKey: .viewCount)
            commentCount = try container.decode(String.self, forKey: .commentCount)
            subscriberCount = try container.decode(String.self, forKey: .subscriberCount)
            hiddenSubscriberCount = try container.decode(Bool.self, forKey: .hiddenSubscriberCount)
            videoCount = try container.decode(String.self, forKey: .videoCount)
        }
    }
    
    /// Snippet
    struct Snippet: Decodable {
        let publishedAt: String
        let title: String
        let description: String
        let thumbnails: CommonModels.Thumbnails
        let customUrl: String
        let country: String?
        
        enum CodingKeys: String, CodingKey {
            case publishedAt
            case title
            case description
            case thumbnails
            case customUrl
            case country
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            publishedAt = try container.decode(String.self, forKey: .publishedAt)
            title = try container.decode(String.self, forKey: .title)
            description = try container.decode(String.self, forKey: .description)
            thumbnails = try container.decode(CommonModels.Thumbnails.self, forKey: .thumbnails)
            customUrl = try container.decode(String.self, forKey: .customUrl)
            country = try? container.decode(String.self, forKey: .country)
            
        }
    }
    
    /// Localized
    struct Localized: Decodable {
        let title: String
        let description: String
        
        enum CodingKeys: String, CodingKey {
            case title
            case description
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            title = try container.decode(String.self, forKey: .title)
            description = try container.decode(String.self, forKey: .description)
        }
    }
    
}
