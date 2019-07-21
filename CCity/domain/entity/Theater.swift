//
//  Theater.swift
//  CCity
//
//  Created by 安宅 正之 on 2019/07/21.
//  Copyright © 2019 WelltempRed. All rights reserved.
//

import Foundation

struct TheaterId {}

struct Theater {
    let id: TheaterId
    let name: String
    let stuioIds: [StudioId]
    let address: String
}
