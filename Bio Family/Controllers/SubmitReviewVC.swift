//
//  SubmitReviewVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit
import VisualEffectView
import Cosmos
class SubmitReviewVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var popUp: UIViewX!
    @IBOutlet weak var popupMainView: VisualEffectView!
    @IBOutlet weak var topNavView: UIViewX!
    @IBOutlet weak var review: CosmosView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var submitButtom: UIButton!
    
    @IBOutlet weak var reviewPopUp: UIViewX!
    
    var isFromWifi = false
   
    
    var FromReview = false
    var goneforReview = false
    var buttonText = ""
    var image = ""
    var WifiName = ""
    var Password = ""
    //MARK: constant
    private let AppointVM = AppVM.init(repository: AppRepoImp.init(rxApi: RxApi()))
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
      
       
//    Please write Review on Google/Yelp to connect Free Wifi. Once you click on the Ok then it will redirect to Google/Yelp. After submit the Review you can come back from Top left corner back button and then you can join Free Wifi.
   let url = URL(string: "https://www.google.com/search?q=bio+family+clinic&source=hp&ei=8-mlY9CCG4fhkPIPlfuxsAU&iflsig=AJiK0e8AAAAAY6X4A1X--A5btkhQGgMh7JUPnXsItXnl&gs_ssp=eJzj4tFP1zc0NM4qMMgqSTFgtFI1qLAwSDEzM06xTDQ3NDI3SjS3MqhIS0wytbA0NDA1SrUwMza28BJMysxXSEvMzcypVEjOyczLTAYAyI4UrA&oq=bio&gs_lcp=Cgdnd3Mtd2l6EAEYADILCC4QrwEQxwEQgAQyCAgAEIAEELEDMgUIABCABDIICAAQgAQQsQMyCAgAEIAEELEDMggIABCABBCxAzIFCAAQgAQyBQgAEIAEMgUIABCABDILCC4QgAQQsQMQgwE6EQguEIAEELEDEIMBEMcBENEDOggILhCxAxCDAToOCC4QgAQQsQMQxwEQ0QM6BAgAEAM6CwguEIAEELEDENQCOgsILhCABBDHARDRAzoRCC4QgwEQxwEQsQMQ0QMQgAQ6CwgAEIAEELEDEIMBOhEILhCABBCxAxCDARDHARCvAToFCC4QgAQ6CAguEIAEELEDUABY6ARghxZoAHAAeACAAUWIAcYBkgEBM5gBAKABAQ&sclient=gws-wiz#lrd=0x80d663d9a71272a7:0xfab5891052e86338,1,,")
    let yelpUrl = URL(string: "https://www.yelp.com/biz/bio-family-clinic-yuma")
//        UIApplication.shared.open(url)
    
//
     
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        topImage.image = UIImage(named: image)
        submitButtom.setTitle(buttonText, for: .normal)
        
        
        configureUI()
        refreshResponse()
