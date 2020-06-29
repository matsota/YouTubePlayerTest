//
//  NetworkManager.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 24.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import Foundation
import Alamofire

class NetworkMaganer {
    
    static let shared = NetworkMaganer()
    
    enum Error: Swift.Error {
        case notFound
    }
    
    //MARK:  Load Youtube Profiles
    private func channelAPI(channel id: String) -> String {
        
        let api = "https://www.googleapis.com/youtube/v3/channels?id=\(id)&key=\(AppDelegate.APIKey)"
        return api
    }
    func loadYoutubeProfiles(success: @escaping ([YoutubeChannel.List]) -> Void,
                             failure: @escaping (Swift.Error) -> Void) {
        let parameters: [String: Any] = ["part": "snippet,contentDetails,statistics"]
        var list = [YoutubeChannel.List]()
        for i in channelAPIsArray{
            AF.request(channelAPI(channel: i), parameters: parameters).validate().responseDecodable{ (response: DataResponse<YoutubeChannel.List, AFError>) in
                switch response.result {
                case .success(let result):
                    list.append(result)
                    success(list)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
    
    //MARK: Load Youtube Posts
    private func postsAPI(post id: String) -> String {
        let api =
        "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=\(id)&key=\(AppDelegate.APIKey)"
        return api
    }
    func loadYoutubePlaylist(post: String, resultCount: Int,
                          success: @escaping ([ChannelVideos.Items]) -> Void,
                          failure: @escaping (Swift.Error) -> Void) {
        let parameters: [String: Any] = ["part": "snippet,contentDetails", "maxResults": resultCount]
        AF.request(postsAPI(post: post), parameters: parameters).validate().responseDecodable{ (response: DataResponse<ChannelVideos.List, AFError>) in
            switch response.result {
            case .success(let result):
                success(result.items)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    //MARK: Load Youtube Most popular API
    private func mostPopularAPI() -> String {
        let api = "https://www.googleapis.com/youtube/v3/videos?chart=mostPopular&key=\(AppDelegate.APIKey)"
        return api
    }
    func loadMostPuopularVideos(resultCount: Int,
                          success: @escaping ([MostPopular.Items]) -> Void,
                          failure: @escaping (Swift.Error) -> Void) {
        let parameters: [String: Any] = ["part": "snippet", "maxResult": resultCount]
        AF.request(mostPopularAPI(), parameters: parameters).validate().responseDecodable{ (response: DataResponse<MostPopular.List, AFError>) in
            switch response.result {
            case .success(let result):
                success(result.items)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    //MARK: Load Certain Youtube Video
    private func youtubeVideoAPI(video id: String) -> String {
        let api = "https://www.googleapis.com/youtube/v3/videos?id=\(id)&key=\(AppDelegate.APIKey)"
        return api
    }
    func loadCertainVideo(id: String,
                          success: @escaping (CertainPost.VideoData) -> Void,
                          failure: @escaping (Swift.Error) -> Void) -> Request? {
        let parameters: [String: Any] = ["part": "snippet,contentDetails,statistics"]
        let request = AF.request(youtubeVideoAPI(video: id), parameters: parameters).validate().responseDecodable{ (response: DataResponse<CertainPost.VideoData, AFError>) in
            switch response.result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure(error)
            }
        }
        return request
    }
        
    
    private let channelAPIsArray = ["UCZW5lIUz93q_aZIkJPAC0IQ", "UC4PooiX37Pld1T8J5SYT-SQ", "UCAuUUnT6oDeKwE6v1NGQxug", "UC54G_D84F9VE_5anGVd84fA"]
}
