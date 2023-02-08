//
//  HomeCVC.swift
//  Bio Family
//
//  Created by John on 26/12/22.
//

import UIKit

class HomeCVC: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var widthCont: NSLayoutConstraint!
    @IBOutlet weak var backGround: UIImageViewX!
    @IBOutlet weak var colorView: UIViewX!
    @IBOutlet weak var title: UILabel!
    
    
    
    func configure(){
       //widthCont =  widthCont.constraintWithMultiplier(0.7)
        let newConstraint = widthCont.constraintWithMultiplier(0.6)
        self.removeConstraint(widthCont)
        self.addConstraint(newConstraint)
        self.layoutIfNeeded()
        widthCont = newConstraint
        
        let newConstraint2 = heightConst.constraintWithMultiplier(0.6)
        self.removeConstraint(heightConst)
        self.addConstraint(newConstraint2)
        self.layoutIfNeeded()
        heightConst = newConstraint2
    }
}