//        review.didFinishTouchingCosmos = { review in
//            if review == 1.0 {
//                self.review.settings.filledImage = UIImage(named: "redStar")
//                self.review.settings.emptyImage = UIImage(named: "redStarEmpty")
//            }
//            if  review == 2.0 || review == 3.0 {
//                self.review.settings.filledImage = UIImage(named: "greenStar")
//                self.review.settings.emptyImage = UIImage(named: "greenEmpty")
//            }
//            if review == 4.0 ||  review == 5.0{
//                self.review.settings.filledImage = UIImage(named: "filledStar")
//                self.review.settings.emptyImage = UIImage(named: "unfilledStar")
//            }
//        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
    }
    override func viewDidDisappear(_ animated: Bool) {
        AppDefaults.goneForReview = false
        AppDefaults.FromReview = false
    }
   
    //MARK: configureUI
    fileprivate func configureUI() {
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        popupMainView.colorTint = Constants.AppColors.applightBlue
        popupMainView.colorTintAlpha = 0.2
        popupMainView.blurRadius = 4
        popupMainView.scale = 1
        textView.layer.cornerRadius = 10
        textView.text = "Write your feedback..."
        textView.textColor = UIColor.lightGray
        textView.delegate =  self
       
        
        obserAppointResponse()
    }
    //MARK: observer Appointment
    fileprivate func obserAppointResponse(){
        let _ =  AppointVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        AppointVM.response.subscribe(onNext: { (response) in
            
            if response?.status == true{
                if self.isFromWifi{
                    //                    self.showAlert("Please leave a review before connecting a wifi")
                    if  self.review.rating == 1 || self.review.rating == 2 ||  self.review.rating == 3{
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
                        HotspotHelper().connectToWifi(wifiName: self.WifiName, wifiPassword: self.Password, wep: false) { error in
                        }
                    }else{
                       
                        UIView.transition(with: self.popupMainView, duration: 0.4,
                                                             options: .transitionCrossDissolve,
                                                             animations: {
                                               self.popupMainView.isHidden = false
                                           })
                       
                                           UIView.transition(with: self.reviewPopUp, duration: 0.4,
                                                             options: .transitionCrossDissolve,
                                                             animations: {
                                               self.reviewPopUp.isHidden = false
                                           })
//                        let message  = "Please write Review on Google/Yelp to connect Free Wifi. Once you click on the Ok then it will redirect to Google/Yelp. After submit the Review you can come back from Top left corner back button and then you can join Free Wifi."
//
//                        let refreshAlert = UIAlertController(title: "Review", message: message , preferredStyle: UIAlertController.Style.alert)
//
//
//
//                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//                            DispatchQueue.main.async {
//                                AppDefaults.wifiName = self.WifiName
//                                AppDefaults.wifiPassword = self.Password
//                                AppDefaults.goneForReview = true
//                                self.goneforReview = true
//
//
//                                if (self.review.rating == 4 || self.review.rating == 5) && AppDefaults.userData.email.contains("gmail.com") {
//
//                                    UIApplication.shared.open(self.url!)
//                                }
//                                else if  self.review.rating == 4 || self.review.rating == 5 {
//                                    UIApplication.shared.open(self.yelpUrl!)
//                                }
//                            }
//
//                        }))
//
//                        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//                            print("Handle Cancel Logic here")
//                        }))
//
//                        self.present(refreshAlert, animated: true, completion: nil)
                        }
//                    HotspotHelper().connectToWifi(wifiName: self.WifiName, wifiPassword: self.Password, wep: false) { error in
//
//
//                        if  self.review.rating == 1 || self.review.rating == 2 ||  self.review.rating == 3{
//                            UIView.transition(with: self.popupMainView, duration: 0.4,
//                                              options: .transitionCrossDissolve,
//                                              animations: {
//                                self.popupMainView.isHidden = false
//                            })
//
//                            UIView.transition(with: self.popUp, duration: 0.4,
//                                              options: .transitionCrossDissolve,
//                                              animations: {
//                                self.popUp.isHidden = false
//                            })
//                        }
//
//                        if (self.review.rating == 4 || self.review.rating == 5) && AppDefaults.userData.email.contains("gmail.com") {
//
//                            UIApplication.shared.open(self.url!)
//                        }
//                        else if  self.review.rating == 4 || self.review.rating == 5 {
//                            UIApplication.shared.open(self.yelpUrl!)
//                        }
//                        print(error)
//
//                    }
                    
                }
                else if  self.AppointVM.type == .reviewBiofamily{
                    
                    if  self.review.rating == 1 || self.review.rating == 2 ||  self.review.rating == 3{
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
                    }
                    
                    if (self.review.rating == 4 || self.review.rating == 5)  && AppDefaults.userData.email.contains("gmail.com") {
                        UIApplication.shared.open(self.url!)
                        AppDefaults.FromReview = true
                    }
                    else if  self.review.rating == 4 || self.review.rating == 5 {
                        UIApplication.shared.open(self.yelpUrl!)
                        AppDefaults.FromReview = true
                    }
//                    UIView.transition(with: self.popupMainView, duration: 0.4,
//                                      options: .transitionCrossDissolve,
//                                      animations: {
//                        self.popupMainView.isHidden = false
//                    })
//                    
//                    UIView.transition(with: self.popUp, duration: 0.4,
//                                      options: .transitionCrossDissolve,
//                                      animations: {
//                        self.popUp.isHidden = false
//                    })
                    
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
    
    //MARK: action ok
    
    @IBAction func actionOk(_ sender: Any) {
        AppDefaults.wifiName = self.WifiName
        AppDefaults.wifiPassword = self.Password
        AppDefaults.goneForReview = true
        self.goneforReview = true
        
        
        if (self.review.rating == 4 || self.review.rating == 5) && AppDefaults.userData.email.contains("gmail.com") {
            
            UIApplication.shared.open(self.url!)
        }
        else if  self.review.rating == 4 || self.review.rating == 5 {
            UIApplication.shared.open(self.yelpUrl!)
        }
    
    }
    
    //MARK: actionCancel
    
    
    @IBAction func actionCancel(_ sender: Any) {
        
        UIView.transition(with: popupMainView, duration: 0.4,
                                 options: .transitionCrossDissolve,
                                 animations: {
                   self.popupMainView.isHidden = true
               })
       
               UIView.transition(with: reviewPopUp, duration: 0.4,
                                 options: .transitionCrossDissolve,
                                 animations: {
                   self.reviewPopUp.isHidden = true
               })
        
    }
    //MARK: actionSubmit
    @IBAction func actionSubmit(_ sender: UIButton) {
       
        if  self.review.rating == 1 || self.review.rating == 2 ||  self.review.rating == 3 ||  self.review.rating == 4 ||  self.review.rating == 5{
            if textView.text == "Write your feedback..." || textView.text == ""{
                toast("Please enter Review")
            }else{
                AppointVM.reviewBoifamily(AppReviewBioFamily(review: String(review.rating),message: textView.text ?? ""))
            }
        }else{
            AppointVM.reviewBoifamily(AppReviewBioFamily(review: String(review.rating),message: textView.text ?? ""))
        }
    }
    
    
    
    
    
    @IBAction func actionDone(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func actionBack(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//MARK: extension SubmitReviewVC
extension SubmitReviewVC:UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your feedback..."
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
