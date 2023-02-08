//
//  Videos.swift
//  Bio Family
//
//  Created by John on 05/01/23.
//

import UIKit
import WebKit
class Videos: BaseViewController, WKUIDelegate, WKNavigationDelegate {
    //MARK: outlets
    
    @IBOutlet weak var wevView: WKWebView!
    @IBOutlet weak var topNavView: UIViewX!
    
    //MARK: variable
    var url:String?
    
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wevView.uiDelegate = self
        wevView.navigationDelegate = self
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    override func viewWillAppear(_ animated: Bool) {
        if let url = self.url{
            self.showProgress()
            let url = URL(string: url)
            wevView.load(URLRequest(url: url!))
        }
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
    //MARK: actionBack
    @IBAction func actionBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        self.hideProgress()
    }
    
}
