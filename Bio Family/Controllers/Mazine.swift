//
//  Mazine.swift
//  Bio Family
//
//  Created by John on 10/01/23.
//

import UIKit
import WebKit

class Mazine: BaseViewController, WKUIDelegate, WKNavigationDelegate,UIDocumentInteractionControllerDelegate,URLSessionDownloadDelegate{
//class Mazine: BaseViewController, WKUIDelegate, WKNavigationDelegate {
   
    
    @IBOutlet weak var topNavView: UIViewX!
    
    @IBOutlet weak var webView: WKWebView!
//    let url = URL(string: "https://healthtipsmedia.com/app-magazine/")
    let url = URL(string: "https://healthtipsmedia.com/archive-edition/")

    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        topNavView.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        
        if let url =  url{
            //self.showProgress()
            
            webView.load(URLRequest(url: url))
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.hideProgress()
    }
    @IBAction func actionReadPdf(_ sender: Any) {
        
       
//        let _: PdfVC = self.open()
      
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        DispatchQueue.main.async {
            self.showProgress()
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
       // self.showProgress()
        if let url = navigationAction.request.url {


            print("fileDownload: check ::  \(url)")

            let extention = "\(url)".suffix(4)

            if extention == ".pdf" ||  extention == ".csv"{
                print("fileDownload: redirect to download events. \(extention)")
                DispatchQueue.main.async {
                    self.downloadPDF(tempUrl: "\(url)")
                }
                decisionHandler(.cancel)
                return
            }
//            else{
//                self.hideProgress()
//            }

        }

        decisionHandler(.allow)
    }

    func downloadPDF(tempUrl:String){
        print("fileDownload: downloadPDF")
        self.showProgress()
        guard let url = URL(string: tempUrl) else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
        //showHUD(isShowBackground: true); //show progress if you need
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        print("fileDownload: documentInteractionControllerViewControllerForPreview")
        return self
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        // create destination URL with the original pdf name
        print("fileDownload: urlSession")
        guard let url = downloadTask.originalRequest?.url else { return }
        print("fileDownload: urlSession \(url)")
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            myViewDocumentsmethod(PdfUrl:destinationURL)
            print("fileDownload: downloadLocation", destinationURL)
            DispatchQueue.main.async {
                print("Download Completed")
//                NBMaterialToast.showWithText(self.view, text: "Download Completed", duration: NBLunchDuration.long)
            }
        } catch let error {
            print("fileDownload: error \(error.localizedDescription)")
            self.hideProgress()
        }
       // dismissHUD(isAnimated: false); //dismiss progress
    }
    func myViewDocumentsmethod(PdfUrl:URL){
        print("fileDownload: myViewDocumentsmethod \(PdfUrl)")
        DispatchQueue.main.async {
            let controladorDoc = UIDocumentInteractionController(url: PdfUrl)
            self.hideProgress()
            controladorDoc.delegate = self
            controladorDoc.presentPreview(animated: true)
        }
    }

//
   
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.hideProgress()
        }
    }
 
}
