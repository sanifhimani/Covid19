//
//  API.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-07-21.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import Foundation

struct API:Codable {
    let get: String
    let response: Array<CovidData>
    let results: Int
    
    init() {
        get = ""
        response = []
        results = 0
    }
}
