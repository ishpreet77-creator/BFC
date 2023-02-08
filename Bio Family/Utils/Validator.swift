//
//  Validator.swift
//  Coravida
//
//  Created by Sachtech on 09/04/19.
//  Copyright © 2019 Chanpreet Singh. All rights reserved.
//

import Foundation

extension String{

    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
//    var isValidPassword: Bool {
////        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
////        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
//        return self.count > 5
//    }
    
    var isAlphanumeric: Bool {
        return range(of: "[^a-zA-Z0-9._]", options: .regularExpression) == nil
    }

    // verify Valid PhoneNumber or Not
    func isValidPhone() -> Bool {

      let regex = try! NSRegularExpression(pattern: "^[0-9]\\d{9}$", options: .caseInsensitive)
      let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
      print("Mobile validation \(valid)")
        return valid
    }
}

protocol Validator {
    func isValid() -> Bool
    func errorReason() -> (String,ValidatorKeys)
}

enum ValidatorKeys {
    case kEmail
    case kPassword
    case kFirstName
    case kLastName
    case kUnknown
}
