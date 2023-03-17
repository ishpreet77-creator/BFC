//
//  AuthRequest.swift
//  CleanBee
//
//  Created by John on 16/01/21.
//

import Foundation
import UIKit
struct AuthRequest: JsonSerilizer {
    var firstName: String = ""
    var lastName:String = ""
    var email: String = ""
    var password: String = ""
    var dateOfBirth = ""
    var fcmToken = ""
    var deviceId = ""
    var phone = ""
    var insuranceName: String = ""
    var content:Data = Data()
    func serilize() -> Dictionary<String, Any> {
        return [
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "phone_no": phone,
            "password": password,
            "dob": dateOfBirth,
            "fcm_token":fcmToken,
            "device_id":deviceId,
            "os":"ios",
            "insurance_name": insuranceName
        ]
    }
}

struct SocialLogin: JsonSerilizer {
    var login_type: String = ""
    var facebook_id:String = ""
    var google_id:String = ""
    var auth_id:String = ""
    var email: String = ""
    var fcmToken = ""
    var deviceId = ""
   var firstName = ""
    func serilize() -> Dictionary<String, Any> {
        return [
            "login_type":login_type,
            "first_name": firstName,
            "email": email,
            "fcm_token":fcmToken,
            "device_id":deviceId,
            "facebook_id": facebook_id,
            "google_id":google_id,
            "auth_token": auth_id,
            "os":"ios"
        ]
    }
}

struct LogoutReqst: JsonSerilizer {
    var userID: String = ""
    var device_id: String = ""
    func serilize() -> Dictionary<String, Any> {
        return [
            "user_id":userID,
            "device_id": device_id,
            "os":"ios"
        ]
    }
}

struct ForgetReqst: JsonSerilizer {
    var otp: String = ""
    var email: String = ""
    var password:String = ""
    func serilize() -> Dictionary<String, Any> {
        return [
            "otp":otp,
            "email": email,
            "password":password,
            "os":"ios"
        ]
    }
}

struct RefreshToken: JsonSerilizer {
    var id: String = ""
    var oldToken:String = ""
    func serilize() -> Dictionary<String, Any> {
        return [
            "type":"user",
            "_id": id,
            "old_token":oldToken,
            "device_id":UIDevice.current.identifierForVendor!.uuidString
        ]
    }
}


struct EditProfile: JsonSerilizer {
    var firstName: String = ""
    var lastName:String = ""
    var email: String = ""
    var dateOfBirth = ""
    var phone = ""
    var insurrance = ""
    func serilize() -> Dictionary<String, Any> {
        return [
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "phone_no": phone,
            "dob": dateOfBirth,
            "insurance_name": insurrance
        ]
    }
}

struct ChangePassword: JsonSerilizer {
    var oldPassword: String = ""
    var newPassword:String = ""
    func serilize() -> Dictionary<String, Any> {
        return [
            "old_password":oldPassword,
            "new_password": newPassword,
        ]
    }
}
struct NotificationRequest: JsonSerilizer {
    var notification: Int = 1

    func serilize() -> Dictionary<String, Any> {
        return [
            "notification_type": notification,
        ]
    }
}
//struct FoodDiaryRequest: JsonSerilizer,FileSerilizer {
//
//    var howFeel: String = ""
//    var location: String = ""
//    var description: String = ""
//    var trySomething: String = ""
//    var suppliments: String = ""
//    var mealType: String = ""
//    var time:String = ""
//    var mealContain:String = ""
//    var content:[Data] = []
//    var others:String = ""
//    func serilize() -> Dictionary<String, Any> {
//        return [
//            "how_feel": howFeel,
//            "location": location,
//            "description": description,
//            "try_something_desc": trySomething,
//            "supplements": suppliments,
//            "meal_type": mealType,
//            "meal_contain":mealContain,
//            "time":time,
//            "other":others
//
//        ]
//    }
//
//    func file() -> (String, [Data]) {
//        return("meal_image[]", content)
//    }
//}
//
//struct UpdateReq: JsonSerilizer {
//    var name: String = ""
//    var email: String = ""
//    var password: String = ""
//    var passwordConfirm: String = ""
//    var wakingTime: String = ""
//    var sleepingTime: String = ""
//    var profile:String = ""
//    var Zipcode:String = ""
//    var dateOfBirth = ""
//    var lastNAme = ""
//    func serilize() -> Dictionary<String, Any> {
//        return [
//            "name": name,
//            "email": email,
//            "password": password,
//            "password_confirmation": passwordConfirm,
//            "wakeup_time": wakingTime,
//            "sleeping_time": sleepingTime,
//            "zip_code":Zipcode,
//            "dob":dateOfBirth,
//            "last_name":lastNAme
//        ]
//    }
//}
//struct NotifyReadReq: JsonSerilizer {
//    var id: Int = 0
//
//    func serilize() -> Dictionary<String, Any> {
//        return [
//            "id": id,
//
//        ]
//    }
//}
//
//struct DeleteWater: JsonSerilizer {
//    var id: Int = 0
//    var type:String = ""
//
//    func serilize() -> Dictionary<String, Any> {
//        return [
//            "id": id,
//            "type":type
//        ]
//    }
//}
//
//struct AddFeedback: JsonSerilizer {
//    var rating: Double = 0.0
//    var comment: String = ""
//    func serilize() -> Dictionary<String, Any> {
//        return [
//            "rating": rating,
//            "comment": comment,
//        ]
//    }
//}
//
//struct FoodDataReq: JsonSerilizer {
//    var date: String = ""
//    var mealType: String = ""
//    func serilize() -> Dictionary<String, Any> {
//        return [
//            "date": date,
//            "meal_type": mealType,
//        ]
//    }
//}
//
//
//struct FcmReq: JsonSerilizer {
//    var deviceId: String = ""
//    var fcm: String = ""
//    func serilize() -> Dictionary<String, Any> {
//        return [
//            "device_id": deviceId,
//            "fcm_token": fcm,
//        ]
//    }
//}
//




//
//struct AuthRequest: JsonSerilizer {
//
//    var name: String = ""
//    var email: String = ""
//    var password: String = ""
//    var passwordConfirm: String = ""
//    var wakingTime: String = ""
//    var sleepingTime: String = ""
//    var profileImg: String = ""
//    func serilize() -> Dictionary<String, Any> {
//        return [
//            "name": name,
//            "email": email,
//            "password": password,
//            "password_confirmation": passwordConfirm,
//            "wakeup_time": wakingTime,
//            "sleeping_time": sleepingTime,
//            "profile": profileImg,
//        ]
//    }
//}


