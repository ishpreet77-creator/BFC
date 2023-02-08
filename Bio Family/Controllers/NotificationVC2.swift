//
//  NotificationVC2.swift
//  Bio Family
//
//  Created by John on 12/01/23.
//

import UIKit
import SDWebImage


class NotificationVC2: BaseViewController {
    
    @IBOutlet weak var notifyImageView: UIImageView!
    
    @IBOutlet weak var topNavView: UIViewX!
    @IBOutlet weak var lblBody: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var imageview = ""
    var notifyTitle = ""
    var notifyBody = ""
    var  isfromnotification = false
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        
//        self.notifyImageView.sd_setImage(with: URL(string: imageview))
//        self.lblBody.text = notifyBody
//        self.lblTitle.text = notifyTitle
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
                self.notifyImageView.sd_setImage(with: URL(string: imageview))
                self.lblBody.text = notifyBody
                self.lblTitle.text = notifyTitle
        self.lblTitle.isHidden = false
    }
    
    @IBAction func actionBack(_ sender: Any) {
        if isfromnotification{
            self.navigationController?.popViewController(animated: true)
        }else{
            let story = UIStoryboard(name: Constants.AppStatic.storyBoard, bundle:nil)
            let vc = story.instantiateViewController(withIdentifier: Constants.AppStatic.drawerNavigation) as! UINavigationController
            
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
}
