//
//  URLService.swift
//  Covid-19
//
//  Created by Sanif Himani on 2020-04-19.
//  Copyright © 2020 Sanif Himani. All rights reserved.
//

import Foundation

class URLService {
    static func getCovidData(completion: @escaping(_ covidData: API?, Error?) -> ()) {
        let urlSession = URLSession(configuration: .default)
        let url = URL(string: Constants.urlString)
        if let url = url {
            var request = URLRequest(url: url)
            request.addValue(Constants.apiKey, forHTTPHeaderField: "x-rapidapi-key")
            let dataTask = urlSession.dataTask(with: request) {
                (data, response, error) in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let readableData = try jsonDecoder.decode(API.self, from: data)
                        completion(readableData, nil)
                    }
                    catch {
                        print("I cannot decode your data")
                        completion(nil, Error.self as? Error)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    static func getCovidDataFromFile(filename fileName: String) -> CovidData? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let readableData = try jsonDecoder.decode(CovidData.self, from: data)
                    return readableData
                }
                catch {
                    print("I cannot decode your data")
                }
            } catch {
                print("I can not read your file \(fileName).json")
                print(error)
            }
        }
        print("I can not read the file \(fileName).json")
        return nil
    }
}
