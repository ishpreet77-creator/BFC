//
//  WelcomeScreenVC.swift
//  Bio Family
//
//  Created by John on 24/12/22.
//

import UIKit

class WelcomeScreenVC: BaseViewController {
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //MARK: action login
    @IBAction func actionLogin(_ sender: Any) {
        let _: LoginVC = self.open()
    }
    //MARK: action signup
    @IBAction func actionSignup(_ sender: Any) {
        let _: SignupVC = self.open()
        
    }
    
    @IBAction func actionTermsAndCondition(_ sender: UITapGestureRecognizer) {
    }
    @IBAction func actionPrivacyPolicy(_ sender: UITapGestureRecognizer) {
    }
    
    
}
