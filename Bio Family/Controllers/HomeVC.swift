//
//  HomeVC.swift
//  Bio Family
//
//  Created by John on 26/12/22.
//

import UIKit
import KYDrawerController
class HomeVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var clnView: UICollectionView!
    @IBOutlet weak var topNavView: UIViewX!
    //MARK: variable
    var homeData:[HomeModel] = []
    
    
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        clnView.delegate = self
        clnView.dataSource = self
        homeData = [HomeModel(title: "Appointments", image: Constants.AppAssets.selectedAppointment, color: Constants.AppColors.blueBox, backGround: Constants.AppAssets.blueBackground),
                    HomeModel(title: " Watch\nEducational Videos \n", image: Constants.AppAssets.youTube, color: Constants.AppColors.orangeBox, backGround: Constants.AppAssets.pinkBackground),
                    //                    HomeModel(title: "Educational Videos", image: Constants.AppAssets.youTube, color: Constants.AppColors.orangeBox, backGround: Constants.AppAssets.pinkBackground),
                    HomeModel(title: "Read\nHealth tips \n Magazine", image: Constants.AppAssets.magzine, color: Constants.AppColors.greenBox, backGround: Constants.AppAssets.greenBackground),
            ]
        clnView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeScreen(_:)), name: NSNotification.Name(rawValue: "screenChange"), object: nil)
        
        // handle notification
        // For swift 4.0 and above put @objc attribute in front of function Definition
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDefaults.goneForReview = false
        AppDefaults.selectedDrawer = 0
//        uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
    }
    
    //MARK: actionChange screen
    @IBAction   func changeScreen(_ notification: NSNotification) {
        if let index = notification.userInfo?["index"] as? Int {
            if AppDefaults.selectedTab == 1{
                if index == 1{
                    let vc  = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    // let _: MyProfileVC = self.open()
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
    //MARK: action Open Drawer
    @IBAction func actionOpenDrawer(_ sender: Any) {
        if let kyDrawer = self.parent?.parent?.parent as? KYDrawerController{
            if UIDevice.current.userInterfaceIdiom == .pad{
                kyDrawer.drawerWidth = 600
            }
            
            kyDrawer.setDrawerState(.opened, animated: true)
        }
    }
    
    @IBAction func actionNotification(_ sender: UITapGestureRecognizer) {
        let _:NotificationVC = self.open()
    }
}

//MARK: extension Collection view datasource ,delegate
extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    @IBAction func navigateToVideosVC(_ sender: UIButton){
        let _:VideoVC = self.open()
    }
    @IBAction func navigateToHealthTips(_ sender: UIButton){
        let _:Mazine = self.open()
    }
    @IBAction func navigateToUpcomingEvents(_ sender: UIButton){
        let _:NotificationVC = self.open()
    }
    @IBAction func navigateToFreewifi(_ sender: UIButton){
        let _:FreeWifiVC = self.open()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeData.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clnView.dequeueReusableCell(withReuseIdentifier: "HomeCVC", for: indexPath) as! HomeCVC
        let cell2 = clnView.dequeueReusableCell(withReuseIdentifier: "HomeCVC2", for: indexPath) as! HomeCVC2
        let cell3 = clnView.dequeueReusableCell(withReuseIdentifier: "HomeCVC3", for: indexPath) as! HomeCVC3
        let cell4 = clnView.dequeueReusableCell(withReuseIdentifier: "HomeCVC4", for: indexPath) as! HomeCVC4
        
//        cell.colorView.backgroundColor = homeData[indexPath.item].color
//        cell.title.text = homeData[indexPath.item].title
//        cell.img.image = homeData[indexPath.item].image
//        cell.backGround.image = homeData[indexPath.item].backGround\
        cell2.tvShow.addTarget(self, action: #selector(navigateToVideosVC(_:)), for: .touchUpInside)
        cell2.actionEvents.addTarget(self, action: #selector(navigateToUpcomingEvents(_:)), for: .touchUpInside)
        cell2.healthtTips.addTarget(self, action: #selector(navigateToHealthTips(_:)), for: .touchUpInside)
        cell2.actionFreeWifi.addTarget(self, action: #selector(navigateToFreewifi(_:)), for: .touchUpInside)
    
        if indexPath.row == 3{
            cell.configure()
          
        }
        if indexPath.row == 1{
            return cell2
        }
        if indexPath.row == 2{
            return cell3
        }
        if indexPath.row == 3{
            return cell4
        }
        else
        {
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = clnView.frame.width
        if indexPath.row == 1{
            return CGSize(width: width, height: UIScreen.screenHeight * 0.34)
        }
        if indexPath.row == 2{
            return CGSize(width: width, height: UIScreen.screenHeight * 0.17)
        }
        else{
            return CGSize(width: width, height: UIScreen.screenHeight * 0.17)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if let tabbar = self.parent?.parent as? TabbarVC{
                
                tabbar.onselection(0)
            }
        }
        else if indexPath.row == 1{
          
        }
        else if indexPath.row == 2{
            let _:SubmitReviewVC = self.open{
                $0.image = "ReviewStar 1"
                $0.buttonText = Constants.Localicable.submitReview
                $0.isFromWifi = false
            }
            
        }
        else if indexPath.row == 3{
            let _: PrescriptionVC = self.open()
        }
        else{
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



struct HomeModel{
    var title:String
    var image:UIImage
    var color:UIColor
    var backGround:UIImage
}



