//
//  FirstViewController.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-19.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import UIKit
import Charts
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var country: String = ""
    var currentLocation: CLLocation? = nil
    let locationManager = CLLocationManager()
    var apiData: API = API()
    
    @IBOutlet weak var affectedLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var recoveryRateLabel: UILabel!
    @IBOutlet weak var deathRateLabel: UILabel!
    @IBOutlet weak var statisticsTitleLabel: UILabel!
    @IBOutlet weak var statisticsChartView: HorizontalBarChartView!
    @IBOutlet weak var countrySegmentedControl: UISegmentedControl!
    
    @IBAction func countrySegmentChanged(_ sender: Any) {
        switch countrySegmentedControl.selectedSegmentIndex {
        case 0:
            statisticsTitleLabel.text = "Global Statistics"
            let response: Array<CovidData> = self.getResponse(forCountry: "All")
            self.printCovidData(covidData: response[0])
        case 1:
            statisticsTitleLabel.text = "\(country) Statistics"
            let response: Array<CovidData> = self.getResponse(forCountry: country)
            self.printCovidData(covidData: response[0])
        default:
            statisticsTitleLabel.text = "Global Statistics"
            let response: Array<CovidData> = self.getResponse(forCountry: "All")
            self.printCovidData(covidData: response[0])
        }
    }
    
    func getCovidData() {
        CovidDataService.getCovidData { (apiData, error) in
            guard let apiData = apiData else {
                return
            }
            self.apiData = apiData
            let response: Array<CovidData> = self.getResponse(forCountry: "All")
            self.printCovidData(covidData: response[0])
        }
    }
    
    func getResponse(forCountry: String) -> Array<CovidData> {
        let response = apiData.response.filter { (covidData) -> Bool in
            covidData.country == forCountry
        }
        return response
    }
    
    func printCovidData(covidData: CovidData) {
        
        let totalDeaths: Int = covidData.deaths.total
        let totalCases: Int = covidData.cases.total
        let totalRecovered: Int = covidData.cases.recovered
        
        DispatchQueue.main.async {
            self.affectedLabel.text = FormatNumber.formatNumber(number: totalCases)
            self.deathLabel.text = FormatNumber.formatNumber(number: totalDeaths)
            self.recoveredLabel.text = FormatNumber.formatNumber(number: totalRecovered)
            self.deathRateLabel.text = self.calculateDeathRate(totalDeaths: totalDeaths, totalRecovered: totalRecovered) + "%"
            self.recoveryRateLabel.text = self.calculateRecoveryRate(totalDeaths: totalDeaths, totalRecovered: totalRecovered) + "%"
            self.statisticsChartView.xAxis.drawGridLinesEnabled = false
            self.statisticsChartView.animate(yAxisDuration: 1)
            self.statisticsChartView.xAxis.labelRotationAngle = 90.0
            self.statisticsChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
            self.statisticsChartView.rightAxis.enabled = false
            self.statisticsChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Affected", "Deaths", "Recovered"])
            self.statisticsChartView.data = ChartDataService.getChartData(totalConfirmed: totalCases, totalDeaths: totalDeaths, totalRecovered: totalRecovered)
        }
    }
    
    func calculateRecoveryRate(totalDeaths: Int, totalRecovered: Int) -> String {
        let totalClosedCases = totalRecovered + totalDeaths
        return String(format: "%.2f", Double(totalRecovered)/Double(totalClosedCases) * 100)
    }
    
    func calculateDeathRate(totalDeaths: Int, totalRecovered: Int) -> String {
        let totalClosedCases = totalRecovered + totalDeaths
        return String(format: "%.2f", Double(totalDeaths)/Double(totalClosedCases) * 100)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            GeocodingService.getCountry(location: location) { (country, error) in
                guard let country = country else {
                    return
                }
                self.country = country
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCovidData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        countrySegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular)], for:.normal)
        countrySegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)], for:.selected)
    }
}
