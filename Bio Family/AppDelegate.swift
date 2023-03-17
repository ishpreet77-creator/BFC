//
//  AppDelegate.swift
//  Bio Family
//
//  Created by John on 24/12/22.
//
import Foundation
import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import GoogleSignIn
import FBSDKCoreKit
import FirebaseMessaging
import UserNotifications
import Firebase
import FirebaseCrashlytics
@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {
    var window: UIWindow?
    class func share() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    var systemLanguage = Bundle.main.preferredLocalizations.first as! NSString
    
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        AppUpdater.shared.showUpdate(withConfirmation: false)
        self.refreshResponse()
        //message
        print(systemLanguage)
        setDefaultLanguage()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    
        
        IQKeyboardManager.shared.enable = true
        AppDefaults.selectedDrawer = -1
        AppDefaults.selectedTab = 1
       

        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        if AppDefaults.tokenExpiry < Date(){
            if AppDefaults.userData.userId != ""{
                uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
            }
        }
//        let isFunctionCalled = UserDefaults.standard.bool(forKey: "functionCalled")
//        print("isFunctionCalled: \(isFunctionCalled)")
//
//        if !isFunctionCalled {
//            print("Calling languageAlert()")
//            // Call your function here
//            languageAlert()
//
//            // Set the UserDefaults value for the key "functionCalled" to true
//            UserDefaults.standard.set(true, forKey: "functionCalled")
//        } else {
//            print("languageAlert() was not called because isFunctionCalled is true")
//        }
        showLanguageAlertIfNeeded()
        return true
    }
 
    func setDefaultLanguage() {
        let lang = Locale.preferredLanguages.first ?? "en"
        UserDefaults.standard.set([lang], forKey: "systemLanuage")
        UserDefaults.standard.synchronize()
    }
//    func languageAlert(){
//        let alertmessage = UIAlertController(title: "Biofamily", message: "App language can be set as a system language, If you can change language please Signup or Login then go to setting language  and chane language\n Thankyou", preferredStyle: .alert)
//        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
//
//        }
//        alertmessage.addAction(actionOk)
////        present(alertmessage, animated: true, completion: nil)
//        window?.rootViewController?.present(alertmessage, animated: true, completion: nil)
//    }
//    func languageAlert() {
//        let alertmessage = UIAlertController(title: "Biofamily", message: "App language can be set as a system language, If you can change language please Signup or Login then go to setting language  and chane language\n Thankyou", preferredStyle: .alert)
//        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
//        }
//        alertmessage.addAction(actionOk)
//        if let topController = UIApplication.shared.keyWindow?.rootViewController {
//            topController.present(alertmessage, animated: true, completion: nil)
//        }
//    }
//    func languageAlert() {
//        let alertmessage = UIAlertController(title: "Biofamily", message: "App language can be set as a system language, If you can change language please Signup or Login then go to setting language  and chane language\n Thankyou", preferredStyle: .alert)
//        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
//        }
//        alertmessage.addAction(actionOk)
//        if let topController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController {
//            topController.present(alertmessage, animated: true, completion: nil)
//        }
//    }
    func showLanguageAlertIfNeeded() {
        let isFunctionCalled = UserDefaults.standard.bool(forKey: "functionCalled")
        guard !isFunctionCalled else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let alertmessage = UIAlertController(title: "Biofamily", message: "App language can be set as a system language, If you can change language please Signup/Login then go to setting language and change language.\nThank you.", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
                UserDefaults.standard.set(true, forKey: "functionCalled")
            }
            alertmessage.addAction(actionOk)
            guard let topController = UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.rootViewController else {
                return
            }
            topController.present(alertmessage, animated: true, completion: nil)
        }
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        //          return true
        if AppDefaults.loginBy == "google"{
            return  GIDSignIn.sharedInstance.handle(url)
        }
        else if AppDefaults.loginBy == "facebook"{
            return    ApplicationDelegate.shared.application(
                application,
                open: url,
                sourceApplication: sourceApplication,
                annotation: annotation
            )
        }
        else {
            return true
        }
        
        
        
    }
    
    
  
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("mkdjngvkjs")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Active")
    }
    func applicationWillResignActive(_ application: UIApplication) {
           print("fsfsggs")
       }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Enter background")
    }
    func applicationWillTerminate(_ application: UIApplication) {
        print("Terminate")
       
    }
    
    
    fileprivate func refreshResponse(){
        uploadVM.response.subscribe(onNext: { (response) in
            if response?.status == true{
                
            }else{
            }
        }, onError: { (error) in
        })
        .disposed(by: uploadVM.disposeBag)
    }
    
    
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print("token:\(token)")
            AppDefaults.fcmToken = token
            
        }
//        Messaging.messaging().token { token, error in
//          if let error = error {
//            print("Error fetching FCM registration token: \(error)")
//          } else if let token = token {
//            print("FCM registration token: \(token)")
////            self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
//          }
//        }
        
