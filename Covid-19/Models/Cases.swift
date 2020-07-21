//
//  Cases.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-07-21.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import Foundation

struct Cases:Codable {
    let new: String?
    let active: Int
    let critical: Int
    let recovered: Int
    let total: Int
}
