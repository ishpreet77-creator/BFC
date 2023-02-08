//
//  HistoryVC.swift
//  Bio Family
//
//  Created by John on 05/01/23.
//

import UIKit

class HistoryVC: BaseViewController {
    
    //MARK: outlets
    
    @IBOutlet weak var historyTableview: UITableView!
    @IBOutlet weak var topNavView: UIViewX!
    //MARK: constant
    
    private let AppointVM = AppVM.init(repository: AppRepoImp.init(rxApi: RxApi()))
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: variable
    
    var appointments:[GetAppointment] = []
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        historyTableview.dataSource = self
        historyTableview.delegate = self
        historyTableview.allowsSelection = true
        // Do any additional setup after loading the view.
        obserAppointResponse()
        refreshResponse()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.appointments = []
//        uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
        AppointVM.historyAppointment()
    }
    
    //MARK: observer Appointment
    fileprivate func obserAppointResponse(){
        let _ =  AppointVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        AppointVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                self.appointments = []
                self.appointments = response?.getapp ?? []
                
                self.appointments = self.appointments.unique{$0.createdoOn}
                self.appointments =  self.appointments.sorted { $0.createdoOn > $1.createdoOn }
//                self.appointments = response?.getapp ?? []
                self.historyTableview.reloadData()
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
    //MARK: actionback
    
    @IBAction func actionback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//MARK: extension
extension HistoryVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableview.dequeueReusableCell(withIdentifier: "HistoryTVC", for: indexPath) as! HistoryTVC
//        cell.Lblinsurance.text = appointments[indexPath.row].insuranceName
        cell.Lblinsurance.isHidden = true
        cell.LblDate.text = "Date:- \(appointments[indexPath.row].date)"
        cell.dateTopConstant.constant = -16
        cell.LblReason.text = appointments[indexPath.row].reasonOfAppointment
        
        if appointments[indexPath.row].status == 0{
            cell.lblReaseon.text = "New"
            cell.historyImageView.image = UIImage(named: "BlueRectangle")
            cell.historyImageView.isHidden = false
        }
       else if appointments[indexPath.row].status == 1{
            cell.lblReaseon.text = "Reschedule"
//            cell.historyImageView.image = UIImage(named:  "RectangleGreen")
            cell.historyImageView.isHidden = true
            cell.LabelView.backgroundColor = UIColor(named: "SolidGreen2")
           
        }
       else if appointments[indexPath.row].status == 2{
            cell.lblReaseon.text = "Cancel"
            cell.historyImageView.image = UIImage(named:  "RectangleRed")
           cell.historyImageView.isHidden = false
          
        }
      else if appointments[indexPath.row].status == 3{
            cell.lblReaseon.text = "Confirm"
            cell.LabelView.backgroundColor = UIColor(named: "yellowColor")
            cell.historyImageView.isHidden = true
//            cell.historyImageView.image = UIImage(named:  "RectangleRed")
        }
        else if appointments[indexPath.row].status == 4{
              cell.lblReaseon.text = "Refill prescriptions"
              cell.LabelView.backgroundColor = UIColor(named: "Colorpurple")
              cell.historyImageView.isHidden = true
  //            cell.historyImageView.image = UIImage(named:  "RectangleRed")
          }
        else{
            cell.lblReaseon.text = "Invaild status"
            cell.LabelView.backgroundColor = UIColor.brown
            cell.historyImageView.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _: AppDetailVC = self.open{
            $0.insuranceName = appointments[indexPath.row].insuranceName
            $0.textview = appointments[indexPath.row].reasonOfAppointment
            $0.isFromHistory = true
            
        }
        
    }
    
}


extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
