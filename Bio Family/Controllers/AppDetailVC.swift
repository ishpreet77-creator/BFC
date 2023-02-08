//
//  AppDetailVC.swift
//  Bio Family
//
//  Created by John on 04/01/23.
//

import UIKit
import VisualEffectView

class AppDetailVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var popupMainView: VisualEffectView!
    @IBOutlet weak var popUp: UIViewX!
    @IBOutlet weak var topNavView: UIViewX!
    @IBOutlet weak var Lblinsurance: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var rescheduleOutlet: UIButtonX!
    @IBOutlet weak var cancelOutlet: UIButtonX!
    
    //MARK: variable
    
    var insuranceName : String = ""
    var textview : String = ""
    var appointments:[GetAppointment] = []
    var cancelId :String = ""
    var isFromHistory = false
    //MARK: constant
    
    private let AppointVM = AppVM.init(repository: AppRepoImp.init(rxApi: RxApi()))
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Lblinsurance.text = insuranceName
        self.textView.text = textview
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        popupMainView.colorTint = Constants.AppColors.applightBlue
        popupMainView.colorTintAlpha = 0.2
        popupMainView.blurRadius = 4
        popupMainView.scale = 1
        // Do any additional setup after loading the view.
        obserAppointResponse()
        refreshResponse()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
        if isFromHistory{
            rescheduleOutlet.isHidden = true
            cancelOutlet.isHidden = true
        }
        else{
            rescheduleOutlet.isHidden = false
            cancelOutlet.isHidden = false
        }
    }
    //MARK: observer Appointment
    fileprivate func obserAppointResponse(){
        let _ =  AppointVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        AppointVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                if  self.AppointVM.type == .cancelAppoint{
                    UIView.transition(with:self.popupMainView, duration: 0.4,
                                      options: .transitionCrossDissolve,
                                      animations: {
                        self.popupMainView.isHidden = true
                    })
                    
                    UIView.transition(with: self.popUp, duration: 0.4,
                                      options: .transitionCrossDissolve,
                                      animations: {
                        self.popUp.isHidden = true
                    })
                    self.navigationController?.popViewController(animated: true)
                    
                }
                
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
    
    
    //MARK: back
    
    @IBAction func back(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func help(_ sender: UITapGestureRecognizer) {
        let _:ContactUsVC = self .open()
    }
    
    @IBAction func actionReschedule(_ sender: Any) {
//        let _:BookAppointmentVC = self.open{
//            $0.isReschedule = true
//            $0.appointmentId = cancelId
//        }
    }
    //MARK: actionCancel
    @IBAction func actionCancel(_ sender: Any) {
        
        UIView.transition(with: popupMainView, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.popupMainView.isHidden = false
        })
        
        UIView.transition(with: popUp, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.popUp.isHidden = false
        })
        
    }
    
    //MARK: yesPop
    @IBAction func yesPop(_ sender: Any) {
        AppointVM.cancelAppoint(AppRequest(id: cancelId))
    }
    
    @IBAction func noPop(_ sender: Any) {
        UIView.transition(with: popupMainView, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.popupMainView.isHidden = true
        })
        
        UIView.transition(with: popUp, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            self.popUp.isHidden = true
        })
    }
}
