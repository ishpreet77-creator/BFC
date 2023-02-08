//
//  Utils.swift
//  Camo
//
//  Created by SachTech on 25/02/20.
//  Copyright © 2020 SachTech. All rights reserved.
//

import Foundation

//func fetchUserData() -> UserDetails?{
//    let defaults = UserDefaults.standard
//    if let decoded  = defaults.data(forKey: Constants.PrefKeys.kUserData){
//        do{
//            if let user = try NSKeyedUnarchiver.unarchivedObject(ofClass: PrefUser.self, from: decoded){
//                let usr = UserDetails(statusCode: 0, name: user.name, email: user.email, wakeupTime: user.wakeupTime, sleepingTime: user.sleepingTime, profile: user.profile, updatedAt: user.updatedAt, createdAt: user.createdAt,dob: user.dob, zip: user.zip, lastName: user.lastName, id: user.id,peronaName: user.personaName,phoneNumber: user.phoneNumber)
//                return usr
//            }else{
//                return nil
//            }
//        }catch{
//            return nil
//        }
//    }
//    else{
//        return nil
//    }
//}

//func saveUserData(_ user: UserDetails){
//
//    let prefUser = PrefUser(name: user.name, email: user.email, wakeupTime: user.wakeupTime, sleepingTime: user.sleepingTime, profile: user.profile, updatedAt: user.updatedAt, createdAt: user.createdAt, id: user.id,dob: user.dob,zip: user.zip,lastName: user.lastName,personaName: user.peronaName,phoneNumber: user.phoneNumber)
//
//    let defaults = UserDefaults.standard
//    do{
//        let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: prefUser, requiringSecureCoding: false)
//        defaults.set(encodedData, forKey: Constants.PrefKeys.kUserData)
//        defaults.synchronize()
//    }catch{
//
//    }
//}

//func clearDefaults(){
//    let defaults = UserDefaults.standard
//    let domain = Bundle.main.bundleIdentifier!
//    defaults.removePersistentDomain(forName: domain)
//    defaults.synchronize()
//}

//class PrefUser: NSObject, NSCoding, NSSecureCoding{
//    static var supportsSecureCoding: Bool = true
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
//    var personaName = ""
//    var phoneNumber = ""
//
//    init(name: String, email: String, wakeupTime: String, sleepingTime: String, profile: String, updatedAt: String, createdAt: String, id: Int,dob:String,zip:String,lastName:String,personaName:String,phoneNumber:String) {
//        self.name = name
//        self.email = email
//        self.wakeupTime = wakeupTime
//        self.sleepingTime = sleepingTime
//        self.profile = profile
//        self.updatedAt = updatedAt
//        self.createdAt = createdAt
//        self.id = id
//        self.dob = dob
//        self.zip = zip
//        self.lastName = lastName
//        self.personaName = personaName
//        self.phoneNumber = phoneNumber
//
//
//    }
//
//func encode(with aCoder: NSCoder) {
//    aCoder.encode(name, forKey: "name")
//    aCoder.encode(email, forKey: "email")
//    aCoder.encode(wakeupTime, forKey: "wakeupTime")
//    aCoder.encode(sleepingTime, forKey: "sleepingTime")
//    aCoder.encode(profile, forKey: "profile")
//    aCoder.encode(updatedAt, forKey: "updatedAt")
//    aCoder.encode(createdAt, forKey: "createdAt")
//    aCoder.encode(id, forKey: "id")
//    aCoder.encode(dob, forKey: "dob")
//    aCoder.encode(zip, forKey: "zip")
//    aCoder.encode(lastName, forKey: "lastName")
//    aCoder.encode(personaName, forKey: "personaName")
//    aCoder.encode(phoneNumber, forKey: "phoneNumber")
//
//}
//
//
//required convenience init?(coder aDecoder: NSCoder) {
//    let name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
//    let email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
//    let wakeupTime = aDecoder.decodeObject(forKey: "wakeupTime") as? String ?? ""
//    let sleepingTime = aDecoder.decodeObject(forKey: "sleepingTime") as? String ?? ""
//    let profile = aDecoder.decodeObject(forKey: "profile") as? String ?? ""
//    let updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String ?? ""
//    let createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String ?? ""
//    let id = aDecoder.decodeObject(forKey: "id") as? Int ?? -1
//    let dob = aDecoder.decodeObject(forKey: "dob") as? String ?? ""
//    let zip = aDecoder.decodeObject(forKey: "zip") as? String ?? ""
//    let lastName = aDecoder.decodeObject(forKey: "lastName") as? String ?? ""
//    let personaName = aDecoder.decodeObject(forKey: "personaName") as? String ?? ""
//    let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String ?? ""
//
//
//
//    self.init(name: name, email: email, wakeupTime: wakeupTime, sleepingTime: sleepingTime, profile: profile, updatedAt: updatedAt, createdAt: createdAt,id: id, dob:dob,zip:zip,lastName:lastName,personaName:personaName,phoneNumber:phoneNumber)
//    }
//}


func callOnThread(thread:DispatchQoS.QoSClass,completion:@escaping()->()){
    DispatchQueue.global(qos: thread).async {
        completion()
    }
}

func callOnMain(completion:@escaping()->()){
    DispatchQueue.main.async {
        completion()
    }
}
