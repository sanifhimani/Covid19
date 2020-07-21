//
//  SecondViewController.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-19.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import UIKit
import Charts

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var filteredAreas: Array<CovidData> = []
    var lineChartData: [LineChartData] = []
    let backgroundColorArray: Array<UIColor> = [#colorLiteral(red: 1, green: 0.7406160235, blue: 0.3498056531, alpha: 1), #colorLiteral(red: 1, green: 0.4020825624, blue: 0.3985117078, alpha: 1), #colorLiteral(red: 0, green: 0.8844738603, blue: 0.5246576071, alpha: 1), #colorLiteral(red: 0.1089325324, green: 0.7710372806, blue: 1, alpha: 1), #colorLiteral(red: 0.6726679802, green: 0.4354025722, blue: 1, alpha: 1)]
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var countryCollectionView: UICollectionView!
    @IBOutlet weak var staticticsLabel: UILabel!
    @IBOutlet weak var countryStatisticsLabel: UILabel!
    @IBOutlet weak var affectedView: RoundedUIView!
    @IBOutlet weak var affectedLabel: UILabel!
    @IBOutlet weak var affectedValueLabel: UILabel!
    @IBOutlet weak var deathView: RoundedUIView!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var deathValueLabel: UILabel!
    @IBOutlet weak var recoveredView: RoundedUIView!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var recoveredValueLabel: UILabel!
    @IBOutlet weak var recoveryRateView: RoundedUIView!
    @IBOutlet weak var recoveryRateLabel: UILabel!
    @IBOutlet weak var recoveryRateValueLabel: UILabel!
    @IBOutlet weak var deathRateView: RoundedUIView!
    @IBOutlet weak var deathRateLabel: UILabel!
    @IBOutlet weak var deathRateValueLabel: UILabel!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            guard let covidAreas = CovidDataService.covidData else {
                return
            }
            filteredAreas = covidAreas.response.filter { (covidData) -> Bool in
                covidData.country != "all"
            }
        } else {
            guard let covidAreas = CovidDataService.covidData else {
                return
            }
            let filteredAreasWithoutAll = covidAreas.response.filter { (covidData) -> Bool in
                covidData.country != "all"
            }
            filteredAreas = filteredAreasWithoutAll.filter { $0.country.lowercased().contains(searchText.lowercased())
            }
        }
        staticticsLabel.isHidden = false
        hideCountryStatistics(hide: true)
        countryCollectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        staticticsLabel.isHidden = false
        hideCountryStatistics(hide: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredAreas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCollectionViewCell", for: indexPath) as! CountryCollectionViewCell
        cell.countryNameLabel.text = filteredAreas[indexPath.row].country
        cell.countryBackgroundColorView.backgroundColor = backgroundColorArray.randomElement()
        cell.countryTotalConfirmedValueLabel.text = FormatNumber.formatNumber(number: filteredAreas[indexPath.row].cases.total)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        countrySearchBar.searchTextField.resignFirstResponder()
        staticticsLabel.isHidden = true
        hideCountryStatistics(hide: false)
        let totalDeaths: Int = filteredAreas[indexPath.item].deaths.total
        let totalRecovered: Int = filteredAreas[indexPath.item].cases.recovered
        let totalCases: Int = filteredAreas[indexPath.item].cases.total
        countryStatisticsLabel.text = "\(filteredAreas[indexPath.item].country) Statistics"
        affectedValueLabel.text = FormatNumber.formatNumber(number: totalCases)
        deathValueLabel.text = FormatNumber.formatNumber(number: totalDeaths)
        recoveredValueLabel.text = FormatNumber.formatNumber(number: totalRecovered)
        recoveryRateValueLabel.text = calculateRecoveryRate(totalDeaths: totalDeaths, totalRecovered: totalRecovered)
        deathRateValueLabel.text = calculateDeathRate(totalDeaths: totalDeaths, totalRecovered: totalRecovered)
    }

    func calculateRecoveryRate(totalDeaths: Int, totalRecovered: Int) -> String {
        let totalClosedCases = totalRecovered + totalDeaths
        return String(format: "%.2f", Double(totalRecovered)/Double(totalClosedCases) * 100)
    }

    func calculateDeathRate(totalDeaths: Int, totalRecovered: Int) -> String {
        let totalClosedCases = totalRecovered + totalDeaths
        return String(format: "%.2f", Double(totalDeaths)/Double(totalClosedCases) * 100)
    }

    func hideCountryStatistics(hide: Bool) {
        countryStatisticsLabel.isHidden = hide
        affectedView.isHidden = hide
        affectedLabel.isHidden = hide
        affectedValueLabel.isHidden = hide
        deathView.isHidden = hide
        deathLabel.isHidden = hide
        deathValueLabel.isHidden = hide
        recoveredView.isHidden = hide
        recoveredLabel.isHidden = hide
        recoveredValueLabel.isHidden = hide
        recoveryRateView.isHidden = hide
        recoveryRateLabel.isHidden = hide
        recoveryRateValueLabel.isHidden = hide
        deathRateView.isHidden = hide
        deathRateLabel.isHidden = hide
        deathRateValueLabel.isHidden = hide
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let covidAreas = CovidDataService.covidData else {
            return
        }
        filteredAreas = covidAreas.response.filter { (covidData) -> Bool in
            covidData.country != "all"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countrySearchBar.autocapitalizationType = UITextAutocapitalizationType.words
        countrySearchBar.placeholder = "Enter country name"
        countrySearchBar.delegate = self
        countrySearchBar.enablesReturnKeyAutomatically = true
        countryCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        hideCountryStatistics(hide: true)
    }
}
