import Foundation
import UIKit
import Toast_Swift
import SVProgressHUD
import Lottie
import Combine
import StoreKit
//import FirebaseAuth
//import KYDrawerController

class BaseViewController: UIViewController {
    
    //MARK: Userdefined Variables
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let userDefaults = UserDefaults.standard
    var theme = AppPreferences.share.get(forkey: .theme) as? UIColor ?? UIColor.blue
    var isFromPopUp:Bool = false
    var typee:UIImagePickerController.SourceType = .camera
    var subscriptions = Set<AnyCancellable>()
    
    var updateIsAvailable = false
    private var  ImageView : LottieAnimationView? = nil
    //    var progressView = CustomProgressView()
    //    let auth = Auth.auth()
    //    var firestoreRef = Firestore.firestore()
    
    //MARK: Lifecycles
    override func viewDidLoad() {
//        if updateIsAvailable {
//               showUpdateAlert()
//        }else{
//            print("no update  @@@@@@@@@@++++++++=======>")
//
//        }
        
        ConfigUI()
        hideNavBar()
        setProgressHUD()
        Networklost()
        view.addSubview(ImageView!)
    }
    
    override func viewDidLayoutSubviews() {
        ImageView!.frame = CGRect(x: 0,
                                 y: 0,
                                  width: self.view.frame.width,
                                 height: self.view.frame.height)
    }
      
    func ConfigUI(){
        ImageView = .init(name: "54633-no-internet-access-animation.json")
           ImageView!.contentMode = .scaleAspectFit
           ImageView!.loopMode = .loop
           ImageView!.animationSpeed = 0.5
           ImageView?.backgroundColor = UIColor(named: "Color") ?? .black
           ImageView?.layer.zPosition = 999999999999999999
           view.backgroundColor = .white
           ImageView!.play()
           self.ImageView?.isHidden = true
    }
    func Networklost(){
        Reachability.shared.publisher
                   .sink { path in
                       if path.isReachable {
                           
                           print("isOn")
                           self.ImageView?.isHidden = true
                          
                       } else {
                           print("isOff")
                           self.ImageView?.isHidden = false
                         
                       }
                   }
                   .store(in: &subscriptions)
    }
    
    
    func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    func hideNavBar(){
        navigationController?.navigationBar.isHidden = true
    }
    
    func showNavBar(backgroundColor: UIColor,textColor:UIColor,titleVc:String? = nil){
       
        setNavBar(backgroundColor: backgroundColor, textColor: textColor,title: titleVc)
    
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    func setProgressHUD(){
    SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: self.view.frame.midX, vertical: self.view.frame.midY))

