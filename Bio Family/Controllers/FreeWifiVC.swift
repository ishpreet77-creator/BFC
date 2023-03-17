//
//  FreeWifiVC.swift
//  Bio Family
//
//  Created by John on 09/01/23.
//

import UIKit

class FreeWifiVC: BaseViewController {
    @IBOutlet weak var topNavView: UIViewX!
    
    @IBOutlet weak var TfWifiName: UITextField!
    
    @IBOutlet weak var TfPassword: UITextField!
    
    @IBOutlet weak var eyeImage: UIImageView!
    
    @IBOutlet weak var checkImage: UIImageViewX!
    
   
    @IBOutlet weak var btn_box: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        TfWifiName.text = "STS_Testing_5G"
//        TfPassword.text = "Testing1077@"
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionEye(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            if sender.tag == 0{
                eyeImage.image =  Constants.AppAssets.eyeClosed
                TfPassword.isSecureTextEntry = false
            }
            else{
                eyeImage.image =  Constants.AppAssets.eyeClosed
                
            }
        }
        else{
            if sender.tag == 0{
                eyeImage.image = Constants.AppAssets.eye
                TfPassword.isSecureTextEntry = true
            }
            else{
                eyeImage.image =  Constants.AppAssets.eye
                
            }
            
        }
    }
    
    
    
    @IBAction func actionCheck(_ sender: UIButton) {
        if (btn_box.isSelected == true)
           {
            checkImage.image = UIImage(named: "")

            btn_box.isSelected = false
           }
           else
           {
               checkImage.image = UIImage(named: "tick")

               btn_box.isSelected = true
            
           }
        
        
    }
    
    
    
    @IBAction func actionTermsaAndCon(_ sender: Any) {
        if let link = URL(string: "https://bfcapp.com/terms_conditions.html") {
            
       
          UIApplication.shared.open(link)
        }
    }
    
    
    @IBAction func actionNext(_ sender: Any) { 
        if TfWifiName.text?.isEmpty == true{
            toast(Constants.Localicable.enterWifiName)
        }
        else if TfPassword.text?.isEmpty == true{
            toast(Constants.Localicable.enterPassword)
            
        }
        else if btn_box.isSelected == false {
            toast(Constants.Localicable.checkTermsAndCondition)
        }
            else{
            let _: SubmitReviewVC = self.open{
                $0.image = "FreeWifi"
                $0.buttonText = Constants.Localicable.joinFreeWifi
                $0.isFromWifi = true
                $0.WifiName = TfWifiName.text ?? ""
                
                $0.Password = TfPassword.text ?? ""
            }
        }
        
        
    }
    
    
}
