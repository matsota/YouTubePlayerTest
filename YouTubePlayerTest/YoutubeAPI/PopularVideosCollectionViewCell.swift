//
//  PopularVideosCollectionViewCell.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 27.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import UIKit
import Alamofire

class PopularVideosCollectionViewCell: UICollectionViewCell {
    
    var videoId: String?
    
    /// Cell modifier
    static let identifier = "PopularVideosCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PopularVideosCollectionViewCell", bundle: nil)
    }
    
    //MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        request?.cancel()
        request = nil
    }
    
    //MARK: - Fill
    func fill(videoId: String){
        self.videoId = videoId
        request = NetworkMaganer.shared.loadCertainVideo(id: videoId, success: { (data) in
            DispatchQueue.main.async {
                let fetch = data.items,
                medium = fetch.map({$0.snippet.thumbnails.medium}),
                imageURL = medium.map({$0.map({$0.url})})
                
                if let url = URL(string: (imageURL.first!!)) {
                    guard  let imageData = try? Data(contentsOf: url)else {return}
                    self.thumbnailsImageView.image = UIImage(data: imageData)
                }else{
                    print("ERROR: collectionView cellForItemAt: image Link")
                }
                
                let count = fetch.map({$0.statistics.viewCount})
                self.viewQuantityLabel.text = "\(count.first ?? "Нет") просмотров"
                
                let name = fetch.map({$0.snippet.title})
                self.postTitleLabel.text = name.first
            }
        }) { (error) in
            print("ERROR: ChosenPlayListCollectionView: FILL: loadPostStatistics: ", error.localizedDescription)
        }
        
    }
    
    //MARK: - Private Implementation
    private var request: Request?
    
    //MARK: Image View
    @IBOutlet weak var thumbnailsImageView: UIImageView!
    
    //MARK: Label
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var viewQuantityLabel: UILabel!
    

}
