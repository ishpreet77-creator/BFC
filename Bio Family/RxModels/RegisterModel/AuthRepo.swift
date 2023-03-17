//
//  AuthRepo.swift
//  CleanBee
//
//  Created by John on 16/01/21.
//

import Foundation

import RxSwift

protocol AuthRepo {
    func emailExistence(_ req: AuthRequest) -> Single<AuthResponse>
    func signUpUser(_ req: AuthRequest) -> Single<AuthResponse>
    func loginUser(_ req: AuthRequest) -> Single<AuthResponse>
    func socialLogin(_ req: SocialLogin) -> Single<AuthResponse>
    func logout(_ req: LogoutReqst) -> Single<AuthResponse>
    func forgetPass(_ req: ForgetReqst) -> Single<AuthResponse>
    func VerifyOtp(_ req: ForgetReqst) -> Single<AuthResponse>
    func resetPassword(_ req: ForgetReqst) -> Single<AuthResponse>
    func refreshToken(_ req: RefreshToken) -> Single<AuthResponse>
    func editProfile(_ req: EditProfile) -> Single<AuthResponse>
    func ChangePassword(_ req: ChangePassword) -> Single<AuthResponse>
    func resentOtp(_ req: ForgetReqst) -> Single<AuthResponse>
    func notificxation(_ req: NotificationRequest) -> Single<AuthResponse>
    
}
