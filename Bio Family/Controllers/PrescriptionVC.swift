//
//  PrescriptionVC.swift
//  Bio Family
//
//  Created by John on 29/01/23.
//

import UIKit
import VisualEffectView

class PrescriptionVC: BaseViewController {
    @IBOutlet weak var topNavView: UIViewX!

    @IBOutlet weak var textViewPrescription: UITextView!
    
    @IBOutlet weak var popUp: UIViewX!
    @IBOutlet weak var popupMainView: VisualEffectView!
    
    private let uploadVM = AppVM.init(repository: AppRepoImp.init(rxApi: RxApi()))
    private let UploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshResponse()
        observerPrescripition()
        popupMainView.colorTint = Constants.AppColors.applightBlue
        popupMainView.colorTintAlpha = 0.2
        popupMainView.blurRadius = 4
        popupMainView.scale = 1
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        UploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
    }
    fileprivate func refreshResponse(){
        UploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                
            }else{
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
    
    fileprivate func observerPrescripition(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                
                    UIView.transition(with: self.popupMainView, duration: 0.4,
                                      options: .transitionCrossDissolve,
                                      animations: {
                        self.popupMainView.isHidden = false
                    })

                    UIView.transition(with: self.popUp, duration: 0.4,
                                      options: .transitionCrossDissolve,
                                      animations: {
                        self.popUp.isHidden = false
                    })
                

            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
    @IBAction func back(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func actionPrescription(_ sender: Any) {
        if textViewPrescription.text.isEmpty == true{
            toast("Plese enter Prescripition")
        }
        else{
            uploadVM.prescription(AppPrescripition(message: textViewPrescription.text ?? ""))
        }
    }
    
    @IBAction func actionPrescripitionPopup(_ sender: UIButton) {
        let _: HomeVC = self.open()
    }

}
