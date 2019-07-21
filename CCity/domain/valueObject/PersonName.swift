//
//  PersonName.swift
//  CCity
//
//  Created by 安宅 正之 on 2019/07/21.
//  Copyright © 2019 WelltempRed. All rights reserved.
//

import Foundation

struct PersonName {
    let last: String
    let first: String?
    
    var full: String {
        switch (first, last) {
        case let (first?, last):
            return "\(first) \(last)"
        case (.none, _):
            return last
        }
    }
}
