//
//  AppRequest.swift
//  Bio Family
//
//  Created by John on 04/01/23.
//

import Foundation
import UIKit
struct AppRequest : JsonSerilizer {
    //var insuranceName: String = ""
    var reasonOfAppointment:String = ""
    var id : String = ""
    var type : String = ""
    func serilize() -> Dictionary<String, Any> {
        return [
           // "insurance_name": insuranceName,
            "reason_of_appointment": reasonOfAppointment,
            "appointment_id": id,
            "type":type
        ]
    }
}
struct AppReviewBioFamily : JsonSerilizer {
    //var insuranceName: String = ""
    var review:String = ""
    var message : String = ""

    func serilize() -> Dictionary<String, Any> {
        return [
           // "insurance_name": insuranceName,
            "rating": review,
            "message": message
        ]
    }
}
struct AppContactUs : JsonSerilizer {
    //var insuranceName: String = ""
    var firstname:String = ""
    var lastname : String = ""
    var email:String = ""
    var message : String = ""
    func serilize() -> Dictionary<String, Any> {
        return [
           // "insurance_name": insuranceName,
            "first_name": firstname,
            "last_name": lastname,
            "email": email,
            "message": message
        ]
    }
}
struct AppPrescripition : JsonSerilizer {
    //var insuranceName: String = ""
    var message : String = ""

    func serilize() -> Dictionary<String, Any> {
        return [
          
            "prescription_box": message
        ]
    }
}

