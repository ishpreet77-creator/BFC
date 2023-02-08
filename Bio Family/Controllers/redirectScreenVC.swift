//
//  redirectScreenVC.swift
//  Bio Family
//
//  Created by John on 16/01/23.
//

import UIKit
import WebKit

class redirectScreenVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var topNavView: UIViewX!
    override func viewDidLoad() {
        super.viewDidLoad()
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionBack(_ sender: Any) {
       
    }

}
