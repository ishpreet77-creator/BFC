//
//  VideoVC.swift
//  Bio Family
//
//  Created by John on 26/12/22.
//

import UIKit
import KYDrawerController
import AVFoundation
import SDWebImage
import AVKit
import MediaPlayer
import SwiftSoup

class VideoVC: BaseViewController {
    //MARK: outlets
    @IBOutlet weak var topNavView: UIViewX!
    @IBOutlet weak var clnVideos: UICollectionView!
    //MARK: variable
    var videos:[String] = []
    var videoID:[String] = []
    var titles:[String] = []
    private let uploadVM = AuthVM.init(repository: AuthRepoImp.init(rxApi: RxApi()))
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        clnVideos.delegate = self
        clnVideos.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeScreen(_:)), name: NSNotification.Name(rawValue: "screenChange"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppDefaults.goneForReview = false
        AppDefaults.selectedDrawer = 3
        getdata()
//        uploadVM.refreshToken(RefreshToken(id: AppDefaults.userData.userId, oldToken: AppDefaults.userData.token))
    }
    //MARK: action
    @IBAction   func changeScreen(_ notification: NSNotification) {
        if let index = notification.userInfo?["index"] as? Int {
            if AppDefaults.selectedTab == 2{
                if index == 1{
                    let _: MyProfileVC = self.open()
                }
                else if index == 4{
                    let _: HealthTipsVC = self.open()
                }
                else if index == 5{
                    let _: HistoryVC = self.open()
                }
                else{
                    let _: SettingVC = self.open()
                }
            }
        }
    }
    //MARK: action open drawer
    @IBAction func actionOpenDrawer(_ sender: Any) {
        if let kyDrawer = self.parent?.parent?.parent as? KYDrawerController{
            if UIDevice.current.userInterfaceIdiom == .pad{
                kyDrawer.drawerWidth = 600
            }
            kyDrawer.setDrawerState(.opened, animated: true)
        }
    }
    
    @IBAction func actionNotification(_ sender: UITapGestureRecognizer) {
        let _:NotificationVC = self.open()
    }
    
    //MARK: api for educational video
    func getdata(){
        self.showProgress()
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        
        let urlString = NSString(format: "https://biofamilyclinic.com/wp-json/wp/v2/pages/1883")
        
        print("get wallet balance url string is \(urlString)")
        //let url = NSURL(string: urlString as String)
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.url = NSURL(string: NSString(format: "%@", urlString) as String) as URL?
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = session.dataTask(with: request as URLRequest) { data, resp, err in
            
            do {
                let getResponse = try JSONSerialization.jsonObject(with: data! , options: .allowFragments)
                print(getResponse)
                let resp = getResponse as? Dictionary<String,Any> ?? [:]
                let content = resp["content"] as? Dictionary<String,Any>
                var rendered = content?["rendered"] as? String ?? ""
                
                //MARK: get data from html
                
                do {
                    let doc: Document = try SwiftSoup.parse(rendered)
                    let pElements: Elements = try doc.select("h3")
                    for pElement in pElements {
                        let text: String = try pElement.text()
                        print(text)
                        self.titles.append(text)
                    } 
                } catch Exception.Error(_, let message) {
                    print(message)
                } catch {
                    print("error")
                }
                var string =  self.matches(for: "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)", in: rendered)
                self.videoID = string
                let mappedString = string.map{"https://www.youtube.com/watch?v=\($0)"}
                self.videos = mappedString
                
                rendered = rendered.components(separatedBy: .whitespacesAndNewlines).joined()
                DispatchQueue.main.async {
                    self.clnVideos.reloadData()
                    self.hideProgress()
                }
            }
            catch   {
                
            }
        }
        dataTask.resume()
    }
    //MARK: func get data from html
    
    func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    
}

//MARK: extension collection view
extension VideoVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clnVideos.dequeueReusableCell(withReuseIdentifier: "VideoCVC", for: indexPath) as! VideoCVC
        
        cell.thumbnail.layer.maskedCorners =  [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        cell.shadowBlack.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        cell.lbVideosTitle.text = titles[indexPath.row]
        cell.blueBox.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        cell.thumbnail.sd_setImage(with: URL(string: "https://img.youtube.com/vi/\(videoID[indexPath.row])/0.jpg"))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let _: Videos = self.customPresent{
            $0.modalPresentationStyle = .fullScreen
            $0.url = videos[indexPath.row]
        }
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = clnVideos.frame.width / 2.06
        
        return CGSize(width: width, height: UIScreen.screenHeight * 0.18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if  UIDevice.current.userInterfaceIdiom == .pad{
            return 18
        }
        else{
            return 14
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}

