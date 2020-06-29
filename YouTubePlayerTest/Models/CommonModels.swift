//
//  CommonModels.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 24.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import Foundation

class CommonModels {

    ///Thumbnails
    struct Thumbnails: Decodable {
        let `default`: ImageIndicators?
        let medium: ImageIndicators?
        let high: ImageIndicators?
        let standard: ImageIndicators?
        let maxres: ImageIndicators?
        
        enum CodingKeys: String, CodingKey {
            case `default`
            case medium
            case high
            case standard
            case maxres
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            `default` = try? container.decode(ImageIndicators.self, forKey: .default)
            medium = try? container.decode(ImageIndicators.self, forKey: .medium)
            high = try? container.decode(ImageIndicators.self, forKey: .high)
            standard = try? container.decode(ImageIndicators.self, forKey: .standard)
            maxres = try? container.decode(ImageIndicators.self, forKey: .maxres)
        }
    }

    ///Image Indicators
    struct ImageIndicators: Decodable {
        let url: String
        let width: Int
        let height: Int
        
        enum CodingKeys: String, CodingKey {
            case url
            case width
            case height
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            url = try container.decode(String.self, forKey: .url)
            width = try container.decode(Int.self, forKey: .width)
            height = try container.decode(Int.self, forKey: .height)
        }
    }
    
    ///Resource ID
    struct ResourceID: Decodable {
        let kind: String
        let videoId: String
        
        enum CodingKeys: String, CodingKey {
            case kind
            case videoId
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            kind = try container.decode(String.self, forKey: .kind)
            videoId = try container.decode(String.self, forKey: .videoId)
        }
        
    }
    
}
