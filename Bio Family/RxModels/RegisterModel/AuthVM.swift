//
//  AuthVM.swift
//  CleanBee
//
//  Created by John on 16/01/21.
//

import Foundation
import RxSwift
import Alamofire
enum AuthType {
case Register
case UpdateProfile
    case login
    case socialLogin
    case signup
    case verify
    case forget
    case reset
    case refresh
    case resend
    case notification
}

class AuthVM: ViewModel<AuthResponse>{
    
    private var repository: AuthRepo
    var type:AuthType = .Register
    init(repository: AuthRepo) {
        self.repository = repository
    }
    
    //MARK:- Userdefined Varaiables
    
    //MARK:- Check User Signup validation Api

    
    func signUpUser(_ req: AuthRequest){
        isLoading.onNext(true)
        repository.signUpUser(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .signup
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    
    
    
    func checkExistence(_ req: AuthRequest){
        isLoading.onNext(true)
        repository.emailExistence(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
            }
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func loginUser(_ req: AuthRequest){
        isLoading.onNext(true)
        repository.loginUser(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                self.saveToken(response.userData.token)
            }
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func socialLogin(_ req: SocialLogin){
        isLoading.onNext(true)
        repository.socialLogin(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                self.saveToken(response.userData.token)
            }
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func logout(_ req: LogoutReqst){
        isLoading.onNext(true)
        repository.logout(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
            }
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    
    func forget(_ req: ForgetReqst){
        isLoading.onNext(true)
        repository.forgetPass(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
            }
            self.type = .forget
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    
    func verify(_ req: ForgetReqst){
        isLoading.onNext(true)
        repository.VerifyOtp(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
            }
            self.type = .verify
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    
    func reset(_ req: ForgetReqst){
        isLoading.onNext(true)
        repository.resetPassword(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
            }
            self.type = .reset
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    
    func refreshToken(_ req: RefreshToken){
        isLoading.onNext(true)
        repository.refreshToken(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                print("tokem *************************************************** \(response.token)")
                self.type = .refresh
                self.saveToken(response.token)
                var user = AppDefaults.userData
                user.token = response.token
                AppDefaults.userData = user
            }
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    
    
    func editProfile(_ req: EditProfile){
        isLoading.onNext(true)
        repository.editProfile(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
            }
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    
    func changePasswoird(_ req: ChangePassword){
        isLoading.onNext(true)
        repository.ChangePassword(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
            }
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func resend(_ req: ForgetReqst){
        isLoading.onNext(true)
        repository.resentOtp(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
            }
            self.type = .resend
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func notification(_ req: NotificationRequest){
        isLoading.onNext(true)
        repository.notificxation(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
            }
            self.type = .notification
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    
//    func loginUser(_ req: AuthRequest){
//        isLoading.onNext(true)
//        repository.loginUser(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
//                self.saveToken(response.token)
//                //                saveUserData(response.data)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .Login
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//    func sendOtp(_ req: AuthRequest){
//        isLoading.onNext(true)
//        repository.sendOtp(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
//                //                saveUserData(response.data)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .sendOtp
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//    func verifyOtp(_ req: AuthRequest){
//        isLoading.onNext(true)
//        repository.verifyOtp(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
//                //                saveUserData(response.data)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .verifyotp
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//    func updatePassword(_ req: AuthRequest){
//        isLoading.onNext(true)
//        repository.updatePassword(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
//                //                saveUserData(response.data)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .updatePass
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//    func updateUser(_ req: AuthRequest){
//        isLoading.onNext(true)
//        repository.updateUserInfo(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
//                //saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .UpdateUser
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//    func notifyEveryday(){
//        isLoading.onNext(true)
//        repository.notificationApi().subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .notification
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//
//    func notifyCount(){
//        isLoading.onNext(true)
//        repository.getNotificationCount().subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .readCount
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//    func updateProfile(_ req: UpdateReq){
//        isLoading.onNext(true)
//        repository.updateProfile(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
//                //saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .UpdateProfile
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//    func updateFcm(_ req: FcmReq){
//        isLoading.onNext(true)
//        repository.updateFcm(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
//
//            }
//            self.forgetPasswordType = .FcmUpdate
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//    func addMEal(_ req: FoodDiaryRequest){
//        isLoading.onNext(true)
//        repository.addMeal(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .addMeal
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//    func getMeal(_ req: FoodDataReq){
//        isLoading.onNext(true)
//        repository.getFoodData(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
////            self.forgetPasswordType = .SignUpUser
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//    func deleteAccount(){
//        isLoading.onNext(true)
//        repository.deleteAccount().subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .deleteAcct
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//    func getPdf(){
//        isLoading.onNext(true)
//        repository.getpdf().subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
////            self.forgetPasswordType = .deleteAcct
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//
//    func getSupplements(){
//        isLoading.onNext(true)
//        repository.getSupplements().subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
////            self.forgetPasswordType = .deleteAcct
//            self.forgetPasswordType = .getSuppliments
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//    func addFeedback(_ req: AddFeedback){
//        isLoading.onNext(true)
//        repository.AddFeeedback(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .Feedback
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//    func getNotification(){
//        isLoading.onNext(true)
//        repository.getNotifications().subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .Notifications
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//    func readNotify(_ req: NotifyReadReq){
//        isLoading.onNext(true)
//        repository.readNotification(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .readNotifications
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//
//    func deleteWater(_ req: DeleteWater){
//        isLoading.onNext(true)
//        repository.deleteWater(req).subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .deleteWater
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
//
//
//    func readAllNotification(){
//        isLoading.onNext(true)
//        repository.readAllNotification().subscribe(onSuccess: { (response) in
//            if response.statusCode == 200{
////                self.saveToken(response.token)
////                saveUserData(response.userData)
//                //                self.saveToken(response.data.token)
//            }
//            self.forgetPasswordType = .readAll
//            self.response.onNext(response)
//            self.isLoading.onNext(false)
//        }, onFailure: { (error) in
//            self.isLoading.onNext(false)
//            self.error.onNext(error.localizedDescription)
//        }).disposed(by: super.disposeBag)
//    }
    private func saveToken(_ token: String){
            AppDefaults.accessToken = token
            //AppDefaults.tokenExpiry = Date().addingTimeInterval(TimeInterval(7200))
        AppDefaults.tokenExpiry = Date().addingTimeInterval(TimeInterval(14400))///  1 hour
    }
   
}

