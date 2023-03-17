//
//  SignupVC.swift
//  Bio Family
//
//  Created by John on 24/12/22.
//

import UIKit
import DropDown

class SignupVC: BaseViewController ,UITextFieldDelegate{
    //MARK: outlets
    @IBOutlet weak var eye2: UIImageView!
    @IBOutlet weak var eye1: UIImageView!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var tfMonth: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfYear: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfInsurrance: UITextField!
    @IBOutlet weak var setInsurance: UIButton!
    
    @IBOutlet weak var Disclamer: UIButtonX!
    
    @IBOutlet weak var checkImage: UIImageViewX!
    
    @IBOutlet weak var checkImage2: UIImageViewX!
    
    @IBOutlet weak var btn_box2: UIButton!
    @IBOutlet weak var btn_box: UIButton!
    
    
    
    
    //MARK: constant
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    let date = DropDown()
    let month = DropDown()
    let year = DropDown()
    let insurrance = DropDown()
//    let button = UIButton(type: .roundedRect)
        
    //MARK: variable
    var currentYear = Calendar.current.component(.year, from: Date())
    var authData:AuthRequest?
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_box.isHidden = true
        checkImage.isHidden = true
        Disclamer.isHidden = true
        tfPhone.delegate = self
//        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
//        button.setTitle("Test Crash", for: [])
//        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
//        view.addSubview(button)
        
        obserSignINResponse()
        date.anchorView = btnDate
        year.anchorView = btnYear
        month.anchorView = btnMonth
        insurrance.anchorView = setInsurance
        insurrance.dataSource = Constants.AppStatic.insurance
        date.dataSource =  Constants.AppStatic.dateArr
        year.dataSource =  Constants.AppStatic.arrayYear
        month.dataSource = Constants.AppStatic.arrayMonth
        insurrance.selectionAction = {[unowned self] (index: Int,item: String) in
            self.tfInsurrance.text = item
            insurrance.hide()
            
        }
        date.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfDate.text = item
            date.hide()
        }
        
        year.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfYear.text = item
            year.hide()
        }
        
        month.selectionAction = { [unowned self] (index: Int, item: String) in
            self.tfMonth.text = item
            month.hide()
        }
        
    }
//    @IBAction func crashButtonTapped(_ sender: AnyObject) {
//         let numbers = [0]
//         let _ = numbers[1]
//     }
    //MARK: observer Signup
    fileprivate func obserSignINResponse(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                if let data = self.authData{
                    let _: OtpVC = self.open{
                        $0.newAccount = true
                        $0.authData = data
                        $0.email = self.tfEmail.text ?? ""
                        $0.otp = response?.data ?? ""
                    }
                }
                
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
    
    //MARK: actions
    @IBAction func actionSetinsurence(_ sender: Any) {
        insurrance.show()
    }
    @IBAction func actionLogin(_ sender: UITapGestureRecognizer) {
        let _: LoginVC = self.open()
    }
    @IBAction func actionMonth(_ sender:UIButton) {
        month.show()
    }
    
    @IBAction func actionDate(_ sender: UIButton) {
        date.show()
    }
    
    @IBAction func actionYear(_ sender: UIButton) {
        year.show()
    }
    
//    @IBAction func actionCheck(_ sender: UIButton) {
//        if (btn_box.isSelected == true)
//           {
//            checkImage.image = UIImage(named: "")
//
//            btn_box.isSelected = false
//           }
//           else
//           {
//               checkImage.image = UIImage(named: "tick")
//
//               btn_box.isSelected = true
//
//           }
//
//    }
    
    
    @IBAction func actionCheck2(_ sender: Any) {
        
        if (btn_box2.isSelected == true)
           {
            checkImage2.image = UIImage(named: "")

            btn_box2.isSelected = false
           }
           else
           {
               checkImage2.image = UIImage(named: "tick")

               btn_box2.isSelected = true
            
           }
    }
    
    
//
//    @IBAction func actionDisclamer(_ sender: Any) {
//        if let link = URL(string: "https://bfcapp.com/disclaimer.html") {
////            if let link = URL(string: "https://bfcapp.com/biofamily_terms-condition.html") {
//          UIApplication.shared.open(link)
//        }
//    }
//
    @IBAction func actionPrivacyPolicy(_ sender: Any) {
        if let link = URL(string: "https://bfcapp.com/biofamily_policy.html") {
                UIApplication.shared.open(link)
              }
    }
    
    
    @IBAction func actionTermsAndCondition(_ sender: Any) {
        if let link = URL(string: "https://bfcapp.com/biofamily_terms-condition.html") {
                UIApplication.shared.open(link)
              }
    }
    
    
    //MARK: action Signup
    @IBAction func actionSignup(_ sender: Any) {
        if tfFirstName.text == ""{
            toast(Constants.Localicable.enterFirstName)
        }
        else if tfLastName.text == ""{
            toast(Constants.Localicable.enterLastname)
        }
        else if tfEmail.text == ""{
            toast(Constants.Localicable.enterEmail)
        }
        else if !isValidEmail(tfEmail.text ?? ""){
            toast(Constants.Localicable.enterVaildEmail)
        }
        else if tfMonth.text == "" || tfDate.text == "" || tfYear.text == ""{
            toast(Constants.Localicable.enterDOB)
        }
        else if tfPhone.text == ""{
            toast(Constants.Localicable.enterPhoneNO)
        }
        else if tfPassword.text == ""{
            toast(Constants.Localicable.enterPassword)
        }
        else if tfConfirmPassword.text == ""{
            toast(Constants.Localicable.enterConfirmPassword)
        }
        else if isPasswordValid(tfPassword.text ?? "") == false{
            showAlert(Constants.Localicable .eterVaildPassword)
        }
        else if tfPassword.text != tfConfirmPassword.text{
            toast(Constants.Localicable.passwordNotMatch)
        }
        else if tfInsurrance.text == ""{
            toast(Constants.Localicable.enterInsurranceName)
        }
//        else if btn_box.isSelected == false {
//            toast("Please Read the Disclamer and check the box to SignUp")
//        }
        else if btn_box2.isSelected == false {
            toast(Constants.Localicable.checkPrivacy)
        }
       
        else{
            authData = AuthRequest(firstName: tfFirstName.text ?? "", lastName: tfLastName.text ?? "", email: tfEmail.text ?? "", password: tfPassword.text ?? "", dateOfBirth: "\(tfMonth.text ?? "")/\(tfDate.text ?? "")/\(tfYear.text ?? "")", fcmToken: AppDefaults.fcmToken, deviceId: UIDevice.current.identifierForVendor!.uuidString, phone: "+1\(tfPhone.text ?? "")",insuranceName: tfInsurrance.text ?? "")
            if let data = authData{
                uploadVM.checkExistence(data)
            }
            
        }
        
    }
    
    //MARK: actionEye
    @IBAction func actionEye(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            if sender.tag == 0{
                eye1.image =  Constants.AppAssets.eyeClosed
                tfPassword.isSecureTextEntry = false
            }
            else{
                eye2.image =  Constants.AppAssets.eyeClosed
                tfConfirmPassword.isSecureTextEntry = false
            }
        }
        else{
            if sender.tag == 0{
                eye1.image = Constants.AppAssets.eye
                tfPassword.isSecureTextEntry = true
            }
            else{
                eye2.image =  Constants.AppAssets.eye
                tfConfirmPassword.isSecureTextEntry = true
            }
            
        }
    }
    
}

