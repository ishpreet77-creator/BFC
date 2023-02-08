//
//  ChangePasswordVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit

class ChangePasswordVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var eye2: UIImageView!
    @IBOutlet weak var eye1: UIImageView!
    @IBOutlet weak var eye3: UIImageView!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfoldPassword: UITextField!
    @IBOutlet weak var topNavView: UIViewX!
    //MARK: constant
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        observeChangePass()
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        // Do any additional setup after loading the view.
    }
    //MARK: action
    
    @IBAction func actionConfirm(_ sender: UIButton) {
        if tfoldPassword.text == ""{
            toast("Please enter old password")
        }
        else if tfPassword.text == ""{
            toast("Please enter password")
        }
        else if tfConfirmPassword.text == ""{
            toast("Please enter confirm password")
        }
        else if tfPassword.text != tfConfirmPassword.text{
            toast("Password Doesnot match with confirm password")
        }
        else if isPasswordValid(tfPassword.text ?? "") == false{
            showAlert("Password length is 8.\nUpperCase letters in Password.\nOne Special Character in Password.\nTwo Number in Password.\nThree letters of lowercase in password")
        }
        else{
            uploadVM.changePasswoird(ChangePassword(oldPassword: tfoldPassword.text ?? "", newPassword: tfPassword.text ?? ""))
        }
        
    }
    
    @IBAction func back(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionEye(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            if sender.tag == 0{
                eye1.image =  Constants.AppAssets.eyeClosed
                tfoldPassword.isSecureTextEntry = false
            }
            else if sender.tag == 1{
                eye2.image =  Constants.AppAssets.eyeClosed
                tfPassword.isSecureTextEntry = false
            }
            else{
                eye3.image =  Constants.AppAssets.eyeClosed
                tfConfirmPassword.isSecureTextEntry = false
            }
        }
        else{
            if sender.tag == 0{
                eye1.image = Constants.AppAssets.eye
                tfoldPassword.isSecureTextEntry = true
            }
            else if sender.tag == 1{
                eye2.image =  Constants.AppAssets.eye
                tfPassword.isSecureTextEntry = true
            }
            else{
                eye3.image =  Constants.AppAssets.eye
                tfConfirmPassword.isSecureTextEntry = true
            }
            
        }
    }
    
    //MARK: observerFunction
    fileprivate func observeChangePass(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
//                if self.uploadVM.type == .refresh{
//                    self.uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
//                }else{
//                    DispatchQueue.main.async {
                        let _: LoginVC = self.open()
//                    }
//                }
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
    
}
