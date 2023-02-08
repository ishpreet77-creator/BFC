//
//  SettingVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit

class SettingVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var topNavView: UIViewX!
    //MARK: constant
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func actionSubmitReview(_ sender: UITapGestureRecognizer) {
        let _: SubmitReviewVC = self.open()
    }
    
    @IBAction func actionLogout(_ sender: UIButton) {
        uploadVM.logout(LogoutReqst(userID: AppDefaults.userData.userId, device_id: UIDevice.current.identifierForVendor!.uuidString))
        
    }
    @IBAction func actionContactUS(_ sender: UITapGestureRecognizer) {
        let _: ContactUsVC = self.open()
    }
    //MARK: observier Function
    fileprivate func observeLogoutResp(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                if self.uploadVM.type == .refresh{
//                    self.uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
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
