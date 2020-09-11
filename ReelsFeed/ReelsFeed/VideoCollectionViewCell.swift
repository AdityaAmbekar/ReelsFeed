//
//  VideoCollectionViewCell.swift
//  ReelsFeed
//
//  Created by Aditya Ambekar on 11/09/20.
//  Copyright © 2020 Radioactive Apps. All rights reserved.
//


//each cell will have around 3 labels and 4 buttons
import UIKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    private var model: VideoModel?
    
    //subviews
    var player: AVPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: VideoModel) {
        self.model = model
        configureVideo()
    }
    
    private func configureVideo() {
        
        guard let model = model else {
            return
        }
        guard let path = Bundle.main.path(forResource: model.videoFileName,
                                          ofType: model.videoFileFormat) else {
                                            return
        }
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        contentView.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
}
