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
//        languageAlert()
    }
    func languageAlert(){
        let alertmessage = UIAlertController(title: "Biofamily", message: "App language can be set as a system language, If you can change language please Signup or Login then go to setting language  and chane language\n Thankyou", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        alertmessage.addAction(actionOk)
        present(alertmessage, animated: true, completion: nil)
//        window?.rootViewController?.present(alertmessage, animated: true, completion: nil)
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
