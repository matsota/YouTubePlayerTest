//
//  ViewController.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 24.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import UIKit

class YoutubeAPIViewController: UIViewController {
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Network
        NetworkMaganer.shared.loadYouTubeProfiles(success: { (data) in
            self.youtubeProfile = data
        }) { (error) in
            print("ERROR: NetworkMaganer.shared.loadYouTubeProfiles: ", error.localizedDescription)
        }
        
        //                NetworkMaganer.shared.loadYouTubePosts(success: { (data) in
        //                    self.postData = data
        //                    print("postData: ", self.postData)
        //        //            print("data: ", data)
        //                }) { (error) in
        //                    print("ERROR: NetworkMaganer.shared.loadYouTubePosts: ", error.localizedDescription)
        //                }
    }
    
    var youtubeProfile = [YoutubeProfile.Result]()
    var postData: YoutubePostList?
    
}

