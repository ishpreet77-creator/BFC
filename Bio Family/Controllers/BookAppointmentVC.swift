//
//  BookAppointmentVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
enum RequestType:String{
    case newRequest
    case isCAncel
    case reschedule
    case confirm
}
import UIKit
import VisualEffectView
import DropDown
class BookAppointmentVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var popUp: UIViewX!
    @IBOutlet weak var popupMainView: VisualEffectView!
    @IBOutlet weak var topNavView: UIViewX!
    
    @IBOutlet weak var lblReason: UILabel!
    
    
    //    @IBOutlet weak var tfInsurrance: UITextField!
    //    @IBOutlet weak var setInsurance: UIButton!
    
    //MARK: variable
//    var isCancel
//    var isReschedule = false
    
    var appointmentId : String = ""
    var requestType:RequestType = .newRequest
    
    //MARK: constant
    private let uploadVM = AppVM.init(repository: AppRepoImp.init(rxApi: RxApi()))
    private let UploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //    let insurrance = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        refreshResponse()
        //        insurrance.anchorView = setInsurance
        //        insurrance.dataSource = Constants.AppStatic.insurance
        //        insurrance.selectionAction = {[unowned self] (index: Int,item: String) in
        //            self.tfInsurrance.text = item
        //            insurrance.hide()
        //
        //        }
    }
    override func viewWillAppear(_ animated: Bool) {
//        UploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
    }
    //MARK: consfigUI
    fileprivate func configureUI() {
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        obserSignINResponse()
        popupMainView.colorTint = Constants.AppColors.applightBlue
        popupMainView.colorTintAlpha = 0.2
        popupMainView.blurRadius = 4
        popupMainView.scale = 1
        textView.layer.cornerRadius = 10
        switch requestType {
        case .newRequest:
            navTitle.text = Constants.Localicable.scheduleAppoint
            btnBook.setTitle(Constants.Localicable.Send, for: .normal)
            lblReason.text = Constants.Localicable.reasonAppoint
        case .isCAncel:
            navTitle.text = Constants.Localicable.cancelAppoint
            btnBook.setTitle(Constants.Localicable.Send, for: .normal)
            lblReason.text = Constants.Localicable.reasonCancel
        case .reschedule:
            navTitle.text = Constants.Localicable.rescheduleAppoint
            btnBook.setTitle(Constants.Localicable.Reschedule, for: .normal)
            lblReason.text = Constants.Localicable.reasonReschedule
        case .confirm:
            navTitle.text = Constants.Localicable.confirmAppoint
            btnBook.setTitle(Constants.Localicable.Confirm, for: .normal)
            lblReason.text = Constants.Localicable.reasonConfirm
        }
        
//        if isReschedule{
//            navTitle.text = "Reschedule Appointment"
//            btnBook.setTitle("Reschedule", for: .normal)
//        }
//        else{
//            navTitle.text = "Schedule Appointment"
//            btnBook.setTitle("Send", for: .normal)
//        }
    }
    //MARK: obserSignINResponse
    fileprivate func obserSignINResponse(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                if self.uploadVM.type == .appointment{
                    UIView.transition(with: self.popupMainView, duration: 0.4,
                                      options: .transitionCrossDissolve,
                                      animations: {
                        self.popupMainView.isHidden = false
                    })
                    
                    UIView.transition(with: self.popUp, duration: 0.4,
                                      options: .transitionCrossDissolve,
                                      animations: {
                        self.popUp.isHidden = false
                    })}
                else{
                    let _: NewAppointmentVC = self.open()
                }
                print(response ?? "")
                
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
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
    
    
    //
    //    @IBAction func actionSetinsurence(_ sender: Any) {
    //        insurrance.show()
    //    }
    
    //MARK: actionBack
    @IBAction func actionBack(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: actionBook
    @IBAction func actionBook(_ sender: UIButton) {
        
        switch requestType {
        case .newRequest:
            if (textView.text .isEmpty) == true{
                toast(Constants.Localicable.reasonTextViewEmpty)
            }else{
                uploadVM.appointment(AppRequest(reasonOfAppointment: textView.text))
            }
        case .isCAncel:
        
            if (textView.text .isEmpty) == true{
                toast(Constants.Localicable.reasonTextViewEmpty)
            }else{
                uploadVM.reScheduleAppoint(AppRequest(reasonOfAppointment: textView.text ?? "",type: "cancel"))
            }
        case .reschedule:
            if (textView.text .isEmpty) == true{
                toast(Constants.Localicable.reasonTextViewEmpty)
            }else{
                uploadVM.reScheduleAppoint(AppRequest(reasonOfAppointment: textView.text ?? "",type: "reschedule"))
            }
        case .confirm:
            if (textView.text .isEmpty) == true{
                toast(Constants.Localicable.reasonTextViewEmpty)
            }else{
                uploadVM.reScheduleAppoint(AppRequest(reasonOfAppointment: textView.text ?? "",type: "confirm"))
            }
        }
        
        
        
        
        
        
        
        
//        if isReschedule{
//            //            if (tfInsurrance.text?.isEmpty) == true{
//            //                toast("Please enter insurance name")
//            //            }
//            if (textView.text .isEmpty) == true{
//                toast("please enter reason for appointment")
//            }else{
//                uploadVM.reScheduleAppoint(AppRequest(reasonOfAppointment: textView.text ?? "", id: appointmentId))
//            }
//        }
//        else{
//            //            if (tfInsurrance.text?.isEmpty) == true{
//            //                toast("Please enter insurance name")
//            //            }
//            if (textView.text .isEmpty) == true{
//                toast("please enter reason for appointment")
//            }else{
//                uploadVM.appointment(AppRequest(reasonOfAppointment: textView.text))
//            }
//        }
        
    }
    //MARK: actionAppointmentPopup
    @IBAction func actionAppointmentPopup(_ sender: UIButton) {
        let _: NewAppointmentVC = self.open()
    }
    
    
}

