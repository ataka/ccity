//
//  Price.swift
//  CCity
//
//  Created by 安宅 正之 on 2019/07/21.
//  Copyright © 2019 WelltempRed. All rights reserved.
//

import Foundation

struct Price: AdditiveArithmetic {
    let value: Int
    
    init(_ value: Int) {
        self.value = value
    }
    
    // MARK: - Additive Arithmetic Protocol

    static let zero: Price = Price(0)
    
    static func + (lhs: Price, rhs: Price) -> Price {
        return Price(lhs.value + rhs.value)
    }
    
    static func += (lhs: inout Price, rhs: Price) {
        lhs = lhs + rhs
    }

    static func - (lhs: Price, rhs: Price) -> Price {
        return Price(lhs.value - rhs.value)
    }

    static func -= (lhs: inout Price, rhs: Price) {
        lhs = lhs - rhs
    }
}
