//
//  NotificationVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit
import SDWebImage

class NotificationVC: BaseViewController {
    //MARK: outlets
    
    @IBOutlet weak var topNavView: UIViewX!
    @IBOutlet weak var tblNotification: UITableView!
    
    
    var isFromnotification = false
    
    var NotifcationTitle  = ""
    var image = ""
    
    var notificationData: [NotificationModel] = []
    
    private let AppointVM = AppVM.init(repository: AppRepoImp.init(rxApi: RxApi()))
    
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        tblNotification.delegate = self
        tblNotification.dataSource = self
        observerNotification()
        refreshResponse()
    }
    override func viewWillAppear(_ animated: Bool) {
//        uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
        AppointVM.notification()
    }
    //MARK: observer Appointment
    fileprivate func observerNotification(){
        let _ =  AppointVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        AppointVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
               
                print(response)
//                self.appointments = self.appointments.unique{$0.createdoOn}
                self.notificationData = response?.getNotify ?? []
                self.notificationData =  self.notificationData.sorted { $0.notifiedon > $1.notifiedon }
//                self.notificationData =
                self.tblNotification.reloadData()
                //                if  self.AppointVM.type == .cancelAppoint{
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
                //
                //                    DispatchQueue.main.async {
                //                        if response?.getapp.count ?? 0 > 0{
                //                            self.appointments = response?.getapp ?? []
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
    
    //MARK: actionBack
    @IBAction func actionBack(_ sender: UITapGestureRecognizer) {
//        if isFromnotification{
//
//        }else{
            self.navigationController?.popViewController(animated: true)
//        }
        
    }
    
}
//MARK: extension NotificationVC

extension NotificationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblNotification.dequeueReusableCell(withIdentifier: "NotificationTVC", for: indexPath) as! NotificationTVC
        cell.lblNotification.text = notificationData[indexPath.row].title
        cell.notifyImage.sd_setImage(with: URL(string: notificationData[indexPath.row].image))
        cell.lbldate.text = notificationData[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _: NotificationVC2 = self.open{
//            $0.imageview.sd_setImage(with: URL(string: notificationData[indexPath.row].image))
            $0.imageview = notificationData[indexPath.row].image
            $0.notifyTitle = notificationData[indexPath.row].title
            $0.notifyBody = notificationData[indexPath.row].message
            $0.isfromnotification = true
        }
    }
}
