//
//  FormatNumber.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-20.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import Foundation

class FormatNumber {
    static func formatNumber(number: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: number))
    }
}
