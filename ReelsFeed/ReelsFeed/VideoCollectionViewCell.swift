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

protocol VideoCollectionViewCellDelegate: AnyObject {
    
    func didTapLike(with model: VideoModel)
    func didTapProfile(with model: VideoModel)
    func didTapComment(with model: VideoModel)
    func didTapShare(with model: VideoModel)
    
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    private var model: VideoModel?
    
    // Labels
    private let usenameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    private let audioTrackLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    // Buttons
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "person.circle")?.withTintColor(.white), for: .normal)
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)

        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "text.bubble.fill"), for: .normal)

        return button
    }()
    
    private let videoContainer = UIView()

    //Delegate
    
    weak var delegate: VideoCollectionViewCellDelegate?
    
    //subviews
    var player: AVPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addSubviews() {
        
        contentView.addSubview(videoContainer)
        
        contentView.addSubview(usenameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(audioTrackLabel)
        
        contentView.addSubview(profileButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(likeButton)
        
         
        
        //Adding actions
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        profileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchDown)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchDown)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchDown)
                
        videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
        
    }
    
    @objc private func didTapLikeButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapLike(with: model)
    }
    
    @objc private func didTapShareButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapShare(with: model)
    }
    
    @objc private func didTapCommentButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapComment(with: model)
    }
    
    @objc private func didTapProfileButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapProfile(with: model)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoContainer.frame = contentView.bounds
        
        let size = contentView.frame.size.width / 7;
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height - 100

        //buttons
        shareButton.frame = CGRect(x: width - size , y: height - size, width: size, height: size)
        commentButton.frame = CGRect(x: width - size , y: height - (size*2)-10, width: size, height: size)
        likeButton.frame = CGRect(x: width - size , y: height - (size*3)-10, width: size, height: size)
        profileButton.frame = CGRect(x: width - size , y: height - (size*4)-10, width: size, height: size)
        
        //labels
        audioTrackLabel.frame = CGRect(x: 5, y: height-30, width: width - size - 10, height:  50)
        captionLabel.frame = CGRect(x: 5, y: height-80, width: width - size - 10, height:  50)
        usenameLabel.frame = CGRect(x: 5, y: height-120, width: width - size - 10, height:  50)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
        usenameLabel.text = nil
        audioTrackLabel.text = nil
    }
    
    public func configure(with model: VideoModel) {
        self.model = model
        configureVideo()
        
        //labels
        captionLabel.text = model.caption
        usenameLabel.text = model.username
        audioTrackLabel.text = model.audioTrackName
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
        playerView.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
}
