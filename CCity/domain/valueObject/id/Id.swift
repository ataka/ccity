//
//  Id.swift
//  CCity
//
//  Created by 安宅 正之 on 2019/07/21.
//  Copyright © 2019 WelltempRed. All rights reserved.
//

protocol Id: Hashable {
    associatedtype IdType: Hashable
    var value: IdType { get }
}

extension Id {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.value == rhs.value
    }
}
