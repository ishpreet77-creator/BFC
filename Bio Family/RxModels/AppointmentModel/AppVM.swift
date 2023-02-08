//
//  AppVM.swift
//  Bio Family
//
//  Created by John on 04/01/23.
//

import Foundation
import RxSwift
import Alamofire
enum AppType {
    case appointment
    case getAppointment
    case reScheduleAppoin
    case cancelAppoint
    case historyAppoint
    case reviewBiofamily
    case contactUs
    case notification
    case prescription
    case delete
}

class AppVM: ViewModel<AppResponse>{
    
    private var repository: AppRepo
    var type:AppType = .appointment
    init(repository: AppRepo) {
        self.repository = repository
    }
    
    //MARK:- Userdefined Varaiables
    
    //MARK:- Check User Signup validation Api
    
    
    func appointment(_ req: AppRequest){
        isLoading.onNext(true)
        repository.bookAppointment(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .appointment
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func getAppointment(){
        isLoading.onNext(true)
        repository.getAllAppointment().subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .getAppointment
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    
    func reScheduleAppoint(_ req: AppRequest){
        isLoading.onNext(true)
        repository.reScheduleAppointment(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .reScheduleAppoin
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func cancelAppoint(_ req: AppRequest){
        isLoading.onNext(true)
        repository.cancelAppointment(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .cancelAppoint
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func historyAppointment(){
        isLoading.onNext(true)
        repository.historyAppoint().subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .historyAppoint
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func reviewBoifamily(_ req: AppReviewBioFamily){
        isLoading.onNext(true)
        repository.reviewBioFamily(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .reviewBiofamily
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func contactUs(_ req: AppContactUs){
        isLoading.onNext(true)
        repository.contactUs(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .contactUs
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func notification(){
        isLoading.onNext(true)
        repository.notification().subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .notification
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func prescription(_ req: AppPrescripition){
        isLoading.onNext(true)
        repository.prescripition(req).subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .prescription
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
    func delete (){
        isLoading.onNext(true)
        repository.delete().subscribe(onSuccess: { (response) in
            if response.statusCode == 200{
                //self.saveToken(response.token)
            }
            self.type = .delete
            self.response.onNext(response)
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            self.isLoading.onNext(false)
            self.error.onNext(error.localizedDescription)
        }).disposed(by: super.disposeBag)
    }
}
