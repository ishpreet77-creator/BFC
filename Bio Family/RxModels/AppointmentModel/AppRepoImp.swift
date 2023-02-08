//
//  AppRepoImp.swift
//  Bio Family
//
//  Created by John on 04/01/23.
//

import Foundation
import RxSwift

class AppRepoImp :AppRepo{
    
    
    private var rxApi:RxApi
    
    init(rxApi:RxApi) {
        self.rxApi = rxApi
    }
    
    func bookAppointment(_ req: AppRequest) -> RxSwift.Single<AppResponse> {
        return rxApi.post(path: Constants.RxApiEnds.appointment, value: req).asSingle()
    }
    func getAllAppointment() -> Single<AppResponse> {
        return rxApi.get(path: Constants.RxApiEnds.getAllApointment, value: CommonRequest.init()).asSingle()
    }
    func reScheduleAppointment(_ req: AppRequest) -> RxSwift.Single<AppResponse> {
        return rxApi.post(path: Constants.RxApiEnds.reScheduleAppoint, value: req).asSingle()
    }
    func cancelAppointment(_ req: AppRequest) -> RxSwift.Single<AppResponse> {
        return rxApi.post(path: Constants.RxApiEnds.cancelAppoint, value: req).asSingle()
    }
    func historyAppoint() -> RxSwift.Single<AppResponse> {
        return rxApi.get(path: Constants.RxApiEnds.historyAppointment, value: CommonRequest.init()).asSingle()
    }
    func reviewBioFamily(_ req: AppReviewBioFamily) -> RxSwift.Single<AppResponse> {
        return rxApi.post(path: Constants.RxApiEnds.reviewBioFamily, value: req).asSingle()
    }
    func contactUs(_ req: AppContactUs) -> RxSwift.Single<AppResponse> {
        return rxApi.post(path: Constants.RxApiEnds.contactUs, value: req).asSingle()
    }
    func notification() -> RxSwift.Single<AppResponse> {
        return rxApi.get(path: Constants.RxApiEnds.notificationBioFam, value: CommonRequest.init()).asSingle()
    }
  
    func prescripition(_ req: AppPrescripition) -> RxSwift.Single<AppResponse> {
        return rxApi.post(path: Constants.RxApiEnds.prescripition, value: req).asSingle()
    }
    func delete() -> RxSwift.Single<AppResponse> {
        return rxApi.post(path: Constants.RxApiEnds.delete, value: CommonRequest.init()).asSingle()
    }
    
}
