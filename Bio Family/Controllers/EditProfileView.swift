//
//  EditProfileView.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit
import DropDown
import RxSwift
class EditProfileView: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var topNavView: UIViewX!
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
    @IBOutlet weak var tfInsurrance: UITextField!
    @IBOutlet weak var setInsurance: UIButton!
    //MARK: variable
    var currentYear = Calendar.current.component(.year, from: Date())
    //MARK: constant
    let date = DropDown()
    let month = DropDown()
    let year = DropDown()
    let insurrance = DropDown()
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        observeEditProfile()
        //configureUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    //MARK: configureUI
    fileprivate func configureUI() {
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
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
        
        tfFirstName.text = AppDefaults.userData.firstName
        tfLastName.text = AppDefaults.userData.lastName
        tfEmail.text = AppDefaults.userData.email
        tfPhone.text = AppDefaults.userData.phone
        tfInsurrance.text = AppDefaults.userData.insurancename
        if AppDefaults.userData.dateOfBirth != ""{
            let dob = AppDefaults.userData.dateOfBirth.components(separatedBy: "/")
            tfMonth.text = dob[0]
            tfDate.text = dob[1]
            tfYear.text = dob[2]
        }
        
    }
    //MARK: action
    @IBAction func actionMonth(_ sender:UIButton) {
        month.show()
    }
    
    @IBAction func actionDate(_ sender: UIButton) {
        date.show()
    }
    
    @IBAction func actionYear(_ sender: UIButton) {
        year.show()
    }
    
    @IBAction func actionSetinsurence(_ sender: Any) {
        insurrance.show()
    }
    
    @IBAction func back(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionSaveProfile(_ sender: UIButton) {
        uploadVM.editProfile(EditProfile(firstName: tfFirstName.text ?? "", lastName: tfLastName.text ?? "", email: tfEmail.text ?? "", dateOfBirth: "\(tfMonth.text ?? "")/\(tfDate.text ?? "")/\(tfYear.text ?? "")", phone: tfPhone.text ?? "",insurrance: tfInsurrance.text ?? ""))
    }
    
    
    @IBAction func actionChangePassword(_ sender: Any) {
        let _: ChangePasswordVC = self.open()
    }
    
    //MARK: observer Function
    fileprivate func observeEditProfile(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
//                if self.uploadVM.type == .refresh{
//                    self.uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
//                }
                
//                else{
                    
//                    DispatchQueue.main.async {
                        var user = AppDefaults.userData
                        user.email = self.tfEmail.text ?? ""
                        user.firstName = self.tfFirstName.text ?? ""
                        user.lastName = self.tfLastName.text ?? ""
                        user.dateOfBirth = "\(self.tfMonth.text ?? "")/\(self.tfDate.text ?? "")/\(self.tfYear.text ?? "")"
                        user.phone = self.tfPhone.text ?? ""
                        user.insurancename = self.tfInsurrance.text ?? ""
                        AppDefaults.userData = user
                        self.navigationController?.popViewController(animated: true)
//                    }
//                }
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
    
}
