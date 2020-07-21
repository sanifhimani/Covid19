//
//  GeocodingService.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-19.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import Foundation
import CoreLocation

class GeocodingService {
    
    static func getCountry(location: CLLocation, completion: @escaping(_ country: String?, Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }
            guard let country = placemark.country else {
                print("Unknown")
                return
            }
            completion(country, nil)
        }
    }
}
