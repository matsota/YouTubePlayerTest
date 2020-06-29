//
//  ViewController.swift
//  YouTubePlayerTest
//
//  Created by Andrew Matsota on 24.06.2020.
//  Copyright © 2020 Andrew Matsota. All rights reserved.
//

import UIKit

protocol ContentDelegate: class {
    func updateVideo(id: String, title: String, description: String)
}

class YoutubeAPIViewController: UIViewController {
    
    static let toPlayerSegueIdentifier = "home_Player"
    weak var delegate: ContentDelegate?
    
    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Setup Collection Views
        channelCollectionView.delegate = self
        channelCollectionView.dataSource = self
        channelCollectionView.register(ChannelCollectionViewCell.nib(), forCellWithReuseIdentifier: ChannelCollectionViewCell.identifier)
        channelCollectionView.backgroundColor = .backgroundEntrepriseColor
        // -
        chosenPlayListCollectionView.delegate = self
        chosenPlayListCollectionView.dataSource = self
        chosenPlayListCollectionView.register(ChosenPlayListCollectionView.nib(), forCellWithReuseIdentifier: ChosenPlayListCollectionView.identifier)
        chosenPlayListCollectionView.backgroundColor = .backgroundEntrepriseColor
        // -
        popularVideosCollectionView.delegate = self
        popularVideosCollectionView.dataSource = self
        popularVideosCollectionView.register(PopularVideosCollectionViewCell.nib(), forCellWithReuseIdentifier: PopularVideosCollectionViewCell.identifier)
        popularVideosCollectionView.backgroundColor = .backgroundEntrepriseColor
        
        /// Network
        NetworkMaganer.shared.loadYoutubeProfiles(success: { (data) in
            self.channelList = data
            let uploads = self.channelList.compactMap({$0.items.map({$0.contentDetails.relatedPlaylists.uploads})})
            guard let uploadID = uploads.first?.last else {return}
            self.chosenPlayListTitle = uploadID
            self.channelCollectionView.reloadData()
            // -
            NetworkMaganer.shared.loadYoutubePlaylist(post: self.chosenPlayListTitle, resultCount: 25, success: { (data) in
                self.chosenPlayList = data
                guard let title = self.chosenPlayList?.compactMap({$0.snippet.channelTitle}) else {return}
                self.choosenPlayListTitleLabel.text = "Playlist of: " + (title.first ?? "undefined")
                self.chosenPlayListCollectionView.reloadData()
            }) { (error) in
                print("ERROR: NetworkMaganer.shared.loadYouTubePosts: ", error.localizedDescription)
            }
        }) { (error) in
            print("ERROR: NetworkMaganer.shared.loadYouTubeProfiles: ", error.localizedDescription)
        }
        // -
        NetworkMaganer.shared.loadMostPuopularVideos(resultCount: 5, success: { (data) in
            self.mostPopularList = data
            self.popularVideosCollectionView.reloadData()
        }) { (error) in
            print("ERROR: loadMostPuopular", error.localizedDescription)
        }
        
        /// Chevron Button
        chevronButton.backgroundColor = .coralEntrepriseColor
        chevronButton.layer.cornerRadius = chevronButton.frame.height / 2
        
        /// Swipe for hide container view
        let swipeToHide = UISwipeGestureRecognizer()
        swipeToHide.addTarget(self, action: #selector(swipeToHidePerform(_:)))
        swipeToHide.direction = .down
        self.view.addGestureRecognizer(swipeToHide)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "containerController" {
            let containerVC = segue.destination as! PlayerViewController
            self.delegate = containerVC
        }
    }
    
    @IBAction func chevronTapped(_ sender: UIButton) {
        moveContainerView()
    }
    
    
    //MARK: - Private Implementation
    private var channelList = [YoutubeChannel.List]()
    
    private var chosenPlayList: [ChannelVideos.Items]?
    private var chosenPlayListTitle = String()
    
    private var mostPopularList: [MostPopular.Items]?
    
    //MARK: Collection view
    @IBOutlet private weak var channelCollectionView: UICollectionView!
    @IBOutlet private weak var chosenPlayListCollectionView: UICollectionView!
    @IBOutlet private weak var popularVideosCollectionView: UICollectionView!
    
    //MARK: Label
    @IBOutlet private weak var choosenPlayListTitleLabel: UILabel!
    
    //MARK: Button
    @IBOutlet private weak var chevronButton: UIButton!

    //MARK: Container View
    @IBOutlet private weak var playerContainerView: UIView!
    @IBOutlet private weak var hideContainerButton: UIButton!
    
