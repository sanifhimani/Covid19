//
//  CovidDataService.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-21.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import Foundation

class CovidDataService {
    static var covidData: API?
    static func getCovidData(completion: @escaping(_ covidData: API?, Error?) -> ()) {
        URLService.getCovidData { (covidData, error) in
            guard let covidData = covidData else {
                return
            }
            self.covidData = covidData
            completion(covidData, nil)
        }
//        if let data = URLService.getCovidDataFromFile(filename: "covid_data") {
//            self.covidData = data
//            completion(data, nil)
//        }
    }
}
