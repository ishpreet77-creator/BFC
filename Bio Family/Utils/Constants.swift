//
//  Constants.swift
//  BestKetone
//
//  Created by John on 01/04/21.
//

import Foundation
import UIKit
import AVKit
struct Constants{
    
    //MARK:- API End Points00
//http://solidappmaker.ml/projects/php/healthy/healthy-slate/public/assets/img/theme/logo.png
//http://solidappmaker.ml/projects/php/healthy/healthy-slate/public/storage/daily_rainbow/MaskGroup40.png
//http://solidappmaker.ml/projects/php/healthy/healthy-slate/public/assets/images/temporary/whatOverWhyBig/Image%2093.png
    struct RxApiEnds{
        static let zone:String = TimeZone.current.identifier
//        static let baseUrl: String = "http://solidappmaker.ml/projects/php/healthy/healthy-slate/public/"
    
        static let baseUrl: String = "https://biofamily.solidappmaker.ml/api/v1/"
//    https://biofamily.solidappmaker.ml/api/v1/
//        static let baseUrl: String = "https://api.bfcapp.com/api/v1/"
    
//        static let baseUrlImage: String = "http://solidappmaker.ml/projects/php/healthy/healthy-slate/public/assets/images/temporary/"
//        static let baseUrlImage: String = "http://solidappmaker.ml/projects/php/healthy/healthy-slate/public/assets/images/temporary/"
        
        static let baseUrlImage: String = "http://3.221.218.185/public/assets/images/temporary/"
    
        static let emailExistence = "user/check_for_email_existance"
        static let signUp = "user/register"
        static let login = "user/login"
        static let socialLogin = "user/social_login"
        static let logout = "user/logout"
        static let forget = "user/forget_password"
        static let verify = "user/verify_otp"
        static let resetPass = "user/reset_password"
        static let refreshToken = "refresh"
        static let changePassword = "user/change_password"
        static let editProfile = "user/edit_profile"
        static let appointment = "appointment/create_appointment"
        static let getAllApointment = "appointment/get_all_appointment_user"
        static let reScheduleAppoint = "appointment/send_sms_email"
        static let cancelAppoint = "appointment/cancel_appointment"
        static let historyAppointment = "appointment/appintment_history"
        static let reviewBioFamily = "user/rate_biofamily"
        static let contactUs = "user/contact_us"
        static let notificationBioFam = "user/get_all_notifications"
        static let prescripition = "appointment/add_prescription"
        static let delete = "user/delete_user_account"
        static let resend = "user/resend_otp"
        static let notification = "user/enable_disable_notification_by_user"
        
        
      
       
        static let fcmServerKey = "AAAAqv5kZnE:APA91bECrCCGkc0vY5gNEPxc9jQWpwb73Bmw0jNsNUrzfv9as5rm0YMjycSvNEPo55bvDzpeFOgN6VmprBQVMx48bvL2SI9KBLL0SAsVPq3xZcxeFqqp_3N_awsjWel4v38p0rs9jfYQ"
        
        static let getCategory = "api/items_list"
        static let addReminder = "api/user_reminder_add"
        static let getActivity = "api/completed_activity_list"
        static let getCalendarEvents = "api/food_calendar_data"
        static let completeActivity = "api/user_activity_complete"
        static let addWater = "api/user_water_glass_add"
        static let getListOFWater = "api/user_drink_water_glass"
        static let getSetting = "api/user_settings"
        static let saveSetting = "api/user_settings_update"
        static let updateUser = "api/user_update_detail"
        static let saveUserThought = "api/save_user_thought"
        static let foodAdd = "api/user_food_add"
        static let addReminders = "api/daily_motivation_reminder_setting"
        static let addNotificationResponse = "api/add_lemon_morning_evening_text"
        static let subItemData = "api/items_list_data"
        static let deleteAcct = "api/user_del_account"
        static let addFeedBack = "api/feedbackAdd"
        static let loginUser = "api/login"
        static let sendOtp = "api/forgotPassword"
        static let verifyOtp = "api/forgotOtpMatch"
        static let updatePass = "api/forgotPasswordChange"
        static let getGraph = "api/activityGraph"
        static let addBook = "api/addBooks"
        static let deleteBook = "api/deleteBook"
        static let notifyEveryday = "api/motivate_me_every_day"
        static var googleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\("123%20main%20street")&key=AIzaSyA8BbLiH2vnQ4dvm9ygAgED1KW2tCYnYMo"
       // static let refreshToken = ""
        static let getFoodData = "api/single_food_calendar_date_data"
        static var pdfUrl = ""
        static var isWaterNotification = ""
        static var addMorEveData = "api/user_add_mood"
        static var updateFcmToken = "api/update_fcm_token"
        static var randomMood = "api/get_random_item_data_by_mood"
        static var getSuppliments = "api/get_user_supplement_list"
        static var addBookTime = "api/user_reading_record"
        static var getBookTime = "api/user_single_book_activity_detail"
        static var getNotification = "api/get_notifications"
        static var notifyRead = "api/update_notification_read"
        static var deleteWaterGlass = "api/delete_water_glass"
        static var readAll = "api/set_all_notification_read"
        static var getNotificationCount = "api/unreadNotificationCount"
        static var getOverallCount = "api/activityCompletedBadge"
    }
    
    
    
