//
//  OtpVC.swift
//  Bio Family
//
//  Created by John on 26/12/22.
//

import UIKit

class OtpVC: BaseViewController {
    
    //MARK: outlet
    @IBOutlet weak var tfOtp: UITextField!
    
    
    @IBOutlet weak var lblOtpMessgae: UILabel!
    
    //MARK: variable
    var newAccount:Bool = false
    var authData:AuthRequest?
    var otp:String?
    var email:String?
   
    //MARK: constant
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        obserSignINResponse()
    }
    override func viewWillAppear(_ animated: Bool) {
        lblOtpMessgae.text = "We have sent a 4-digit verification code on \n your email id \(email ?? "")"
    }
    //MARK: observer Otp
    fileprivate func obserSignINResponse(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                if self.uploadVM.type == .forget{
                    self.showAlert("Otp sent to your mail")
                }
                else if self.uploadVM.type == .resend{
                    self.showAlert("Otp sent to your mail")
                    self.otp = response?.data
                }
                else{
                    if self.newAccount{
                        let _: LoginVC = self.open()
                    }
                    else{
                        let _: NewPasswordVC = self.open{
                            $0.otp = self.tfOtp.text ?? ""
                            $0.email = self.email
                        }
                    }
                }
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
    //MARK: action
    @IBAction func actionBack(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: action Verify
    @IBAction func actionVerify(_ sender: UIButton) {
        if newAccount{
            if let otp = self.otp{
                if tfOtp.text == otp{
                    if let data = self.authData{
                        uploadVM.signUpUser(data)
                    }
                }
                else{
                    self.showAlert("Wrong otp")
                }
            }
        }
        else{
            if let email = self.email{
                uploadVM.verify(ForgetReqst(otp: tfOtp.text ?? "", email: email))
            }
        }
        
        
        
    }
    
    @IBAction func actionResend(_ sender: UIButton) {
        if newAccount == (self.email != nil){
            uploadVM.resend(ForgetReqst(email:email ?? ""))
        }else{
            uploadVM.forget(ForgetReqst(email:email ?? ""))
        }
        
    }
}
