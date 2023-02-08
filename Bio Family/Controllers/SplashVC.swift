//
//  SplashVC.swift
//  Bio Family
//
//  Created by John on 24/12/22.
//

import UIKit

class SplashVC: BaseViewController {
    //MARK: variable
    var timer = Timer()
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    //MARK: action timer
    @IBAction func timerAction(){
//         let _: ReviewSecondVC = self.open()
        if AppDefaults.userData.token == ""{
            let _: WelcomeScreenVC = self.open()
        }
        else{
            DispatchQueue.main.async {
                let story = UIStoryboard(name: Constants.AppStatic.storyBoard, bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: Constants.AppStatic.drawerNavigation) as! UINavigationController

                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
}
