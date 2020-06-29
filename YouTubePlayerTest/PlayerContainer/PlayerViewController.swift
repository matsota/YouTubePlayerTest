//
//  PlayerViewController.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 28.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayerViewController: UIViewController{
    
    static let identifier = "PlayerViewController"
    
    //MARK: Override
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.coralEntrepriseColor.cgColor, UIColor.purpleEntrepriseColor.cgColor]
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    //MARK: WebView
    @IBOutlet private weak var youtubeView: YTPlayerView!
    
    //MARK: Label
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    //MARK: TextView
    @IBOutlet weak var descriptionTextView: UITextView!
}









//MARK: Content delegate from parent view controller
extension PlayerViewController: ContentDelegate {
    
    func updateVideo(id: String, title: String, description: String) {
        youtubeView.load(withVideoId: id)
        videoTitleLabel.text = title
        descriptionTextView.text = description
    }
    
}
