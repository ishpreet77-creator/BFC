////
////  AppointmentVC.swift
////  Bio Family
////
////  Created by John on 26/12/22.
////
//
//import UIKit
//import KYDrawerController
//import VisualEffectView
//
//class AppointmentVC: BaseViewController {
//    //MARK: outlets
//    @IBOutlet weak var topNavView: UIViewX!
//    @IBOutlet weak var tblView: UITableView!
//    @IBOutlet weak var lblAppointments: UILabel!
//    @IBOutlet weak var emptyView: UIView!
//    @IBOutlet weak var btnStack: UIStackView!
//    @IBOutlet weak var popUp: UIViewX!
//    @IBOutlet weak var popupMainView: VisualEffectView!
//    //MARK: variales
//    var appointments:[GetAppointment] = []
//    var selectedList = 0
//    var showAppointments = false
//    var cancelId :String = ""
//    //MARK: CONSTANTS
//    private let AppointVM = AppVM.init(repository: AppRepoImp.init(rxApi: RxApi()))
//    //MARK: lifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
//
//        tblView.delegate = self
//        tblView.dataSource = self
//        NotificationCenter.default.addObserver(self, selector: #selector(self.changeScreen(_:)), name: NSNotification.Name(rawValue: "screenChange"), object: nil)
//
//        btnStack.isHidden = true
//        tblView.isHidden = true
//        lblAppointments.isHidden = true
//        popupMainView.colorTint = Constants.AppColors.applightBlue
//        popupMainView.colorTintAlpha = 0.2
//        popupMainView.blurRadius = 4
//        popupMainView.scale = 1
//        obserAppointResponse()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.tblView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 108, right: 0)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        AppDefaults.selectedDrawer = 2
//
//        //        if showAppointments{
//        //            btnStack.isHidden = false
//        //            tblView.isHidden = false
//        //            lblAppointments.isHidden = false
//        //            emptyView.isHidden = true
//        //        }
//        //        else{
//        //            btnStack.isHidden = true
//        //            tblView.isHidden = true
//        //            lblAppointments.isHidden = true
//        //            emptyView.isHidden = false
//        //        }
//        AppointVM.getAppointment()
//
//    }
//    //MARK: action Changescreen
//    @IBAction  func changeScreen(_ notification: NSNotification) {
//        if let index = notification.userInfo?["index"] as? Int {
//            if AppDefaults.selectedTab == 0{
//                if index == 1{
//                    let _: MyProfileVC = self.open()
//                }
//                else if index == 4{
//                    let _: HealthTipsVC = self.open()
//                }
//                else if index == 5{
//                    let _: HistoryVC = self.open()
//                }
//                else{
//                    let _: SettingVC = self.open()
//                }
//            }
//        }
//    }
//
//    //MARK: observer Appointment
//    fileprivate func obserAppointResponse(){
//        let _ =  AppointVM.isLoading.subscribe { (isLoading) in
//            isLoading ? self.showProgress() : self.hideProgress()
//        }
//        AppointVM.response.subscribe(onNext: { (response) in
//            if response?.status == true{
//                if  self.AppointVM.type == .cancelAppoint{
//                    UIView.transition(with:self.popupMainView, duration: 0.4,
//                                      options: .transitionCrossDissolve,
//                                      animations: {
//                        self.popupMainView.isHidden = true
//                    })
//
//                    UIView.transition(with: self.popUp, duration: 0.4,
//                                      options: .transitionCrossDissolve,
//                                      animations: {
//                        self.popUp.isHidden = true
//                    })
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
//            }else{
//                self.showAlert(response?.message ?? "")
//            }
//        }, onError: { (error) in
//        })
//        .disposed(by: AppointVM.disposeBag)
//    }
//    //MARK: action Book Appointment
//    @IBAction func actionBookAppointment(_ sender: UIButton) {
//        let _: BookAppointmentVC = self.open(){
//            $0.isReschedule = false
//        }
//    }
//    @IBAction func actionBookAppointmentEmpty(_ sender: UIButton) {
//        let _: BookAppointmentVC = self.open()
//        {
//            $0.isReschedule = false
//        }
//    }
//
//
//    //MARK: actionOpenDrawer
//    @IBAction func actionOpenDrawer(_ sender: Any) {
//        if let kyDrawer = self.parent?.parent?.parent as? KYDrawerController{
//            if UIDevice.current.userInterfaceIdiom == .pad{
//                kyDrawer.drawerWidth = 600
//            }
//            kyDrawer.setDrawerState(.opened, animated: true)
//        }
//    }
//    //MARK: action Notification
//    @IBAction func actionNotification(_ sender: UITapGestureRecognizer) {
//        let _:NotificationVC = self.open()
//    }
//    //MARK: reschedule appoint
//    @IBAction func rescheduleClicked(_ sender: UIButton) {
//        let _:BookAppointmentVC = self.open{
//            $0.isReschedule = true
//            $0.appointmentId = appointments[sender.tag].id
//        }
//    }
//    //MARK: action Cancel
//    @IBAction func cancelClicked(_ sender: UIButton) {
//        cancelId =  appointments[sender.tag].id
//        UIView.transition(with: popupMainView, duration: 0.4,
//                          options: .transitionCrossDissolve,
//                          animations: {
//            self.popupMainView.isHidden = false
//        })
//
//        UIView.transition(with: popUp, duration: 0.4,
//                          options: .transitionCrossDissolve,
//                          animations: {
//            self.popUp.isHidden = false
//        })
//    }
//    //MARK: pop up
//    @IBAction func yesPopup(_ sender: UIButton) {
//
//        AppointVM.cancelAppoint(AppRequest(id: cancelId))
//    }
//
//    @IBAction func noPopup(_ sender: UIButton) {
//        UIView.transition(with: popupMainView, duration: 0.4,
//                          options: .transitionCrossDissolve,
//                          animations: {
//            self.popupMainView.isHidden = true
//        })
//
//        UIView.transition(with: popUp, duration: 0.4,
//                          options: .transitionCrossDissolve,
//                          animations: {
//            self.popUp.isHidden = true
//        })
//    }
//
//}
//
////MARK: extension Tableview
//extension AppointmentVC:UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return appointments.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tblView.dequeueReusableCell(withIdentifier: "AppointmentTVC", for: indexPath) as! AppointmentTVC
//        cell.btnReschedule.tag = indexPath.row
//        cell.btnReschedule.isHidden = false
//        cell.btnCancel.isHidden = false
//        cell.btnCancel.tag = indexPath.row
//        cell.btnDetail.isHidden = true
//        cell.btnReschedule.addTarget(self, action: #selector(rescheduleClicked(_:)), for: .touchUpInside)
//        cell.btnCancel.addTarget(self, action: #selector(cancelClicked(_:)), for: .touchUpInside)
//
//        cell.lblInsurance.text = appointments[indexPath.row].insuranceName
//        cell.lblReason.text = appointments[indexPath.row].reasonOfAppointment
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let _:AppDetailVC = self.open{
//            $0.insuranceName = appointments[indexPath.row].insuranceName
//            $0.textview = appointments[indexPath.row].reasonOfAppointment
//            $0.cancelId = appointments[indexPath.row].id
//            $0.isFromHistory = false
//        }
//
//    }
//}
