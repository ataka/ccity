//
//  Program.swift
//  CCity
//
//  Created by 安宅 正之 on 2019/07/21.
//  Copyright © 2019 WelltempRed. All rights reserved.
//

import Foundation

struct ProgramId {}

struct Program {
    let id: ProgramId
    let filmId: FilmId
    let studioId: StudioId
    let start: Date
    let end: Date
    let soundType: SoundType
    let viedoType: VideoType
    
    typealias SpecialPriceHandler = (_ customer: Customer) -> Price
    let specialPriceHandler: SpecialPriceHandler?
    
    /// レイトショーのプログラムなら true
    var isLateShow: Bool {
        guard !soundType.isBestLoud else { return false }
        let hour = Calendar.current.component(.hour, from: start)
        return hour >= 20
    }
    
    /// 「映画の日」のプログラムなら true
    var isMovieDayProgram: Bool {
        let day = Calendar.current.component(.day, from: start)
        return day == 1
    }
    
    /// 平日のプログラムなら true; 土日祝のプログラムなら false
    var isWeedDayProgram: Bool {
        guard isJpHoliday(start) else { return false }
        return !Calendar.current.isDateInWeekend(start)
    }
    
    private func isJpHoliday(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let year = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        switch (year, month, day) {
        case (_, 1, 1): return true
        default:
            return false
        }
    }
}

enum SoundType {
    case normal
    /// 極上音響
    case best
    /// 極上爆音
    case bestLoud
    
    var isBestLoud: Bool {
        return self == .bestLoud
    }
}

enum VideoType {
    case normal
    /// 3D 上映
    case movie3d
    
    var is3DMovie: Bool {
        return self == .movie3d
    }
}
