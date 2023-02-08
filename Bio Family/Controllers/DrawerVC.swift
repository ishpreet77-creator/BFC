//
//  DrawerVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit
import KYDrawerController

class DrawerVC: BaseViewController {
    
    
    @IBOutlet weak var tblDrawer: UITableView!
    
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var userMail: UILabel!
    
    
    //MARK: variable
    var unselectedDrawerItems:[DrawerModel] = []
    var selectedDrawerItems:[DrawerModel] = []
    //MARK: constant
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        observeLogoutResp()
        userName.text = "Hi, \(AppDefaults.userData.firstName) \(AppDefaults.userData.lastName)"
         userMail.text = "\(AppDefaults.userData.email)"
        tblDrawer.delegate = self
        tblDrawer.dataSource = self
        // Do any additional setup after loading the view.
        
        unselectedDrawerItems = [DrawerModel(title: Constants.AppStatic.home, image: Constants.AppAssets.home),
                                 DrawerModel(title: Constants.AppStatic.profile, image: Constants.AppAssets.profile),
                                 DrawerModel(title: Constants.AppStatic.appointment, image: Constants.AppAssets.selectedAppointment),
                                 DrawerModel(title: Constants.AppStatic.video, image: Constants.AppAssets.selectedVideo),
                                 DrawerModel(title: Constants.AppStatic.magzine, image: Constants.AppAssets.magzineDrawer),
                                 DrawerModel(title: Constants.AppStatic.history, image: Constants.AppAssets.historyDrawer),
                                 DrawerModel(title: Constants.AppStatic.setting, image: Constants.AppAssets.setting)
                                 
        ]
        selectedDrawerItems = [DrawerModel(title: Constants.AppStatic.home, image: Constants.AppAssets.homeWhite),
                               DrawerModel(title: Constants.AppStatic.profile, image: Constants.AppAssets.profileWhite),
                               DrawerModel(title: Constants.AppStatic.appointment, image: Constants.AppAssets.appointmentWhite),
                               DrawerModel(title: Constants.AppStatic.video, image: Constants.AppAssets.videoWhite),
                               DrawerModel(title: Constants.AppStatic.magzine, image: Constants.AppAssets.magzineWhite),
                               DrawerModel(title: Constants.AppStatic.history, image: Constants.AppAssets.whiteHistoryDrawer),
                               DrawerModel(title: Constants.AppStatic.setting, image: Constants.AppAssets.settingWhite)
                               
                               
        ]
    }
    override func viewWillAppear(_ animated: Bool) {
        userName.text = "Hi, \(AppDefaults.userData.firstName) \(AppDefaults.userData.lastName)"
        userMail.text = "\(AppDefaults.userData.email)"
        tblDrawer.reloadData()
    }
    //MARK: action
    
    @IBAction func closeDrawer(_ sender: UITapGestureRecognizer) {
        if let kyDrawer = self.parent as? KYDrawerController{
            kyDrawer.setDrawerState(.closed, animated: true)
        }
    }
    
    @IBAction func actionLogout(_ sender: UITapGestureRecognizer) {
        uploadVM.logout(LogoutReqst(userID: AppDefaults.userData.userId, device_id: UIDevice.current.identifierForVendor!.uuidString))
        
    }
    
    //MARK: observerFunction
    fileprivate func observeLogoutResp(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                DispatchQueue.main.async {
                    AppDefaults.selectedDrawer = -1
                    AppDefaults.selectedTab = 1
                    AppDefaults.userData = LoginReponse()
                    let _: LoginVC = self.open()
                }
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
}

//MARK: extension tableview delegate and datasource
extension DrawerVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unselectedDrawerItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDrawer.dequeueReusableCell(withIdentifier: "DrawerTVC", for: indexPath) as! DrawerTVC
        if AppDefaults.selectedDrawer == indexPath.row{
            cell.img.image = selectedDrawerItems[indexPath.row].image
            cell.lblTitle.text = selectedDrawerItems[indexPath.row].title
            cell.mainView.backgroundColor = Constants.AppColors.appBlue
            cell.lblTitle.textColor = Constants.AppColors.appWhite
        }
        else{
            cell.img.image = unselectedDrawerItems[indexPath.row].image
            cell.lblTitle.text = unselectedDrawerItems[indexPath.row].title
            cell.mainView.backgroundColor = Constants.AppColors.applightBlue
            cell.lblTitle.textColor = Constants.AppColors.blackText
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppDefaults.selectedDrawer = indexPath.row
        if indexPath.row == 0{
            AppDefaults.selectedTab = 1
        }
        else if indexPath.row == 1{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0){
                let index:[String: Int] = ["index":1]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "screenChange"), object: nil, userInfo: index)
            }
        }
        else if indexPath.row == 2{
            AppDefaults.selectedTab = 0
        }
        else if indexPath.row == 3{
            AppDefaults.selectedTab = 2
        }
        else if indexPath.row == 4{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0){
//                let index:[String: Int] = ["index":4]
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "screenChange"), object: nil, userInfo: index)
//            }
            let _: Mazine = self.open()
        }
        else if indexPath.row == 5{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0){
                let index:[String: Int] = ["index":5]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "screenChange"), object: nil, userInfo: index)
            }
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0){
                let index:[String: Int] = ["index":6]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "screenChange"), object: nil, userInfo: index)
                
            }
            //            let _: SettingVC = self.open()
            
        }
        
        if let kyDrawer = self.parent as? KYDrawerController{
            kyDrawer.setDrawerState(.closed, animated: true)
        }
        
    }
    
}


struct DrawerModel{
    var title:String
    var image:UIImage
}
