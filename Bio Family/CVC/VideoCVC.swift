//
//  VideoCVC.swift
//  Bio Family
//
//  Created by John on 26/12/22.
//

import UIKit
import AVKit
class VideoCVC: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var shadowBlack: UIView!
    @IBOutlet weak var blueBox: UIView!
    
    @IBOutlet weak var lbVideosTitle: UILabel!
    
    func configure(url:String){
        AVAsset(url: URL(string: url)!).generateThumbnail {[weak self]  (image) in
                    DispatchQueue.main.async {
                        guard let image = image else { return }
                        self?.thumbnail.image = image
                    }
                }
    }
}