    SVProgressHUD.setRingThickness(3)
    SVProgressHUD.setDefaultStyle(.custom)
    SVProgressHUD.setDefaultMaskType(.custom)
    SVProgressHUD.setForegroundColor(UIColor(named: "themeDarkGreen") ?? UIColor.green) //Ring Color
    SVProgressHUD.setBackgroundColor(UIColor.white) //HUD Color
    SVProgressHUD.setBackgroundLayerColor(UIColor.black.withAlphaComponent(0.4))//Background Color
    }
    func setRightButton(image: UIImage,image2:UIImage? = nil,clearButton:Bool? = nil){
//        rightNavigatonButton(image: image)
//        self.ApiHit = ApiHit
        rightNavigatonButton(image: image, image2: image2, clearButton: clearButton)
    }
    func setLeftButton(image: UIImage,isFromPopUp:Bool? = nil){
        if let popUp = isFromPopUp {
            self.isFromPopUp = popUp
        }
       
        leftNavigatonButton(image: image)
    }
 
    
    func setTransparentNavBar(){
        navigationController?.transparentNavBar()
    }
    
    func setNavBar(backgroundColor:UIColor,textColor:UIColor,title:String? = nil){
        let lblText = UILabel()
        lblText.font = UIFont(name: "AvenirNextLTPro-Bold", size: 18.0)
        lblText.textColor = textColor
        lblText.text = title ??  self.title
        navigationItem.titleView = lblText
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.isHidden = false
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance =  self.navigationController?.navigationBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func leftNavigatonButton(image:UIImage){
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 0
        let btnBack = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        btnBack.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        btnBack.contentMode = .scaleAspectFit
        btnBack.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        btnBack.contentHorizontalAlignment = .leading
        btnBack.addTarget(self, action: #selector(popVC(_:)), for: .touchUpInside)
        btnBack.setImage(image, for: .normal)
        let barButton = UIBarButtonItem(customView: btnBack)

        navigationItem.leftBarButtonItems = [space,barButton]
    }
    func rightNavigatonButton(image:UIImage,image2:UIImage? = nil,clearButton:Bool?){
        
        
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 0
        let btnBack = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height:0))
        if (clearButton == nil){
            btnBack.heightAnchor.constraint(equalToConstant: 38.0).isActive = true
            btnBack.widthAnchor.constraint(equalToConstant: 38.0).isActive = true
            btnBack.contentMode = .scaleAspectFit
            btnBack.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            btnBack.contentHorizontalAlignment = .leading
            btnBack.addTarget(self, action: #selector(openWaterScreen(_:)), for: .touchUpInside)
            btnBack.setImage(image, for: .normal)
         
        }
        else{
            btnBack.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
            btnBack.widthAnchor.constraint(equalToConstant: 36.0).isActive = true
            btnBack.contentMode = .scaleAspectFit
            btnBack.imageEdgeInsets = UIEdgeInsets(top: 6.2, left: 12, bottom:6.2, right: 0)
            btnBack.contentHorizontalAlignment = .leading
            
            btnBack.addTarget(self, action: #selector(notifyClear(_:)), for: .touchUpInside)
            btnBack.setImage(image, for: .normal)
        }
        
      
        let barButton = UIBarButtonItem(customView: btnBack)
        var searchButton:UIBarButtonItem
        if (clearButton == nil){
           searchButton = UIBarButtonItem(image: image,  style: .plain, target: self, action: #selector(openWaterScreen(sender:)))
         
        }
        else{
             searchButton = UIBarButtonItem(image: image,  style: .plain, target: self, action: #selector(notifyClear(_:)))
        }
       
        
        if image2 == nil{
            navigationItem.rightBarButtonItems = [space,barButton]
        }
        else{
            let btnBack2 = UIButton(frame: CGRect(x: 0, y: 50, width: 0, height:0))
            btnBack2.heightAnchor.constraint(equalToConstant: 38.0).isActive = true
            btnBack2.widthAnchor.constraint(equalToConstant: 38.0).isActive = true
            btnBack2.contentMode = .scaleAspectFill
            btnBack2.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            btnBack2.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            btnBack2.contentHorizontalAlignment = .leading
            btnBack2.addTarget(self, action: #selector(openLemonScreen(_:)), for: .touchUpInside)
            btnBack2.setImage(image2, for: .normal)
            
            let barButton2 = UIBarButtonItem(customView: btnBack2)
//            navigationItem.rightBarButtonItems = [barButton,barButton2]
            let searchButton2 = UIBarButtonItem(image: image2!,  style: .plain, target: self, action: #selector(openLemonScreen(sender:)))
                                               
            navigationItem.rightBarButtonItems = [searchButton,searchButton2]
        }
        
    }
    func rightNavigatonButton2(image:UIImage){
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 0
        let btnBack = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height:0))
        btnBack.heightAnchor.constraint(equalToConstant: 38.0).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 38.0).isActive = true
        btnBack.contentMode = .scaleAspectFit
        btnBack.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        btnBack.contentHorizontalAlignment = .leading
        btnBack.addTarget(self, action: #selector(openLemonScreen(_:)), for: .touchUpInside)
        btnBack.setImage(image, for: .normal)
        let barButton2 = UIBarButtonItem(customView: btnBack)
//        return barButton
        navigationItem.rightBarButtonItems = [barButton2,space]
    }
    
    @objc func popVC(_ barButton:UIBarButtonItem){
        if self.isFromPopUp{
            self.isFromPopUp = false
            let storyboard = UIStoryboard(name: "TabBarStoryboard", bundle: nil)
            if let window = UIApplication.shared.windows.first{
                if let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as? UIViewController{
                    window.rootViewController = vc
                }
            }
        }
        else{
            self.navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
        
    }

    @objc func notifyClear(_ barButton:UIBarButtonItem){
//        self.ApiHit?.readAllNotification()
      print("clear All")
//        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func openLemonScreen(_ barButton:UIBarButtonItem){
    
//        let _: DrinkWaterCupVC = self.customPresent(storyBoardIdentifier: "Main", animate: true) { vc in
//            vc.modalTransitionStyle = .coverVertical
//            vc.modalPresentationStyle = .overCurrentContext
//        }
//        dismiss(animated: true, completion: nil)
        
    }
    @objc func openLemonScreen(sender: AnyObject){
//        let _: DrinkWaterCupVC = self.customPresent(storyBoardIdentifier: "Main", animate: true) { vc in
//            vc.modalTransitionStyle = .coverVertical
//            vc.modalPresentationStyle = .overCurrentContext
//        }
      }
    @objc func openWaterScreen(sender: AnyObject){
//        Constants.RxApiEnds.isWaterNotification = "no"
//        let _: MyDailyHydrationVC = self.open("TabBarStoryboard", true) { vc in
////            vc.isFromHome = false
//        }
//        dismiss(animated: true, completion: nil)
      }
    @objc func openWaterScreen(_ barButton:UIBarButtonItem){
//        Constants.RxApiEnds.isWaterNotification = "no"
//        let _: MyDailyHydrationVC = self.open("TabBarStoryboard", true) { vc in
////            vc.isFromHome = false
//        }
//        dismiss(animated: true, completion: nil)
    }
    
    //    @objc func openDrawer(_ barButton: UIBarButtonItem){
    //        if let drawer = self.parent?.parent as? KYDrawerController{
    //            drawer.setDrawerState(.opened, animated: true)
    //        }
    //    }
    
    func toast(_ message:String){
        self.view.makeToast(message, duration: 3.0, position: .top)
    }
    
    
    func randomString() -> String {
        let length = 24
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func getJoinedString(arr: [String])-> String{
        if arr.count == 1{
            return arr[0]
        }else if arr.count == 2{
            return arr.joined(separator: "and")
        }else if arr.count > 2{
            let lastElement = arr.last ?? ""
            var arrStr = arr
            arrStr.removeLast()
            let str = arrStr.joined(separator: ", ")
            let arr = [str, lastElement]
            return arr.joined(separator: " and ")
        }else{
            return ""
        }
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: Constants.AppStrings.appName, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Custom Progress Setup
    func showProgress(_ text: String = "Loading"){
        callOnMain {
            
            SVProgressHUD.show()
            UIApplication.shared.beginIgnoringInteractionEvents()
//                        let view = self.delegate.window?.rootViewController?.view ?? self.view
//                        self.progressView = CustomProgressView(frame: view?.frame ?? self.view.frame)
//                        self.progressView.setLoader(text)
//                        if !(view?.subviews.contains(self.progressView) ?? false){
//                            view?.addSubview(self.progressView)}
        }
    }
    
    func hideProgress(){
        callOnMain {
            SVProgressHUD.dismiss()
            UIApplication.shared.endIgnoringInteractionEvents()
            //             self.progressView.removeFromSuperview()
        }
    }
    
    //MARK: SHOW VERSIONALERT
    

    
 
    //MARK: check update
    
    
    

    
//    func checkForUpdates(){
//        let appId = "1666464256"
//        let appStoreURL = URL(string: "https://itunes.apple.com/app/id\(appId)?mt=8&action=write-review")!
//
//        let storeViewController = SKStoreProductViewController()
//        storeViewController.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: appId]) { (success, error) in
//            if success {
//                self.present(storeViewController, animated: true, completion: nil)
//            } else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//            }
//        }
//
//
//        let bundleIdentifier = Bundle.main.bundleIdentifier!
//        let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleIdentifier)")!
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let data = data else {
//                print("Error: No data received")
//                return
//            }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                let results = json["results"] as! [[String: Any]]
//                let currentVersion = results[0]["version"] as! String
//
//                // Compare current version with installed version
//                let installedVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
//
//                if currentVersion != installedVersion {
//                    // Show update notification
//                    let alert = UIAlertController(title: "Update Available", message: "A new version of the app is available. Do you want to update now?", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { _ in
//                        // Open App Store page
//                        self.present(storeViewController, animated: true, completion: nil)
//                    }))
//
//                }
//            } catch {
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//
//        task.resume()
//
//    }
    
    
}

extension BaseViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func presentPickerSelector(view:UICollectionView){
        
        let picker = UIImagePickerController()
        picker.delegate = self
//        picker.allowsEditing = true
        
        let alert = UIAlertController(title: "Select image from", message: nil, preferredStyle:    UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (handler) in
            picker.allowsEditing = false
            picker.sourceType = .camera
            picker.sourceType = UIImagePickerController.SourceType.camera
            
            picker.showsCameraControls = true
           
            picker.cameraCaptureMode = .photo
            self.typee = .camera
            self.present(picker, animated: true, completion: nil)
            
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (handler) in
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            self.typee = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (handler) in
            
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = view
            presenter.sourceRect = view.bounds
        }
        present(alert, animated: true)
    }
}


//extension UIImagePickerController {
//
//    open override var childForStatusBarHidden: UIViewController? {
//        return nil
//    }
//
//    open override var prefersStatusBarHidden: Bool {
//        return true
//    }
//
//    open override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        fixCannotMoveEditingBox()
//    }
//
//    func fixCannotMoveEditingBox() {
//            if let cropView = cropView,
//               let scrollView = scrollView,
//               scrollView.contentOffset.y == 0 {
//
//                var top: CGFloat = 0.0
//                if #available(iOS 11.0, *) {
//                    top = cropView.frame.minY + self.view.safeAreaInsets.top
//                } else {
//                    // Fallback on earlier versions
//                    top = cropView.frame.minY
//                }
//                let bottom = scrollView.frame.height - cropView.frame.height - top
//                scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
//
//                var offset: CGFloat = 0
//                if scrollView.contentSize.height > scrollView.contentSize.width {
//                    offset = 0.5 * (scrollView.contentSize.height - scrollView.contentSize.width)
//                }
//                scrollView.contentOffset = CGPoint(x: 0, y: -top + offset)
//            }
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
//                self?.fixCannotMoveEditingBox()
//            }
//        }
//
//        var cropView: UIView? {
//            return findCropView(from: self.view)
//        }
//
//        var scrollView: UIScrollView? {
//            return findScrollView(from: self.view)
//        }
//
//        func findCropView(from view: UIView) -> UIView? {
//            let width = UIScreen.main.bounds.width
//            let size = view.bounds.size
//            if width == size.height, width == size.height {
//                return view
//            }
//            for view in view.subviews {
//                if let cropView = findCropView(from: view) {
//                    return cropView
//                }
//            }
//            return nil
//        }
//
//        func findScrollView(from view: UIView) -> UIScrollView? {
//            if let scrollView = view as? UIScrollView {
//                return scrollView
//            }
//            for view in view.subviews {
//                if let scrollView = findScrollView(from: view) {
//                    return scrollView
//                }
//            }
//            return nil
//        }
//}
