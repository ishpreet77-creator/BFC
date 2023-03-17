//
//  SettingVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit
import Foundation

class SettingVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var topNavView: UIViewX!
    @IBOutlet weak var notificationSwitch: UISwitch!
    //MARK: constant
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    
    //MARK: lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationSwitch.isOn = true
        if AppDefaults.userData.notifcation == 1{
            self.notificationSwitch.isOn = true
        }else{
            self.notificationSwitch.isOn = false
        }
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        observeLogoutResp()
    }
    //MARK: action
    @IBAction func actionBack(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionEditProfile(_ sender: UITapGestureRecognizer) {
        let _: EditProfileView = self.open()
    }
    
    @IBAction func actionChangePassword(_ sender: UITapGestureRecognizer) {
        let _: ChangePasswordVC = self.open()
    }
    
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        if (sender.isOn){
            print("###### switch on #########")
            uploadVM.notification(NotificationRequest(notification: 1))
          
          

            
//            UIApplication.shared.registerForRemoteNotifications()
        }else{
            print("###### switch OFF ######")
            uploadVM.notification(NotificationRequest(notification: 0))

        
//            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
    
    
    
    @IBAction func actionSubmitReview(_ sender: UITapGestureRecognizer) {
        let _: SubmitReviewVC = self.open{
            $0.buttonText = Constants.Localicable.submitReview
        }
    }
    
    @IBAction func actionLogout(_ sender: UIButton) {
        uploadVM.logout(LogoutReqst(userID: AppDefaults.userData.userId, device_id: UIDevice.current.identifierForVendor!.uuidString))
        
    }
    @IBAction func actionContactUS(_ sender: UITapGestureRecognizer) {
        let _: ContactUsVC = self.open()
    }
    
    
    @IBAction func actionLanguage(_ sender: Any) {
 
        showLanguageOptions()
    }
    
    
    
    
    func changeLanguage(to languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        let alertmessage = UIAlertController(title: "Biofamily", message: "Are you sure to change the app language, If you can chnage the app language, Please tap Ok then app will open again", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                                exit(EXIT_SUCCESS)}
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
        
        }
        alertmessage.addAction(actionOk)
        alertmessage.addAction(actionCancel)
        present(alertmessage, animated: true, completion: nil)
    }
    
    
    func showLanguageOptions() {
        let alert = UIAlertController(title: nil, message: "Select Language", preferredStyle: .actionSheet)
        
        let englishAction = UIAlertAction(title: "English", style: .default) { (action) in
            
            self.changeLanguage(to: "en")
        }
        
        let spanishAction = UIAlertAction(title: "Spanish", style: .default) { (action) in
            self.changeLanguage(to: "es")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(englishAction)
        alert.addAction(spanishAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    


    
    
    
    //MARK: observier Function
    fileprivate func observeLogoutResp(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                if self.uploadVM.type == .notification{
                    print(AppDefaults.userData.notifcation)
                    if AppDefaults.userData.notifcation == 0{
                        AppDefaults.userData.notifcation = 1
                    }else if AppDefaults.userData.notifcation == 1{
                        AppDefaults.userData.notifcation = 0
                    }
//                    AppDefaults.userData.notifcation = 0
                    print(AppDefaults.userData.notifcation)
//                    if AppDefaults.userData.notifcation == 1{
//                        self.notificationSwitch.isOn = false
//                    }else{
//                        self.notificationSwitch.isOn = true
//                    }
//                    if uploadVM.notification(NotificationRequest(notification: 0)){
//                        notificationSwitch.isOn = false
//                    }else{
//                        notificationSwitch.isOn = true
//                    }
                    
                }else{
                    DispatchQueue.main.async {
                        AppDefaults.selectedDrawer = -1
                        AppDefaults.selectedTab = 1
                        AppDefaults.userData = LoginReponse()
                        let _: LoginVC = self.open()
                    }
                }
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
}
