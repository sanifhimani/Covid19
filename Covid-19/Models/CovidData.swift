//
//  CovidData.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-19.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import Foundation

struct CovidData:Codable {
    let cases: Cases
    let continent: String?
    let country: String
    let day: String
    let deaths: Deaths
    let population: Int?
    let tests: Tests
    let time: String
}
