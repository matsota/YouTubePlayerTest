//
//  ChannelCollectionViewCell.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 25.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import UIKit

class ChannelCollectionViewCell: UICollectionViewCell {
    /// Cell modifier
    static let identifier = "ChannelCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "ChannelCollectionViewCell", bundle: nil)
    }
    
    //MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 10
        channelTitleLabel.textColor = UIColor.backgroundEntrepriseColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.coralEntrepriseColor.cgColor, UIColor.purpleEntrepriseColor.cgColor]
        gradient.frame = imagePlayBackView.bounds

        imagePlayBackView.layer.insertSublayer(gradient, above: imagePlayBackView.layer)
        imagePlayBackView.layer.cornerRadius = imagePlayBackView.frame.height / 2
    }
    
    //MARK: - Fill
    func fill (channelTitle: String, channelSubcribers: String, imageURL: String) {
        DispatchQueue.main.async {
            self.channelTitleLabel.text = channelTitle
            self.channelSubcribersLabel.text = channelSubcribers + " подписчикa"
            
            guard let url = URL(string: imageURL),
            let data = try? Data(contentsOf: url)else {return}
            self.channelImageView.image = UIImage(data: data)
        }
    }
    
    //MARK: - Private Implementation
    
    //MARK: View
    @IBOutlet weak var imagePlayBackView: UIView!
    
    //MARK: Image View
    @IBOutlet weak var channelImageView: UIImageView!
    
    //MARK: Label
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelSubcribersLabel: UILabel!
}
