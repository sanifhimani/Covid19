//
//  ChartDataService.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-20.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import Foundation
import Charts

class ChartDataService {
    static func getChartData(totalConfirmed: Int, totalDeaths: Int, totalRecovered: Int) -> BarChartData {
        let totalConfirmed = BarChartDataEntry(x: 0, y: Double(totalConfirmed))
        let totalDeaths = BarChartDataEntry(x: 1, y: Double(totalDeaths))
        let totalRecovered = BarChartDataEntry(x: 2, y: Double(totalRecovered))
        let covidDataSet = BarChartDataSet(entries: [totalConfirmed, totalDeaths, totalRecovered], label: "Covid-19 Statistics")
        covidDataSet.colors = [#colorLiteral(red: 1, green: 0.6980392157, blue: 0.3490196078, alpha: 1), #colorLiteral(red: 1, green: 0.3490196078, blue: 0.3490196078, alpha: 1), #colorLiteral(red: 0.3432368338, green: 0.8650581837, blue: 0.5552410483, alpha: 1)]
        return BarChartData(dataSet: covidDataSet)
    }
}
