//
//  AuthRepoImp.swift
//  CleanBee
//
//  Created by John on 16/01/21.
//

import Foundation
import RxSwift

class AuthRepoImp: AuthRepo{
  
    
    private var rxApi:RxApi
    
    init(rxApi:RxApi) {
        self.rxApi = rxApi
    }
 
    func signUpUser(_ req: AuthRequest) -> Single<AuthResponse> {
                return rxApi.postUpload(path: Constants.RxApiEnds.signUp, value: req).asSingle()
    }
    func emailExistence(_ req: AuthRequest) -> Single<AuthResponse> {
                return rxApi.post(path: Constants.RxApiEnds.emailExistence, value: req).asSingle()
    }
    func loginUser(_ req: AuthRequest) -> Single<AuthResponse> {
                return rxApi.post(path: Constants.RxApiEnds.login, value: req).asSingle()
    }
    
    func socialLogin(_ req: SocialLogin) -> Single<AuthResponse> {
                return rxApi.post(path: Constants.RxApiEnds.socialLogin, value: req).asSingle()
    }
    func logout(_ req: LogoutReqst) -> Single<AuthResponse> {
                return rxApi.post(path: Constants.RxApiEnds.logout, value: req).asSingle()
    }
    
    func forgetPass(_ req: ForgetReqst) -> Single<AuthResponse>{
        return rxApi.post(path: Constants.RxApiEnds.forget, value: req).asSingle()
}
    func VerifyOtp(_ req: ForgetReqst) -> Single<AuthResponse>{
        return rxApi.post(path: Constants.RxApiEnds.verify, value: req).asSingle()
}
    func resetPassword(_ req: ForgetReqst) -> Single<AuthResponse>{
        return rxApi.post(path: Constants.RxApiEnds.resetPass, value: req).asSingle()
}
    func refreshToken(_ req: RefreshToken) -> Single<AuthResponse>{
        return rxApi.post(path: Constants.RxApiEnds.refreshToken, value: req).asSingle()
}
    
    func editProfile(_ req: EditProfile) -> Single<AuthResponse>
    {
        return rxApi.post(path: Constants.RxApiEnds.editProfile, value: req).asSingle()
}
    func ChangePassword(_ req: ChangePassword) -> Single<AuthResponse>{
        return rxApi.post(path: Constants.RxApiEnds.changePassword, value: req).asSingle()
}
    
    func resentOtp(_ req: ForgetReqst) -> RxSwift.Single<AuthResponse> {
        return rxApi.post(path: Constants.RxApiEnds.resend, value: req).asSingle()
    }
    
    func notificxation(_ req: NotificationRequest) -> RxSwift.Single<AuthResponse> {
        return rxApi.post(path: Constants.RxApiEnds.notification, value: req).asSingle()
    }
//    func updateUserInfo(_ req: AuthRequest) -> Single<AuthResponse>{
//        return rxApi.postUpload(path: Constants.RxApiEnds.updateUser, value: req).asSingle()
//    }
//
//    func updateProfile(_ req: UpdateReq) -> Single<AuthResponse>{
//        return rxApi.post(path: Constants.RxApiEnds.updateUser, value: req).asSingle()
//    }
//
//    func addMeal(_ req: FoodDiaryRequest) -> Single<AuthResponse> {
//        return rxApi.postUpload(path: Constants.RxApiEnds.foodAdd, value: req).asSingle()
//    }
//    func deleteAccount() -> Single<AuthResponse>{
//        return rxApi.postUpload(path: Constants.RxApiEnds.deleteAcct, value:CommonRequest.init()).asSingle()
//    }
//
//    func getSupplements() -> Single<AuthResponse>{
//        return rxApi.post(path: Constants.RxApiEnds.getSuppliments, value:CommonRequest.init()).asSingle()
//    }
//    func AddFeeedback(_ req:AddFeedback ) -> Single<AuthResponse>{
//        return rxApi.post(path: Constants.RxApiEnds.addFeedBack, value:req).asSingle()
//    }
//    func loginUser(_ req: AuthRequest) -> Single<AuthResponse> {
//        return rxApi.postUpload(path: Constants.RxApiEnds.loginUser, value: req).asSingle()
//    }
//    func sendOtp(_ req: AuthRequest) -> Single<AuthResponse>{
//        return rxApi.postUpload(path: Constants.RxApiEnds.sendOtp, value: req).asSingle()
//    }
//    func verifyOtp(_ req: AuthRequest) -> Single<AuthResponse>{
//        return rxApi.postUpload(path: Constants.RxApiEnds.verifyOtp, value: req).asSingle()
//    }
//    func updatePassword(_ req: AuthRequest) -> Single<AuthResponse>{
//        return rxApi.postUpload(path: Constants.RxApiEnds.updatePass, value: req).asSingle()
//    }
//    func notificationApi() -> Single<AuthResponse>{
//        return rxApi.post(path: Constants.RxApiEnds.notifyEveryday, value:CommonRequest.init()).asSingle()
//    }
//
//    func getFoodData(_ req: FoodDataReq) -> Single<AuthResponse>{
//        return rxApi.post(path: Constants.RxApiEnds.getFoodData, value:req).asSingle()
//    }
//    func getpdf() -> Single<AuthResponse>{
//        return rxApi.get(path: Constants.RxApiEnds.pdfUrl, value:CommonRequest.init()).asSingle()
//    }
//
//    func updateFcm(_ req: FcmReq) -> Single<AuthResponse>{
//        return rxApi.post(path: Constants.RxApiEnds.updateFcmToken, value:req).asSingle()
//    }
//
//    func getNotifications() -> Single<AuthResponse>{
//        return rxApi.post(path: Constants.RxApiEnds.getNotification, value:CommonRequest.init()).asSingle()
//    }
//
//    func readNotification(_ req: NotifyReadReq) -> Single<AuthResponse> {
//        return rxApi.post(path: Constants.RxApiEnds.notifyRead, value:req).asSingle()
//    }
//
//    func deleteWater(_ req: DeleteWater) -> Single<AuthResponse> {
//        return rxApi.post(path: Constants.RxApiEnds.deleteWaterGlass, value:req).asSingle()
//    }
//
//    func readAllNotification() -> Single<AuthResponse>{
//        return rxApi.post(path: Constants.RxApiEnds.readAll, value:CommonRequest.init()).asSingle()
//    }
//
//    func getNotificationCount() -> Single<AuthResponse>{
//        return rxApi.post(path: Constants.RxApiEnds.getNotificationCount, value:CommonRequest.init()).asSingle()
//    }
}
