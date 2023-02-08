//
//  AuthResponse.swift
//  CleanBee
//
//  Created by John on 16/01/21.
//

import Foundation

struct AuthResponse: JsonDeserilizer {
    
    var statusCode: Int = 0
    var status: Bool = false
    var message: String = ""
    var data:String = ""
    var userData = LoginReponse()
    var token = ""
    mutating func deserilize(values: Dictionary<String, Any>?) {
        status = values?["status"] as? Bool ?? false
        message = values?["message"] as? String ?? ""
        data = values?["data"] as? String ?? ""
        if let detail = values?["data"] as? Dictionary<String, Any>{
            userData.deserilize(values: detail)
        }
        if let detail = values?["data"] as? Dictionary<String, Any>{
            self.token = detail["token"] as? String ?? ""
        }
        
        
//
//
//        if let count = values?["data"] as? Int{
//             self.notifyCount = count
//        }
//        if let meal = values?["data"] as? Dictionary<String, Any>{
//            mealData.deserilize(values: meal)
//        }
//        self.pdfUrl = values?["data"] as? String ?? ""
//
//        if let quoteData = values?["data"] as? Dictionary<String, Any>{
//            self.quote = quoteData["motivate_quote"] as? String ?? ""
//            self.quoteAuthor = quoteData["motivate_author"] as? String ?? ""
//        }
//
//
//        if let suplD = values?["data"] as? Dictionary<String, Any>{
//            if let item = suplD["supplement_options"] as? Array<Dictionary<String, Any>>{
//                for data in item{
//                    var supp = SupplementList.init()
//                    supp.deserilize(values: data)
//                    supplementList.append(supp)
//                }
//            }
//        }
//
//        if let noti = values?["data"] as? Array<Dictionary<String, Any>>{
//            for dataa in noti{
//                var ItemDataa = Notifications.init()
//                ItemDataa.deserilize(values: dataa)
//                notify.append(ItemDataa)
//            }
//        }
        
//        if let item = values?["data"] as? Array<Dictionary<String, Any>>{
//            self.subblementOption = item["supplement_options"]
//        }
    }
}




struct LoginReponse: JsonDeserilizer {
    var statusCode: Int = 0
    var message:String = ""
    var userId:String = ""
    var firstName: String = ""
    var lastName:String = ""
    var email: String = ""
    var dateOfBirth = ""
    var phone = ""
    var token = ""
    var is_email_verified = ""
    var login_type = ""
    var insurancename = ""
    mutating func deserilize(values: Dictionary<String, Any>?) {
        
        userId = values?["_id"] as? String ?? ""
        firstName = values?["first_name"] as? String ?? ""
        lastName = values?["last_name"] as? String ?? ""
        email = values?["email"] as? String ?? ""
        dateOfBirth = values?["dob"] as? String ?? ""
        phone = values?["phone_no"] as? String ?? ""
        token = values?["token"] as? String ?? ""
        is_email_verified = values?["is_email_verified"] as? String ?? ""
        login_type = values?["login_type"] as? String ?? ""
        insurancename = values?["insurance_name"] as? String ?? ""


    }
}


