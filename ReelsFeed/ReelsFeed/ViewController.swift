//
//  ViewController.swift
//  ReelsFeed
//
//  Created by Aditya Ambekar on 10/09/20.
//  Copyright © 2020 Radioactive Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //collection view
    private var collectionView: UICollectionView?
    
    //data array
    private var data = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<2 {
            let model1 = VideoModel(caption: "My new Phone",
                                    username: "Ashu",
                                    audioTrackName: "Dheeme",
                                    videoFileName: "1",
                                    videoFileFormat: "mp4")
            let model2 = VideoModel(caption: "Rahul Ganhi meme",
                                    username: "Modi",
                                    audioTrackName: "Jadoo",
                                    videoFileName: "2",
                                    videoFileFormat: "mp4")
            let model3 = VideoModel(caption: "My first time playing keyboard",
                                    username: "Aditya",
                                    audioTrackName: "Fur Elise",
                                    videoFileName: "3",
                                    videoFileFormat: "mp4")
            data.append(model1)
            data.append(model2)
            data.append(model3)
        }

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width,
                                 height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(VideoCollectionViewCell.self,
                                 forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier,
                                                      for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell;
    }
}

extension ViewController: VideoCollectionViewCellDelegate {
    func didTapLike(with model: VideoModel) {
        print("Like button tapped")
    }
    
    func didTapProfile(with model: VideoModel) {
        print("Profile button tapped")

    }
    
    func didTapComment(with model: VideoModel) {
        print("Comment button tapped")
    }
    
    func didTapShare(with model: VideoModel) {
        print("Share button tapped")

    }
    
    
}

