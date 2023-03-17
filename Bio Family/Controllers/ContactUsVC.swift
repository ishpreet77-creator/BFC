//
//  ContactUsVC.swift
//  Bio Family
//
//  Created by John on 28/12/22.
//

import UIKit

class ContactUsVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var topNavView: UIViewX!
    
    
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfLastname: UITextField!
    
    @IBOutlet weak var tfFirstname: UITextField!
    //MARK: constant
    private let AppointVM = AppVM.init(repository: AppRepoImp.init(rxApi: RxApi()))
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        observerContactUsResponse()
        refreshResponse()
    }
    override func viewWillAppear(_ animated: Bool) {
//          (RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
    }
    //MARK: configureUI
    fileprivate func configureUI() {
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        textView.layer.cornerRadius = 10
        textView.text = Constants.Localicable.typeMessage
        textView.textColor = UIColor.lightGray
        textView.delegate =  self
    }
    //MARK: observer Appointment
    fileprivate func observerContactUsResponse(){
        let _ =  AppointVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        AppointVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                self.navigationController?.popViewController(animated: true)
                //                if  self.AppointVM.type == .contactUs{
                //                    self.navigationController?.popViewController(animated: true)
                //                    UIView.transition(with:self.popupMainView, duration: 0.4,
                //                                      options: .transitionCrossDissolve,
                //                                      animations: {
                //                        self.popupMainView.isHidden = true
                //                                  })
                //
                //                    UIView.transition(with: self.popUp, duration: 0.4,
                //                                      options: .transitionCrossDissolve,
                //                                      animations: {
                //                        self.popUp.isHidden = true
                //                                  })
                //                    self.AppointVM.getAppointment()
                //                }
                //                else{
                
                //                    DispatchQueue.main.async {
                //                        if response?.getapp.count ?? 0 > 0{
                ////                            self.appointments = response?.getapp ?? []
                //                            self.btnStack.isHidden = false
                //                            self.tblView.isHidden = false
                //                            self.lblAppointments.isHidden = false
                //                            self.emptyView.isHidden = true
                //                            self.tblView.reloadData()
                //                        }
                //                        else{
                //                            self.btnStack.isHidden = true
                //                            self.tblView.isHidden = true
                //                            self.lblAppointments.isHidden = true
                //                            self.emptyView.isHidden = false
                //                        }
                //                    }
                //                }
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: AppointVM.disposeBag)
    }
    fileprivate func refreshResponse(){
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                
            }else{
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
    
    //MARK: actionSubmit
    @IBAction func actionSubmit(_ sender: UIButton) {
        if tfLastname.text?.isEmpty == true{
            toast(Constants.Localicable.enterLastname)
        }
        else if tfFirstname.text?.isEmpty == true{
            toast(Constants.Localicable.enterFirstName)
        }
        else if tfEmail.text?.isEmpty == true {
            toast(Constants.Localicable.enterEmail)
        }
        else if !isValidEmail(tfEmail.text ?? "") == true {
            toast(Constants.Localicable.enterVaildEmail)
        }
        else if textView.text.isEmpty == true{
            toast(Constants.Localicable.enterMessage)
        }
        else{
            AppointVM.contactUs(AppContactUs(firstname: tfFirstname.text ?? "",lastname: tfLastname.text ?? "",email: tfEmail.text ?? "",message: textView.text ?? ""))
            //        self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    @IBAction func actionBack(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//MARK: extension ContactUsVC
extension ContactUsVC:UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Constants.Localicable.typeMessage
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = Constants.AppColors.blackText
        }
    }
}