//struct Notifications: JsonDeserilizer {
//    var statusCode: Int = 0
//    var message:String = ""
//    var isRead:String = ""
//    var type:String = ""
//    var id:Int = 0
//    var json_data :NotificationQuotes = NotificationQuotes()
//
//
//    mutating func deserilize(values: Dictionary<String, Any>?) {
//        message = values?["message"] as? String ?? ""
//        isRead = values?["is_read"] as? String ?? ""
//        type = values?["notification_type"] as? String ?? ""
//        id = values?["id"] as? Int ?? 0
//
//        let string = values?["json_data"] as? String
//        if let data = string?.data(using: .utf8)!{
//        do {
//            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>
//            {
//               print(jsonArray)
////                if let jsn = values?["json_data"] as? Dictionary<String, Any>{
//                    json_data.deserilize(values: jsonArray)
////                }// use the json here
//            } else {
//                print("bad json")
//            }
//        } catch let error as NSError {
//            print(error)
//        }
//
//
//    }
//
//
//
//    }
//}
//
//struct NotificationQuotes: JsonDeserilizer {
//    var statusCode: Int = 0
//    var message:String = ""
//    var motivate_quote:String = ""
//    var motivate_author:String = ""
//    var id:Int = 0
//
//    mutating func deserilize(values: Dictionary<String, Any>?) {
//        message = values?["message"] as? String ?? ""
//        motivate_quote = values?["motivate_quote"] as? String ?? ""
//        motivate_author = values?["motivate_author"] as? String ?? ""
//
//    }
//}
//
//
//struct UserDetails: JsonDeserilizer {
//    var statusCode: Int = 0
//    var name: String = ""
//    var email: String = ""
//    var wakeupTime: String = ""
//    var sleepingTime: String = ""
//    var profile: String = ""
//    var updatedAt: String = ""
//    var createdAt: String = ""
//    var dob:String = ""
//    var zip:String = ""
//    var lastName = ""
//    var id: Int = -1
//    var peronaName = ""
//    var phoneNumber = ""
//
//
//
//    mutating func deserilize(values: Dictionary<String, Any>?) {
//        name = values?["name"] as? String ?? ""
//        email = values?["email"] as? String ?? ""
//        wakeupTime = values?["wakeup_time"] as? String ?? ""
//        sleepingTime = values?["sleeping_time"] as? String ?? ""
//        profile = values?["profile"] as? String ?? ""
//        updatedAt = values?["updated_at"] as? String ?? ""
//        createdAt = values?["created_at"] as? String ?? ""
//        id = values?["id"] as? Int ?? -1
//        dob = values?["dob"] as? String ?? ""
//        zip =  values?["zip_code"] as? String ?? ""
//        lastName =  values?["last_name"] as? String ?? ""
//        peronaName =  values?["persona"] as? String ?? ""
//        phoneNumber =  values?["phone"] as? String ?? ""
//    }
//}
//
//struct SupplementList: JsonDeserilizer {
//    var statusCode: Int = 0
//    var option: String = ""
//    var isSelected: Int = 0
//
//
//
//
//    mutating func deserilize(values: Dictionary<String, Any>?) {
//        option = values?["option_name"] as? String ?? ""
//        isSelected = values?["is_selected"] as? Int ?? 0
//
//    }
//}
//
//
//struct FoodMeal: JsonDeserilizer {
//    var statusCode: Int = 0
//    var publicId: Int = 0
//    var userID: Int = 0
//    var id: Int = 0
//    var mealType: String = ""
//    var mealName: String = ""
//    var time: String = ""
//    var description: String = ""
//    var trySomething: String = ""
//    var howFeel:String = ""
//    var location:String = ""
//    var supplements: String  = ""
//    var updateAt: String = ""
//    var createdAt: String = ""
//    var mealContain:String = ""
//    var mealImages :[MealImages] = []
//    var supplList:[SupplementList] = []
//
//
//    mutating func deserilize(values: Dictionary<String, Any>?) {
//        publicId = values?["public_id"] as? Int ?? -1
//        userID = values?["user_id"] as? Int ?? -1
//        id = values?["id"] as? Int ?? -1
//        mealType = values?["meal_type"] as? String ?? ""
//        mealName = values?["meal_name"] as? String ?? ""
//        time = values?["time"] as? String ?? ""
//        description = values?["description"] as? String ?? ""
//        trySomething = values?["try_something_desc"] as? String ?? ""
//        howFeel = values?["how_feel"] as? String ?? ""
//        location = values?["location"] as? String ?? ""
//        supplements = values?["supplements"] as? String ?? ""
//        updateAt =  values?["updated_at"] as? String ?? ""
//        createdAt =  values?["created_at"] as? String ?? ""
//        mealContain =  values?["meal_contain"] as? String ?? ""
//
//        if let item = values?["mealImages"] as? Array<Dictionary<String, Any>>{
//            for data in item{
//                var ItemData = MealImages.init()
//                ItemData.deserilize(values: data)
//                mealImages.append(ItemData)
//            }
//        }
//
//        if let item = values?["supplements"] as? Array<Dictionary<String, Any>>{
//            for data in item{
//                var supp = SupplementList.init()
//                supp.deserilize(values: data)
//                supplList.append(supp)
//            }
//        }
//    }
//}
//
//struct MealImages: JsonDeserilizer {
//    var statusCode: Int = 0
//    var mediaType: String = ""
//    var postFileLink: String = ""
//    var fileName: String = ""
//    var foodDiaryId: Int = 0
//    var updateAt: String = ""
//    var createdAt: String = ""
//    var id: Int = 0
//    mutating func deserilize(values: Dictionary<String, Any>?) {
//        mediaType = values?["media_type"] as? String ?? ""
//        postFileLink = values?["post_file_link"] as? String ?? ""
//        fileName = values?["file_name"] as? String ?? ""
//        foodDiaryId = values?["food_diary_id"] as? Int ?? -1
//        updateAt = values?["updated_at"] as? String ?? ""
//        createdAt = values?["created_at"] as? String ?? ""
//        id = values?["id"] as? Int ?? 0
//    }
//}
