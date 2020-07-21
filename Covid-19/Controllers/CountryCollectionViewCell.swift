//
//  CountryCollectionViewCell.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-21.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import UIKit
import Charts

class CountryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countryBackgroundColorView: RoundedUIView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryTotalConfirmedValueLabel: UILabel!
}
