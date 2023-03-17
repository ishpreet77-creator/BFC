//
//  LoginVC.swift
//  Bio Family
//
//  Created by John on 26/12/22.
//

import UIKit

class LoginVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var eye1: UIImageView!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var email: UITextField!
    //MARK: constant
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        obserSignINResponse()
        // Do any additional setup after loading the view.
    }
    //MARK: Forgot screen
    @IBAction func forgtPassword(_ sender: UIButton) {
        let _: ForgotPassword = self.open()
    }
    //MARK: actionLogin
    @IBAction func actionLogin(_ sender: UIButton) {
        if email.text == ""{
            toast(Constants.Localicable.enterEmail)
        }
        else if !isValidEmail(email.text ?? ""){
            toast(Constants.Localicable.enterVaildEmail)
        }
        else if tfPassword.text == ""{
            toast(Constants.Localicable.eterVaildPassword)
        }
//        else if isPasswordValid(tfPassword.text ?? ""){
//            showAlert("Password length is 8.\nUpperCase letters in Password.\nOne Special Character in Password.T\nwo Number in Password.\nThree letters of lowercase in password")
//        }
        else{
            AppDefaults.loginBy = "register"
            uploadVM.loginUser(AuthRequest(email:email.text ?? "",password: tfPassword.text ?? "", fcmToken: AppDefaults.fcmToken,deviceId: UIDevice.current.identifierForVendor!.uuidString))
        }
        
        //let _: TabbarVC = self.open()
    }
    //MARK: eyeAction
    @IBAction func actionEye(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            eye1.image =  Constants.AppAssets.eyeClosed
            tfPassword.isSecureTextEntry = false
            
        }
        else{
            eye1.image =  Constants.AppAssets.eye
            tfPassword.isSecureTextEntry = true
        }
        
    }
    
    //MARK: SOCIAL LOGIN
    @IBAction func actionGoogleTapped(_ sender: UITapGestureRecognizer) {
        AppDefaults.loginBy = "google"
        GoogleSignInHelper.shared.googleSignIn(with: self) { gdata in
            AppDefaults.userEmail = gdata?.email ?? ""
            self.uploadVM.socialLogin(SocialLogin(login_type: "google", facebook_id: "", google_id: gdata?.id ?? "", auth_id: "", email: gdata?.email ?? "", fcmToken: "", deviceId: UIDevice.current.identifierForVendor!.uuidString, firstName: gdata?.firstName ?? ""))
        }
        
    }
    
    @IBAction func facebookTapped(_ sender: UITapGestureRecognizer) {
        
        AppDefaults.loginBy = "facebook"
        FacebookSignInHelper.shared.facebookSignIn(with: self) { fbData in
            if let fbData = fbData{
                AppDefaults.userEmail = fbData.email ?? ""
                
                self.uploadVM.socialLogin(SocialLogin(login_type: "facebook", facebook_id: fbData.id ?? "", google_id:"", auth_id: "", email: fbData.email ?? "", fcmToken: "", deviceId: UIDevice.current.identifierForVendor!.uuidString, firstName: fbData.firstName ?? ""))
            }
        }
    }
    
    
    @IBAction func appleTapped(_ sender: UITapGestureRecognizer) {
        AppDefaults.loginBy = "apple"
        AppleLoginHelper.shared.AppleSignIn(with: self) { appleData in
            if let appleData = appleData{
                AppDefaults.userEmail = appleData.email ?? ""
                self.uploadVM.socialLogin(SocialLogin(login_type: "apple", facebook_id: "", google_id:"", auth_id: appleData.id ?? "", email: appleData.email ?? "", fcmToken: "", deviceId: UIDevice.current.identifierForVendor!.uuidString, firstName: appleData.firstName ?? ""))
            }
        }
    }
    //MARK: signup
    @IBAction func signUpTapped(_ sender: UITapGestureRecognizer) {
        let _: SignupVC = self.open()
    }
    
    
    @IBAction func actionTermsCondition(_ sender: UITapGestureRecognizer) {
        
    }
    
    @IBAction func privacyPolicy(_ sender: UITapGestureRecognizer) {
    }
    //MARK: observer for login
    fileprivate func obserSignINResponse(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                
                AppDefaults.userData = response?.userData ?? LoginReponse()
                DispatchQueue.main.async {
                    let story = UIStoryboard(name: Constants.AppStatic.storyBoard, bundle:nil)
                    let vc = story.instantiateViewController(withIdentifier: Constants.AppStatic.drawerNavigation) as! UINavigationController
                    
                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
}
