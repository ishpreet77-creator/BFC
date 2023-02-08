//
//  ForgotPassword.swift
//  Bio Family
//
//  Created by John on 26/12/22.
//

import UIKit

class ForgotPassword: BaseViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        forgetObserveResp()
        // Do any additional setup after loading the view.
    }
    //MARK: observer forgot
    fileprivate func forgetObserveResp(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                let _: OtpVC = self.open(){
                    $0.email = self.tfEmail.text ?? ""
                    $0.newAccount = false
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
    
    //MARK: action Forgot
    @IBAction func actionContinue(_ sender: UIButton) {
        if !isValidEmail(tfEmail.text ?? ""){
            toast("Please enter valid email id")
        }
        else{
            uploadVM.forget(ForgetReqst(email:tfEmail.text ?? ""))
        }
        
    }
    
    
}

