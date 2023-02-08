//
//  NewAppointmentVC.swift
//  Bio Family
//
//  Created by John on 09/01/23.
//

import UIKit
import KYDrawerController

class NewAppointmentVC: BaseViewController {

    @IBOutlet weak var AppTableView: UITableView!
    @IBOutlet weak var topNavView: UIViewX!
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeScreen(_:)), name: NSNotification.Name(rawValue: "screenChange"), object: nil)
        AppTableView.dataSource = self
        AppTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        AppDefaults.goneForReview = false
//        uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
    }
    @IBAction  func changeScreen(_ notification: NSNotification) {
          if let index = notification.userInfo?["index"] as? Int {
              if AppDefaults.selectedTab == 0{
                  if index == 1{
                      let _: MyProfileVC = self.open()
                  }
                  else if index == 4{
                      let _: HealthTipsVC = self.open()
                  }
                  else if index == 5{
                      let _: HistoryVC = self.open()
                  }
                  else{
                      let _: SettingVC = self.open()
                  }
              }
          }
      }
    @IBAction func actionBack(_ sender: Any) {
        if let kyDrawer = self.parent?.parent?.parent as? KYDrawerController{
            if UIDevice.current.userInterfaceIdiom == .pad{
                kyDrawer.drawerWidth = 600
            }
            kyDrawer.setDrawerState(.opened, animated: true)
        }
    }
    
}
extension NewAppointmentVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AppTableView.dequeueReusableCell(withIdentifier: "Newcell", for: indexPath) as! NewAppointsmentsTVC
        if indexPath.row == 0{
            cell.img.image = UIImage(named: "BlueRectangle")
            cell.newAppointmentLabel.text = "Request New Appointment"
        }
        if indexPath.row == 1{
            cell.img.image = UIImage(named: "RectangleRed")
            cell.newAppointmentLabel.text = "Cancel Existing Appointment"
        }
        if indexPath.row == 2 {
//            cell.img.image = UIImage(named: "RectangleGreen")
            cell.newAppointmentLabel.text = "Reschedule Appointment"
            cell.img.isHidden = true
            
            cell.mainView.backgroundColor = UIColor(named: "SolidGreen2")
            cell.mainView.cornerRadius = 12
        }
        if indexPath.row == 3 {
            cell.newAppointmentLabel.text = "Confirm Appointment"
            cell.img.isHidden = true
            
            cell.mainView.backgroundColor = UIColor(named: "yellowColor")
            cell.mainView.cornerRadius = 12
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let _: BookAppointmentVC = self.open{
                $0.requestType = .newRequest
            }
            
        }
        if indexPath.row == 1{
            let _: BookAppointmentVC = self.open{
                $0.requestType = .isCAncel
            }

        }
        if indexPath.row == 2 {
            let _: BookAppointmentVC = self.open{
                $0.requestType = .reschedule
            }
        }
        if indexPath.row == 3 {
            let _: BookAppointmentVC = self.open{
                $0.requestType = .confirm
            }
        }
    }
    
}