    struct Localicable{
      
        static let enterFirstName = NSLocalizedString("Please enter First Name", comment: "")
        static let enterLastname = NSLocalizedString("Please enter Last Name", comment: "")
        
        static let enterEmail = NSLocalizedString("Please enter email", comment: "")
        static let enterVaildEmail = NSLocalizedString("Please enter Valid email", comment: "")
        static let enterDOB = NSLocalizedString("Please enter date of birth", comment: "")
        static let enterPhoneNO = NSLocalizedString("Please enter Phone Number", comment: "")
        static let enterPassword = NSLocalizedString("Please enter Password", comment: "")
        static let enterConfirmPassword = NSLocalizedString("Please enter Confirm Password", comment: "")
        static let eterVaildPassword = NSLocalizedString("Please enter Valid Password", comment: "")
        static let passwordNotMatch = NSLocalizedString("Password Does not match with confirm password", comment: "")
        static let enterInsurranceName = NSLocalizedString("Please enter insurrance name", comment: "")
        static let checkPrivacy = NSLocalizedString("Please Check the Privacy Policy and Terms and Condition", comment: "")
        static let vaildEmailId = NSLocalizedString("Please enter valid email id", comment: "")
        static let LblOtpTitle = NSLocalizedString("We have sent a 4-digit verification code on \n your email id", comment: "")
        static let otpToast = NSLocalizedString("Otp sent to your mail", comment: "")
        static let worngOtp = NSLocalizedString("Wrong otp", comment: "")
        static let watchVideos = NSLocalizedString("Watch\nEducational Videos \n", comment: "")
        static let readMagazine = NSLocalizedString("Read\nHealth tips \n Magazine", comment: "")
        static let submitReview = NSLocalizedString("Submit Your Review", comment: "")
        static let deleteAccount = NSLocalizedString("Are you sure yow want to delete your Account.", comment: "")
        static let Ok = NSLocalizedString("Ok", comment: "")
        static let Cancel = NSLocalizedString("Cancel", comment: "")
        static let scheduleAppoint = NSLocalizedString("Schedule Appointment", comment: "")
        static let Send = NSLocalizedString("Send", comment: "")
        static let reasonAppoint = NSLocalizedString("Reason for Appointment", comment: "")
        static let cancelAppoint = NSLocalizedString("Cancel Appointment", comment: "")
        static let reasonCancel = NSLocalizedString("Reason for Cancel", comment: "")
        static let rescheduleAppoint = NSLocalizedString("Reschedule Appointment", comment: "")
       
        static let Reschedule = NSLocalizedString("Reschedule", comment: "")
        static let reasonReschedule = NSLocalizedString("Reason for Reschedule", comment: "")
       
        static let confirmAppoint = NSLocalizedString("Confirm Appointment", comment: "")
       
        static let Confirm = NSLocalizedString("Confirm", comment: "")
       
        static let reasonConfirm = NSLocalizedString("Reason for Confirm", comment: "")
       
        static let reasonTextViewEmpty = NSLocalizedString("please enter reason for appointment", comment: "")
       
        static let writeFeedback = NSLocalizedString("Write your feedback...", comment: "")
       
        static let typeMessage = NSLocalizedString("Type your Message...", comment: "")
        
        static let enterMessage = NSLocalizedString("Please enter Message", comment: "")
       
        static let New = NSLocalizedString("New", comment: "")
       
        static let refillPrescripition = NSLocalizedString("Refill prescriptions", comment: "")
       
        static let invaildStatus = NSLocalizedString("Invaild status", comment: "")
       
        static let enterWifiName = NSLocalizedString("Please enter WifiName", comment: "")
       
