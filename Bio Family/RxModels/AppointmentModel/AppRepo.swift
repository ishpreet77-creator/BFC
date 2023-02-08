//
//  AppRepo.swift
//  Bio Family
//
//  Created by John on 04/01/23.
//

import Foundation
import RxSwift
 
protocol AppRepo{
    func bookAppointment(_ req: AppRequest) -> Single<AppResponse>
    func getAllAppointment() -> Single<AppResponse>
    func reScheduleAppointment(_ req: AppRequest) -> Single<AppResponse>
    func cancelAppointment(_ req: AppRequest) -> Single<AppResponse>
    func historyAppoint() -> Single<AppResponse>
    func reviewBioFamily(_ req: AppReviewBioFamily) -> Single<AppResponse>
    func contactUs(_ req: AppContactUs) -> Single<AppResponse>
    func notification() -> Single<AppResponse>
    func prescripition(_ req: AppPrescripition) -> Single<AppResponse>
    func delete() -> Single<AppResponse>
}

