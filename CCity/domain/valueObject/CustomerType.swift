//
//  CustomerType.swift
//  CCity
//
//  Created by 安宅 正之 on 2019/07/21.
//  Copyright © 2019 WelltempRed. All rights reserved.
//

import Foundation

enum CustomerType {
    /// シネマシティズン
    case citizen
    /// シネマシティズン (60歳以上)
    case citizenSenior
    /// 一般
    case adult
    /// シニア (70歳以上)
    case adultSenior
    /// 学生 (大学生・大学院生・高専生)
    case student
    /// 中・高校生 (junior and senior hight school student)
    case highSchoolStudent
    /// 幼児 (3歳以上)・小学生
    case child
    /// 障害者 (学生以上)
    case handicapped
    /// 障害者 (高校以下)
    case handicappedJunior
    /// 夫婦50割引
    case couple
    /// エムアイカード
    case miCardHolder
    /// 駐者場パーク80割引
    case carParking
    
    /// 年齢の分かる身分証の提示が必要なら true
    var requiresIdCard: Bool {
        switch self {
        case .adultSenior:
            return true
        default:
            return false
        }
    }
    
    /// 学生証 (大学生・大学院生・高専生) / 生徒手帳 (中学生・高校生) の提示が必要なら true
    var requiresStudientIdCard: Bool {
        switch self {
        case .student, .highSchoolStudent, .handicappedJunior:
            return true
        default:
            return false
        }
    }
    
    /// 障害手帳 (?) の提示が必要なら true
    var requiresHandicappedIdCard: Bool {
        switch self {
        case .handicapped, .handicappedJunior:
            return true
        default:
            return false
        }
    }
}