        static let checkTermsAndCondition = NSLocalizedString("Please Check the Terms and Condition", comment: "")
        static let requestNewAppoint = NSLocalizedString("Request New Appointment", comment: "")
        
        static let cancelExistingAppoint = NSLocalizedString("Cancel Existing Appointment", comment: "")
        
        static let enterPrescripition = NSLocalizedString("Plese enter Prescripition", comment: "")
        
        static let settingLanguageTitle = NSLocalizedString("App restart required", comment: "")
        static let enterLanguageMessage = NSLocalizedString("In order to change the language, the App needs to be restarted", comment: "")
        
        static let video = NSLocalizedString("Watch Educational Videos", comment: "")
        static let home = NSLocalizedString("Home", comment: "")
        static let profile = NSLocalizedString("My Profile", comment: "")
        static let appointment = NSLocalizedString("Appointments", comment: "")
        static let magzine = NSLocalizedString("Read Health Tips Magazine", comment: "")
        static let setting = NSLocalizedString("Settings", comment: "")
        
        static let history = NSLocalizedString("History", comment: "")
        static let enterOldPassword = NSLocalizedString("Please enter old password", comment: "")
        static let enterReview = NSLocalizedString("Please enter Review", comment: "")
        static let joinFreeWifi = NSLocalizedString("Join Free Wifi Now", comment: "")
        
    }
    
    
    
    
    
    struct NotifNames{
        static let refreshTokenExpire: String = "refreshTokenExpire"
    }
    
    struct PrefKeys {
        public static let kFCMToken = "fcm_token"
        public static let kBundleId = "com.sachtech.BestKetone"
        public static let kUserLogin = "isUserLogin"
        public static let kErrorDomain:String = "BestKetone"
        public static let kErrorCode:Int = 100
        public static let kRememberMe = "rememberMe"
        public static let kUserData = "userData"
        public static let kFirstRun = "isFirstRun"
        public static let kEmail = "app_email"
        public static let kPassword = "app_pass"
        public static let kProfilePicture = "profile_picture"
    }
    
    struct AppStrings{
        static let appName: String = "Bio Family"

    }
    
    struct AppStatic{
        static let appName: String = "Bio Family"
        static let storyBoard: String = "Main"
        
        static let mainNavigationController: String = "mainNavigation"
        static let appointmentNavigationController: String = "navTabAppointment"
        static let homeNavigationController: String = "navTabHome"
        static let videoNavigationController: String = "navTabVideos"
        static let drawerNavigation: String = "drawerNavigation"
        
        //Drawer
        static let video: String = "Watch Educational Videos"
        static let home: String = "Home"
        static let profile: String = "My Profile"
        static let appointment: String = "Appointments"
        static let magzine: String = "Read Health Tips Magazine"
        static let setting: String = "Settings"
        static let history: String = "History"
        static let historyVC: String = "HistoryVC"
        static let notificationVC: String = "NotificationVC"
        static let notificationVC2: String = "NotificationVC2"        
//        static let videoNavigationController: String = "navTabVideos"
        
        static let dateArr = Array(01...31).map{String($0)}.map{ (a) -> String in
            if a.count == 1{
                return "0\(String(a))"
            }
            else{
               return String(a)
            }
            }
        
        static let arrayYear = Array((Calendar.current.component(.year, from: Date()) - 100)...Calendar.current.component(.year, from: Date())).map{String($0)}.reversed().map{$0}
        
        static let arrayMonth = ["Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Nov","Dec"]
        static let insurance = ["AETNA"
                                ,"AHCCCS"
                                ,"AMERIBEN"
                                ,"ARIZONA FOUNDATION"
                                ,"BLUE CROSS BLUE SHIELD"
                                ,"CHAMPUS"
                                ,"CIGNA"
                                ,"GEHA"
                                ,"HEALTH NET"
                                ,"HUMANA"
                                ,"MAIL HANDLERS"
                                ,"MEDICARE"
                                ,"MERITAIN"
                                ,"PINNACLE"
                                ,"PROFESSIONAL BENEFITS ADMINISTRATORS"
                                ,"SUMMIT"
                                ,"SW ADMINISTRATORS"
                                ,"TRICARE"
                                ,"UABT"
                                ,"UMR"
                                ,"UNITED HEALTHCARE"
                                ,"WESTERN GROWERS"
                                ,"WORKERS COMPENSATION"
                                ," Others"]
    }
    
    //
    //
//
//
    struct AppColors{
        
