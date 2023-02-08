//
//  HealthTipsVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit

class HealthTipsVC: UIViewController {
    
    //MARK: outlets
    @IBOutlet weak var topNavView: UIViewX!
    @IBOutlet weak var clnMagazine: UICollectionView!
    //MARK: lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        clnMagazine.delegate = self
        clnMagazine.dataSource = self
    }
    //MARK: action
    @IBAction func actionBack(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//MARK: extension CollectionView delegate and datasource
extension HealthTipsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clnMagazine.dequeueReusableCell(withReuseIdentifier: "MagzineCVC", for: indexPath) as! MagzineCVC
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = clnMagazine.frame.width / 2.07
        
        return CGSize(width: width, height: UIScreen.screenHeight * 0.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
