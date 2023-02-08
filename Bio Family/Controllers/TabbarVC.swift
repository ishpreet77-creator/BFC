//
//  TabbarVC.swift
//  Bio Family
//
//  Created by John on 26/12/22.
//

import UIKit

class TabbarVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var vwContainer: UIView!
    
    @IBOutlet var btnTabs: [UIButton]!
    @IBOutlet var tabImages: [UIImageView]!
    //MARK: variable
    var HomeVC: UINavigationController!
    var AppointmentVC: UINavigationController!
    var VideoVC: UINavigationController!
    //var selectedIndex: Int = AppDefaults.selectedTab
    var viewControllers: [UINavigationController]!
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers()
        btnTabsPressed(btnTabs[AppDefaults.selectedTab])
    }
    override func viewWillAppear(_ animated: Bool) {
        btnTabsPressed(btnTabs[AppDefaults.selectedTab])
    }
    
    //MARK: btntabpressed
    @IBAction func btnTabsPressed(_ sender: UIButton) {
        let previousIndex = AppDefaults.selectedTab
        AppDefaults.selectedTab = sender.tag
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        let vc = viewControllers[AppDefaults.selectedTab]
        vc.popToRootViewController(animated: true)
        addChild(vc)
        vc.view.frame = vwContainer.bounds
        vwContainer.addSubview(vc.view)
        vc.didMove(toParent: self)
        settabImage(selectedIndex: sender.tag)
    }
    
    //MARK: Functions
    func onselection(_ selectedIndex: Int) {
        btnTabsPressed(btnTabs[selectedIndex])
        
    }
    
    
    func settabImage(selectedIndex:Int){
        tabImages[0].image =  Constants.AppAssets.unSelectedAppointment
        tabImages[1].image =  Constants.AppAssets.unSelectedHome
        tabImages[2].image =  Constants.AppAssets.unSelectedVideo
        switch selectedIndex{
        case 0:
            tabImages[selectedIndex].image =  Constants.AppAssets.selectedAppointment
        case 1:
            tabImages[selectedIndex].image =  Constants.AppAssets.selectedHome
        case 2:
            tabImages[selectedIndex].image =  Constants.AppAssets.selectedVideo
            
        default:
            print("Invalid tab Clicked")
        }
        
    }
    func setViewControllers(){
        let storyboard = UIStoryboard(name: Constants.AppStatic.storyBoard, bundle: nil)
        AppointmentVC = storyboard.instantiateViewController(withIdentifier: Constants.AppStatic.appointmentNavigationController) as? UINavigationController
        HomeVC = storyboard.instantiateViewController(withIdentifier: Constants.AppStatic.homeNavigationController) as? UINavigationController
        VideoVC = storyboard.instantiateViewController(withIdentifier: Constants.AppStatic.videoNavigationController) as? UINavigationController
        
        viewControllers = [AppointmentVC,HomeVC,VideoVC]
        
    }
    
}