        static let appWhite: UIColor = UIColor(named: "white") ?? .white
        static let applightBlue: UIColor = UIColor(named: "lightBlue") ?? .white
        static let appBlue: UIColor = UIColor(named: "blue") ?? .white
        static let blackText: UIColor = UIColor(named: "blackText") ?? .black
        
        static let greenBox: UIColor = UIColor(named: "greenBox") ?? .white
        static let orangeBox: UIColor = UIColor(named: "orangeBox") ?? .white
        static let purpleBox: UIColor = UIColor(named: "purpleBox") ?? .white
        static let blueBox: UIColor = UIColor(named: "blueBox") ?? .white
        
        static let yellowBox: UIColor = UIColor(named: "yellowBox") ?? .white
        
        
        
        
    }
    
    struct AppAssets{
        static let eye: UIImage = UIImage(named: "eye") ?? UIImage()
        static let eyeClosed: UIImage = UIImage(named: "eyelock") ?? UIImage()
        static let selectedHome: UIImage = UIImage(named: "home") ?? UIImage()
        static let selectedAppointment: UIImage = UIImage(named: "appointmentBlue") ?? UIImage()
        static let selectedVideo: UIImage = UIImage(named: "videoBlue") ?? UIImage()
        static let unSelectedHome: UIImage = UIImage(named: "homeGray") ?? UIImage()
        static let unSelectedAppointment: UIImage = UIImage(named: "appointments") ?? UIImage()
        static let unSelectedVideo: UIImage = UIImage(named: "videos") ?? UIImage()
        static let youTube: UIImage = UIImage(named: "youtube") ?? UIImage()
        static let magzine: UIImage = UIImage(named: "magzine") ?? UIImage()
        static let events: UIImage = UIImage(named: "events") ?? UIImage()
       
        static let filledStar: UIImage = UIImage(named: "filledStar") ?? UIImage()
        static let videoWhite: UIImage = UIImage(named: "videoWhite") ?? UIImage()
        static let home: UIImage = UIImage(named: "homeDrawer") ?? UIImage()
        static let homeWhite: UIImage = UIImage(named: "homeWhite") ?? UIImage()
        
        static let profile: UIImage = UIImage(named: "profileBlue") ?? UIImage()
        static let profileWhite: UIImage = UIImage(named: "profileDrawer") ?? UIImage()
        
        static let historyDrawer: UIImage = UIImage(named: "historydrawer") ?? UIImage()
        static let whiteHistoryDrawer: UIImage = UIImage(named: "historyWhitewDrawer") ?? UIImage()
        
        static let appointmentWhite: UIImage = UIImage(named: "appointmentWhite") ?? UIImage()
        
        static let magzineDrawer: UIImage = UIImage(named: "magzineDrawer") ?? UIImage()
        static let magzineWhite: UIImage = UIImage(named: "magzineWhite") ?? UIImage()
        
        
        static let setting: UIImage = UIImage(named: "settingDrawer") ?? UIImage()
        static let settingWhite: UIImage = UIImage(named: "settingWhite") ?? UIImage()
        
        static let greenBackground: UIImage = UIImage(named: "greenBackGround") ?? UIImage()
        static let yellowBackground: UIImage = UIImage(named: "yellowBackground") ?? UIImage()
        static let pinkBackground: UIImage = UIImage(named: "pinkBackGround") ?? UIImage()
        static let blueBackground: UIImage = UIImage(named: "blueBackGround") ?? UIImage()
        static let starlogo: UIImage = UIImage(named: "star123") ?? UIImage()
        
        
    }
    
    struct SocialKeys{
        static let googleClientId: String = "500474613816-su5eh71glg16sh22vrg3pf7m2p9r5kb8.apps.googleusercontent.com"
        static let facebookAppId: String = "911521159422143"
        static let facebookAppSecret: String = "203e5f686de10597067628f0caacc9f9"
        static let termsConditionsURL: String = "https://www.websitepolicies.com/policies/view/nYFFO6st"
        static let privacyPolicyURL:String = "https://www.websitepolicies.com/policies/view/UPIAacG2"
    }
    
    struct CollectionCells{
        static let stripsCVC: String = "StripsCVC"
        static let DayIntervalCVC: String = "DayIntervalCVC"
    }
    struct TableCells{
        static let MovementPreviewTVC: String = "MovementPreviewTVC"
        static let MovementBeatTVC: String = "MovementBeatTVC"
        static let MyReadingsTVC: String = "MyReadingsTVC"
        static let BodyMagicTVC: String = "BodyMagicTVC"
    }
    
  
}

