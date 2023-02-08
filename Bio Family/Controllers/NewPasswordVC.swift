//
//  NewPasswordVC.swift
//  Bio Family
//
//  Created by John on 26/12/22.
//

import UIKit

class NewPasswordVC: BaseViewController {
    //MARK: outlet
    @IBOutlet weak var eye2: UIImageView!
    @IBOutlet weak var eye1: UIImageView!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    //MARK: variable
    var otp:String?
    var email:String?
    //MARK: constant
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        obserSignINResponse()
        
    }
    //MARK: actionConfirm
    @IBAction func actionConfirm(_ sender: UIButton) {
        if tfPassword.text == ""{
            toast("Please enter password")
        }
        else if tfConfirmPassword.text == ""{
            toast("Please enter Confirm Password")
        }
        else if tfPassword.text != tfConfirmPassword.text{
            toast("Password and confirm password is not same")
        }
        else{
            if let email = self.email,let pass = tfPassword.text,let otp = self.otp{
                uploadVM.reset(ForgetReqst(otp: otp, email: email, password: pass))
            }
        }
        
    }
    //MARK: action
    @IBAction func actionBack(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionEye(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            if sender.tag == 0{
                eye1.image =  Constants.AppAssets.eyeClosed
                tfPassword.isSecureTextEntry = false
            }
            else{
                eye2.image =  Constants.AppAssets.eyeClosed
                tfConfirmPassword.isSecureTextEntry = false
            }
        }
        else{
            if sender.tag == 0{
                eye1.image = Constants.AppAssets.eye
                tfPassword.isSecureTextEntry = true
            }
            else{
                eye2.image =  Constants.AppAssets.eye
                tfConfirmPassword.isSecureTextEntry = true
            }
            
        }
    }
    
    //MARK: observer
    fileprivate func obserSignINResponse(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                if self.uploadVM.type == .refresh{
                    
                }else{
                    let _: ResetSucessfullVC = self.open()
                    }
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
}