//        debugPrint("Firebase registration token: \(fcmToken ?? "")")
//        if fcmToken != "" {
//            Constant.deviceTokan = "\(fcmToken!)"
//
//        }else{
////            Constant.deviceTokan = "Simulater"
//            print("Simulater")
//        }
        
    }

    
     func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
      
    }
    

    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification
      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)
      // Print message ID.
      if let messageID = userInfo["gcm.message_id"] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//
//        completionHandler([.badge, .sound])
//
//        let userInfo:NSDictionary = notification.request.content.userInfo as NSDictionary
//        print(userInfo)
//        let dict:NSDictionary = userInfo["aps"] as! NSDictionary
//        let data:NSDictionary = dict["alert"] as! NSDictionary
//
//        print(dict)
////        UserDefaultsManager.saveNotification(AppNotification(title: (data["title"] as? String) ?? "", content: (data["body"] as? String) ?? ""))
//
//    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                  -> Void) {
      let userInfo = notification.request.content.userInfo
      print(userInfo)
       print("################# IN Foreground ##################")
      // Change this to your preferred presentation option
      //completionHandler([[.alert, .sound]])
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .badge, .sound])
        } else {
           
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo:NSDictionary = response.notification.request.content.userInfo as NSDictionary
        print(userInfo)
        
        let dict:NSDictionary = userInfo["aps"] as! NSDictionary
        let data:NSDictionary = dict["alert"] as! NSDictionary
      
        let body = data["body"] as! String
        let title = data["title"] as! String
        
        let fcmOption:NSDictionary = userInfo["fcm_options"] as! NSDictionary
        let imageurl = fcmOption["image"] as! String
        
        
        print(dict)
        print(data)
        
        let story = UIStoryboard(name: Constants.AppStatic.storyBoard, bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: Constants.AppStatic.notificationVC2) as! NotificationVC2
//        vc.isFromnotification = true
        vc.imageview =  imageurl
        vc.notifyBody = body
        vc.notifyTitle = title
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        
        print("################# IN Background ##################")
//        UserDefaultsManager.saveNotification(AppNotification(title: (data["title"] as? String) ?? "", content: (data["body"] as? String) ?? ""))
    }
    
}

//extension AppDelegate : MessagingDelegate {
//    // [START refresh_token]
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
////        messaging.token { token, _ in
////            guard let token = token else {
////                return
////            }
////            print("token:\(token)")
////        }
//        Messaging.messaging().token { token, error in
//          if let error = error {
//            print("Error fetching FCM registration token: \(error)")
//          } else if let token = token {
//            print("FCM registration token: \(token)")
////            self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
//          }
//        }
//
//    }
//
//
//     func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
//
//    }
//
//
//    // [START receive_message]
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//      // If you are receiving a notification message while your app is in the background,
//      // this callback will not be fired till the user taps on the notification launching the application.
//      // TODO: Handle data of notification
//      // With swizzling disabled you must let Messaging know about the message, for Analytics
//      // Messaging.messaging().appDidReceiveMessage(userInfo)
//      // Print message ID.
//      if let messageID = userInfo["gcm.message_id"] {
//        print("Message ID: \(messageID)")
//      }
//
//      // Print full message.
//      print(userInfo)
//
//      completionHandler(UIBackgroundFetchResult.newData)
//    }
//    // [END receive_message]
//
////    @available(iOS 10.0, *)
////    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
////
////
////        completionHandler([.badge, .sound])
////
////        let userInfo:NSDictionary = notification.request.content.userInfo as NSDictionary
////        print(userInfo)
////        let dict:NSDictionary = userInfo["aps"] as! NSDictionary
////        let data:NSDictionary = dict["alert"] as! NSDictionary
////
////        print(dict)
//////        UserDefaultsManager.saveNotification(AppNotification(title: (data["title"] as? String) ?? "", content: (data["body"] as? String) ?? ""))
////
////    }
//
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
//                                  -> Void) {
//      let userInfo = notification.request.content.userInfo
//      print(userInfo)
//       print("################# IN Foreground ##################")
//      // Change this to your preferred presentation option
//      //completionHandler([[.alert, .sound]])
//        if #available(iOS 14.0, *) {
//            completionHandler([.banner, .badge, .sound])
//        } else {
//
//        }
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo:NSDictionary = response.notification.request.content.userInfo as NSDictionary
//        print(userInfo)
//        let dict:NSDictionary = userInfo["aps"] as! NSDictionary
//        let data:NSDictionary = dict["alert"] as! NSDictionary
//
//        print(dict)
//        print(data)
//
//        print("################# IN Background ##################")
////        UserDefaultsManager.saveNotification(AppNotification(title: (data["title"] as? String) ?? "", content: (data["body"] as? String) ?? ""))
//    }
//
//}
