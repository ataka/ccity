//
//  PurchaseDomainService.swift
//  CCity
//
//  Created by 安宅 正之 on 2019/07/21.
//  Copyright © 2019 WelltempRed. All rights reserved.
//

import Foundation

private enum DayType {
    case movieDay
    case holiday
    case weekday

    static func getDayType(program: Program, customer: Customer) -> DayType {
        switch (customer.type, program.isMovieDayProgram, program.isWeedDayProgram) {
        case (.citizen, _, true):          return .weekday  // 平日なら「映画の日」に関係なく 1,000 円
        case (.citizen, false, false):     return .holiday
        case (.citizen, true, false):      return .movieDay
        case (.couple, true, false):       fallthrough  // 「映画の日」の適用はなし
        case (.miCardHolder, true, false): fallthrough  // 「映画の日」の適用はなし
        case (.carParking, true, false):   fallthrough  // 「映画の日」の適用はなし
        case (_, false, true):             return .weekday
        case (.couple, true, true):        fallthrough  // 「映画の日」の適用はなし
        case (.miCardHolder, true, true):  fallthrough  // 「映画の日」の適用はなし
        case (.carParking, true, true):    fallthrough  // 「映画の日」の適用はなし
        case (_, false, false):            return .holiday
        case (_, true, _):                 return .movieDay
        }
    }
}

private enum ShowType {
    case movieDay
    case lateShow
    case normal

    static func getShowType(program: Program, dayType: DayType) -> ShowType {
        switch (dayType, program.isLateShow) {
        case (.movieDay, _): return .movieDay
        case (_, true):      return .lateShow
        case (_, false):     return .normal
        }
    }
}

struct PurchaseDomainService {
    func calcPrice(for program: Program, with customer: Customer) -> Price {
        let feeReserve = calcReserveFee(customer: customer)
        if let specialPrice = program.specialPriceHandler {
            return specialPrice(customer) + feeReserve
        }

        let fee3D = calc3DFee(for: program, with: customer)
        let basePrice = calcBasePrice(for: program, with: customer)
        return basePrice + fee3D + feeReserve
    }
    
    private func calcBasePrice(for program: Program, with customer: Customer) -> Price {
        let dayType = DayType.getDayType(program: program, customer: customer)
        let showType = ShowType.getShowType(program: program, dayType: dayType)
        switch (customer.type, showType) {
        case (.citizen,      .movieDay):   return Price(1_100)
        case (.citizen,      .lateShow):   return Price(1_000)
        case (.citizen,      .normal):     return Price(program.isWeedDayProgram ? 1_000 : 1_300) // 土日祝の通常時間のみ 1,300 円t
        case (.citizenSenior, _):          return Price(1_000)
        case (.adult,        .movieDay):   return Price(1_100)
        case (.adult,        .lateShow):   return Price(1_300)
        case (.adult,        .normal):     return Price(1_800)
        case (.adultSenior,  _):           return Price(1_100)
        case (.student,      .movieDay):   return Price(1_100)
        case (.student,      .lateShow):   return Price(1_300)
        case (.student,      .normal):     return Price(1_500)
        case (.highSchoolStudent, _):      return Price(1_000)
        case (.child,        _):           return Price(1_000)
        case (.handicapped,  _):           return Price(1_000)
        case (.handicappedJunior, _):      return Price(  900)
        case (.couple,       _):           return Price(1_100)
        case (.miCardHolder, .lateShow):   return Price(1_300)
        case (.miCardHolder, .normal):     return Price(1_600)
        case (.carParking,   .lateShow):   return Price(1_100)
        case (.carParking,   .normal):     return Price(1_400)
        default:
            fatalError("Unknown combination of customer.type and showType: \(customer.type), \(dayType)")
        }
    }
    
    private func calc3DFee(for program: Program, with customer: Customer) -> Price {
        switch (program.viedoType.is3DMovie, customer.has3DGlass) {
        case (true, false): return Price(400)
        case (true, true):  return Price(300)
        case (false, _):    return .zero
        }
    }
    
    private func calcReserveFee(customer: Customer) -> Price {
        switch customer.type {
        case .citizen, .citizenSenior: return .zero
        default: return Price(50)
        }
    }
}
