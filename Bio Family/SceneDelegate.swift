//
//  SceneDelegate.swift
//  Bio Family
//
//  Created by John on 24/12/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        languageAlert()
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    
    func languageAlert(){
        let alertmessage = UIAlertController(title: "Biofamily", message: "App language can be set as a system language, If you can change language please Signup or Login then go to setting language  and chane language\n Thankyou", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        alertmessage.addAction(actionOk)
//        present(alertmessage, animated: true, completion: nil)
        window?.rootViewController?.present(alertmessage, animated: true, completion: nil)
        
    }
    func sceneDidDisconnect(_ scene: UIScene) {
    
        
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
     
        print("Become Avtive")
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
//         uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
//        print(AppDefaults.goneForReview)
        AppUpdater.shared.showUpdate(withConfirmation: false)
        if AppDefaults.goneForReview {
            HotspotHelper().connectToWifi(wifiName: AppDefaults.wifiName, wifiPassword: AppDefaults.wifiPassword, wep: false) { error in
             
                DispatchQueue.main.async {
                    let story = UIStoryboard(name: Constants.AppStatic.storyBoard, bundle:nil)
                    let vc = story.instantiateViewController(withIdentifier: Constants.AppStatic.drawerNavigation) as! UINavigationController

                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }
        }
        else if AppDefaults.FromReview{
            DispatchQueue.main.async {
                let story = UIStoryboard(name: Constants.AppStatic.storyBoard, bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: Constants.AppStatic.drawerNavigation) as! UINavigationController

                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        }
        
        print("Become foreground")
        
      
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
//        uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}

