//
//  AppSettings.swift
//  Camo
//
//  Created by SachTech on 29/02/20.
//  Copyright © 2020 SachTech. All rights reserved.
//

import Foundation

struct AppDefaults{
    
    static var firstRun: Bool = true
    
    //MARK:- FCM Token
    static var fcmToken: String{
        set{
            UserDefaults.standard.set(newValue, forKey: Constants.PrefKeys.kFCMToken)
        }
        get{
            return UserDefaults.standard.string(forKey:  Constants.PrefKeys.kFCMToken) ?? ""
        }
    }

    
    static var selectedDrawer: Int{
        set{
            UserDefaults.standard.set(newValue, forKey: "selectedDrawer")
        }
        get{
            return  UserDefaults.standard.integer(forKey: "selectedDrawer")
//            return UserDefaults.standard.Int(forKey:  "badgeNumber") ?? 0
        }
    }
    
    static var selectedTab: Int{
        set{
            UserDefaults.standard.set(newValue, forKey: "selectedTab")
        }
        get{
            return  UserDefaults.standard.integer(forKey: "selectedTab")
//            return UserDefaults.standard.Int(forKey:  "badgeNumber") ?? 0
        }
    }
    static var wifiName: String{
        set{
            UserDefaults.standard.set(newValue, forKey: "wifiName")
        }
        get{
            return UserDefaults.standard.string(forKey:  "wifiName") ?? ""
        }
    }
    static var wifiPassword: String{
        set{
            UserDefaults.standard.set(newValue, forKey: "wifiPassword")
        }
        get{
            return UserDefaults.standard.string(forKey:  "wifiPassword") ?? ""
        }
    }
    
    static var goneForReview: Bool{
        set{
            UserDefaults.standard.set(newValue, forKey: "goneForReview")
        }
        get{
            return UserDefaults.standard.bool(forKey:  "goneForReview")
        }
    }
    
    static var FromReview: Bool{
        set{
            UserDefaults.standard.set(newValue, forKey: "FromReview")
        }
        get{
            return UserDefaults.standard.bool(forKey:  "FromReview")
        }
    }
    
    static var loginBy: String{
        set{
            UserDefaults.standard.set(newValue, forKey: "loginBy")
        }
        get{
            return UserDefaults.standard.string(forKey:  "loginBy") ?? ""
        }
    }
    
    static var userEmail: String{
        set{
            UserDefaults.standard.set(newValue, forKey: "userEmail")
        }
        get{
            return UserDefaults.standard.string(forKey:  "userEmail") ?? ""
        }
    }
    
    static var userData: LoginReponse{
        set{
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey:"userData")
        }
        get{
            if let data = UserDefaults.standard.value(forKey:"userData") as? Data {
                let userData = (try? PropertyListDecoder().decode(LoginReponse.self, from: data)) ?? LoginReponse()
                return userData
            }
            else{
              return LoginReponse()
            }
        }
    }
    
    //MARK:- User Logged In

    
    
    static func isFirstRun() -> Bool{

        if let isAppAlreadyLaunchedOnce = UserDefaults.standard.string(forKey: Constants.PrefKeys.kFirstRun){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            firstRun = false
            return false
            
        }else{
            UserDefaults.standard.set(true, forKey: Constants.PrefKeys.kFirstRun)
            print("App launched first time")
            firstRun = true
            return true
        }
    }

    static var accessToken: String{
        set{
            UserDefaults.standard.set(newValue, forKey: PrefKeys.kAccessToken)
        }
        get{
            return UserDefaults.standard.string(forKey:  PrefKeys.kAccessToken) ?? ""
        }
    }
    static var badgeNumber: Int{
        set{
            UserDefaults.standard.set(newValue, forKey: "badgeNumber")
        }
        get{
            return  UserDefaults.standard.integer(forKey: "badgeNumber")
//            return UserDefaults.standard.Int(forKey:  "badgeNumber") ?? 0
        }
    }
    
    
  
    
    static var refreshToken: String{
        set{
            UserDefaults.standard.set(newValue, forKey: PrefKeys.kRefreshToken)
        }
        get{
            return UserDefaults.standard.string(forKey:  PrefKeys.kRefreshToken) ?? ""
        }
    }
    
    static var tokenExpiry:Date{
        set{
            UserDefaults.standard.set(newValue as AnyObject, forKey: PrefKeys.kTokenExpiry)
        }
        get{
            UserDefaults.standard.value(forKey: PrefKeys.kTokenExpiry) as? Date ?? Date().addingTimeInterval(-1)
        }
    }
    
    static func clearAppDefaults(){
        accessToken = ""
        refreshToken = ""
        tokenExpiry = Date()
        UserDefaults.standard.set(nil, forKey: Constants.PrefKeys.kUserData)
        UserDefaults.standard.set(false, forKey: PrefKeys.kFirstRun)
    }
    
//    struct UserProfileCache {
//        static let key = "userProfileCache"
//        static func save(_ value: Setting) {
//             UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
//        }
//        static func get() -> Setting {
//            var userData: Setting!
//            if let data = UserDefaults.standard.value(forKey: key) as? Data {
//                userData = try? PropertyListDecoder().decode(Setting.self, from: data)
//                return userData!
//            } else {
//                return userData
//            }
//        }
//        static func remove() {
//            UserDefaults.standard.removeObject(forKey: key)
//        }
//    }
    //MARK:- Clear App Defaults
}
