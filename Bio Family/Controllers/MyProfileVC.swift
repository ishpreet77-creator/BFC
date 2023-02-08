//
//  MyProfileVC.swift
//  Bio Family
//
//  Created by John on 27/12/22.
//

import UIKit

class MyProfileVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var tfYear: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfMonth: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    
    @IBOutlet weak var insurranceName: UITextField!
    @IBOutlet weak var topNavView: UIViewX!
    
    private let uploadVM = AppVM.init(repository: AppRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        obserdeleteResponse()
        //configurUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        configurUI()
    }
    
    fileprivate func configurUI() {
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        firstName.text = AppDefaults.userData.firstName
        lastName.text = AppDefaults.userData.lastName
        tfEmail.text = AppDefaults.userData.email
        tfPhoneNumber.text = AppDefaults.userData.phone
        insurranceName.text = AppDefaults.userData.insurancename
        if AppDefaults.userData.dateOfBirth != ""{
            let dob = AppDefaults.userData.dateOfBirth.components(separatedBy: "/")
            tfMonth.text = dob[0]
            tfDate.text = dob[1]
            tfYear.text = dob[2]
        }
       
    }
    
    fileprivate func obserdeleteResponse(){
        let _ =  uploadVM.isLoading.subscribe { (isLoading) in
            isLoading ? self.showProgress() : self.hideProgress()
        }
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                AppDefaults.selectedDrawer = -1
                AppDefaults.selectedTab = 1
                AppDefaults.userData = LoginReponse()
                let _: LoginVC = self.open()
            
                
            }else{
                self.showAlert(response?.message ?? "")
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
    @IBAction func back(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionEditProfile(_ sender: UIButton) {
        let _: EditProfileView = self.open()
    }
    
    @IBAction func actionDelete(_ sender: Any) {
       
        
        let refreshAlert = UIAlertController(title: "BioFamily", message: "Are you sure yow want to delete your Account.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.uploadVM.delete()
            print("delete")
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
}
