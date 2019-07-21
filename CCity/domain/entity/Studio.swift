//
//  Studio.swift
//  CCity
//
//  Created by 安宅 正之 on 2019/07/21.
//  Copyright © 2019 WelltempRed. All rights reserved.
//

import Foundation

struct StudioId {}

struct Studio {
    let id: StudioId
    let theaterId: TheaterId
    let name: String
    let capacity: Int
    
    var description: String {
        return "\(name) \(capacity)席"
    }
}
