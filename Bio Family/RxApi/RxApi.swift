//
//  RxApi.swift
//  Coravidao
//
//  Created by Sachtech on 09/04/19.
//  Copyright © 2019 Chanpreet Singh. All rights reserved.
//
import Foundation
import RxAlamofire
import RxSwift
import Alamofire

class RxApi {
    
    private let url: String = Constants.RxApiEnds.baseUrl
    
    func get<T>(path: String, value: JsonSerilizer) -> Observable<T> where T:JsonDeserilizer{
//        if AppDefaults.tokenExpiry < Date() && AppDefaults.userLogged{
//            return refresh(.get, path, value: value)
//        }
//        else{
            return execute(method: .get, path: path, values: value.serilize())
//        }
    }
    
    func post<T>(path: String, value: JsonSerilizer) -> Observable<T> where T:JsonDeserilizer {
//        if AppDefaults.tokenExpiry < Date() && AppDefaults.userLogged{
//              return refresh(.post, path, value: value)
//          }
//          else{
              return execute(method: .post, path: path, values: value.serilize())
//          }
    }
    
    func put<T>(path: String, value: JsonSerilizer) -> Observable<T> where T:JsonDeserilizer {
//        if AppDefaults.tokenExpiry < Date() && AppDefaults.userLogged{
//              return refresh(.put, path, value: value)
//          }
//          else{
              return execute(method: .put, path: path, values: value.serilize())
          //}
    }
    
    func postUpload<T>(path: String, value: JsonSerilizer) -> Observable<T> where T:JsonDeserilizer {

            if value is FileSerilizer {
                
                let fullUrl = url + path
                
                return  startUploading(url: fullUrl, data: (value as! FileSerilizer).file(), values: value.serilize())
                    .map { (arg) -> T in
                        return self.populateData(arg as! (HTTPURLResponse, Any))
                }
            }else{
                return post(path: path, value: value)
            }
    }
    
    private func startUploading(url: String, data: (String,[Data]), values: Dictionary<String,Any>) -> Observable<Any> {
        let httpHeaders: HTTPHeaders = [HTTPHeader.authorization(bearerToken: AppDefaults.accessToken)]
        return  Observable.create{ (observer) -> Disposable in
            
            AF.upload(multipartFormData: { (multipartFormData) in
                for imgData in data.1{
                    multipartFormData.append(imgData, withName: data.0, fileName: "\(Date.timeStamp).png", mimeType: "image/jpeg")
                }
    
                for (key, value) in values {
                    multipartFormData.append((value as AnyObject).data!(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                
            },to: url, usingThreshold: UInt64.init(), method: .post, headers: httpHeaders)
                .uploadProgress(queue: .main, closure: { (progress) in
                    let myDict = ["progress": progress.fractionCompleted]
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "uploadProgress"), object: myDict)
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .response{ response in
                    if response.error == nil{
                        do{
                            if let jsonData = response.data, let httpResponse = response.response{
                                let parsedData = try JSONSerialization.jsonObject(with: jsonData)
                                print(parsedData)
                                let arg: (HTTPURLResponse,Any) = (httpResponse, parsedData)
                                observer.onNext(arg)
                                observer.onCompleted()
                                
                            }
                        }catch{
                            if let httpResponse = response.response{
                                let arg: (HTTPURLResponse,Any) = (httpResponse, "Error")
                                observer.onNext(arg)
                            }
                        }
                    }else{
                        observer.onError(response.error!)
                    }
            }
            return Disposables.create {
            }
        }
    }
    
    private func execute<T>(method: Alamofire.HTTPMethod ,path: String,values: Dictionary<String,Any>,encoding:ParameterEncoding = JSONEncoding.default)-> Observable<T> where T:JsonDeserilizer{
        let httpHeaders: HTTPHeaders = [HTTPHeader.authorization(bearerToken: AppDefaults.accessToken)]
        var pathUrl = ""
//        if AppDefaults.searchAvailable{
//           pathUrl = path.contains("http") ? path : path
//        }
//        else{
          pathUrl = path.contains("http") ? path : url+path
        //}
   
        
        return  RxAlamofire.requestJSON(method, pathUrl, parameters: values, headers: httpHeaders)
            .debug()
            .map {(arg) -> T in
                return self.populateData(arg)
        }
    }
    
    private func populateData<T>(_ arg : (HTTPURLResponse,Any)) -> T where T:JsonDeserilizer{
        let (_, json) = arg
        var instance = T.init()
        let responseConverted = json as? [String:Any]
        instance.statusCode = arg.0.statusCode
        instance.deserilize(values:responseConverted)
        return instance
    }
    
    private func create<T>() -> T  where T:JsonDeserilizer {
        return T.init()
    }
    
    private func refresh<T>(_ method: HTTPMethod, _ path:String, value:JsonSerilizer)->Observable<T> where T:JsonDeserilizer{
        
        let fullUrl = url+Constants.RxApiEnds.refreshToken
        let param: Dictionary<String,Any>  = [:]
//            ["user_id": fetchUserData()?.userId ?? ""]
        return RxAlamofire.requestJSON(.post, fullUrl, parameters: param)
            .debug()
            .flatMap { (response) -> Observable<T> in
                if response.0.statusCode == 200, let json = response.1 as? [String:Any]{
                    let result = json["res"] as? [String:Any] ?? [:]
                    let token = result["token"] as? String ?? ""
                    self.saveToken(token)
                    
//                    self.saveToken(json["data"] as? [String : Any] ?? [:])
                    if value is FileSerilizer {
                        
                        let fullUrl = self.url + path
                        
                        return  self.startUploading(url: fullUrl, data: (value as! FileSerilizer).file(), values: value.serilize())
                            .map { (response) -> T in
                                
                                var instance = T.init()
                                let responseConverted = response as? [String:Any]
                                
                                instance.deserilize(values:responseConverted)
                                
                                return instance
                        }
                    }else{
                        return self.execute(method: method, path: path, values: value.serilize())
                    }
                }else{
                    NotificationCenter.default.post(name: NSNotification.Name(Constants.NotifNames.refreshTokenExpire), object: nil)
                    let (_, json) = response
                    var instance = T.init()
                    let responseConverted = json as? [String:Any]
                    instance.deserilize(values:responseConverted)
                    //return instance as! Observable<T>
                    return Observable.create { (observer) -> Disposable in
                        observer.onNext(instance)
                        observer.onCompleted()
                        return Disposables.create {
                        }
                    }
            }
        }
    }
    
    private func saveToken(_ token: String){
        
            AppDefaults.accessToken = token
//        if let time = json["time"] as? String{
//            var seconds:Int = 0
//            if time.contains("h"){
//                seconds = (Int(time.dropLast()) ?? 0) * 3600
//            }
//            else if time.contains("d"){
//                seconds = (Int(time.dropLast()) ?? 0) * 24 * 3600
//
//            }
//            else if time.contains("y"){
//                seconds = (Int(time.dropLast()) ?? 0) * 365 * 24 * 3600
//            }
            AppDefaults.tokenExpiry = Date().addingTimeInterval(TimeInterval(7200000000))
//        }
    }
}