    //MARK: Constraint
    @IBOutlet private weak var chevronButtonBottomConstraint: NSLayoutConstraint!
    
}









//MARK: Collection View
extension YoutubeAPIViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == channelCollectionView {
            return channelList.count
        }else if collectionView == chosenPlayListCollectionView{
            let count = chosenPlayList?.count
            return count ?? 0
        }else{
            let count = mostPopularList?.count
            return count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == channelCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCollectionViewCell.identifier, for: indexPath) as! ChannelCollectionViewCell
            
            let fetch = channelList[indexPath.row],
            channelTitle = fetch.items.map({$0.snippet.title}),
            channelSubcribers = fetch.items.map({$0.statistics.subscriberCount})
            var imageURL = String()
            if let medium: [CommonModels.ImageIndicators] = fetch.items.map({$0.snippet.thumbnails.medium}) as? [CommonModels.ImageIndicators] {
                let url = medium.map({$0.url})
                imageURL = url.first!
            }else{
                print("ERROR: collectionView cellForItemAt: image Link")
            }
            guard let title = channelTitle.first,
                let subcribers = channelSubcribers.first else {return cell}
            cell.fill(channelTitle: title, channelSubcribers: subcribers, imageURL: imageURL)
            return cell
        }else if collectionView == chosenPlayListCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChosenPlayListCollectionView.identifier, for: indexPath) as! ChosenPlayListCollectionView
            
            guard let fetch = chosenPlayList?.compactMap({$0.snippet})[indexPath.row] else {return cell}
            
            let videoId = fetch.resourceId.videoId
            
            cell.fill(videoId: videoId)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularVideosCollectionViewCell.identifier, for: indexPath) as! PopularVideosCollectionViewCell
            
            guard let fetch = mostPopularList?.compactMap({$0})[indexPath.row] else {return cell}
            
            let videoId = fetch.id
            
            cell.fill(videoId: videoId)

            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width : CGFloat
        var height: CGFloat
        if collectionView == channelCollectionView{
            width = view.frame.width * 0.85 - 10
            height = view.frame.height * 0.25
        }else if collectionView == chosenPlayListCollectionView{
            width = view.frame.width * 0.5 - 10
            height = view.frame.height * 0.2
        }else{
            width = 100
            height = view.frame.height * 0.3
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ///Channel CollectionView
        if collectionView == channelCollectionView{
            let fetch = channelList[indexPath.row]
            let upload = fetch.items.map({$0.contentDetails.relatedPlaylists.uploads})
            guard let uploadID = upload.first else {return}
            NetworkMaganer.shared.loadYoutubePlaylist(post: uploadID, resultCount: 25, success: { (data) in
                self.chosenPlayList = data
                guard let title = self.chosenPlayList?.compactMap({$0.snippet.channelTitle}) else{return}
                self.choosenPlayListTitleLabel.text = "Playlist of: " + (title.first ?? "undefined")
                self.chosenPlayListCollectionView.reloadData()
            }) { (error) in
                print("ERROR: NetworkMaganer.shared.loadYouTubePosts: ", error.localizedDescription)
            }
        }
        ///Chosen Play List CollectionView
        else if collectionView == chosenPlayListCollectionView {
            guard let fetch = chosenPlayList?[indexPath.row] else {return}
            let id = fetch.snippet.resourceId.videoId,
            title = fetch.snippet.title,
            description = fetch.snippet.description
            delegate?.updateVideo(id: id, title: title, description: description)
            moveContainerView()
        }
        ///Most Popular CollectionView
        else{
            guard let fetch = mostPopularList?[indexPath.row] else {return}
            let id = fetch.id,
            title = fetch.snippet.title,
            description = fetch.snippet.description
            
            delegate?.updateVideo(id: id, title: title, description: description)
            moveContainerView()
        }
    }
    
}

//MARK: - Hide unhide any
private extension YoutubeAPIViewController {
    
    func moveContainerView() {
        if chevronButtonBottomConstraint.constant == 0 {
            chevronButtonBottomConstraint.constant = playerContainerView.bounds.height - chevronButton.frame.height
            hideContainerButton.isUserInteractionEnabled = true
            let down = UIImage(systemName: "chevron.down")
            chevronButton.setImage(down, for: .normal)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }else{
            chevronButtonBottomConstraint.constant = 0
            hideContainerButton.isUserInteractionEnabled = false
            let up = UIImage(systemName: "chevron.up")
            chevronButton.setImage(up, for: .normal)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func swipeToHidePerform(_ gestureRecognizer: UISwipeGestureRecognizer) {
        chevronButtonBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}
