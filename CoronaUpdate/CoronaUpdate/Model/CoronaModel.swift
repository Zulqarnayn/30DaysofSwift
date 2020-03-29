//
//  CoronaModel.swift
//  CoronaUpdate
//
//  Created by Asif Mujtaba on 3/27/20.
//  Copyright © 2020 Asif Mujtaba. All rights reserved.
//

import UIKit

let urlString = "https://corona.lmao.ninja/countries" // new

//"https://corona.lmao.ninja/countries?sort=%7Bparameter%7D" // old

//class CoronaModel: NSObject {
//    var countryName: String?
//    var countryFlag: String?
//    var cases: NSNumber?
//    var todayCases: NSNumber?
//    var deaths: NSNumber?
//    var todayDeaths: NSNumber?
//    var recovered: NSNumber?
//    var active: NSNumber?
//    var critical: NSNumber?
//    var casesPerOneMillion: NSNumber?
//    var deathsPerOneMillion: NSNumber?
//
//    init(json: [String: Any]) {
//        countryName = json["country"] as? String
//        let contryDic = json["countryInfo"] as? [String: AnyObject]
//        countryFlag = contryDic!["flag"] as? String
//        cases = json["cases"] as? NSNumber
//        todayCases = json["todayCases"] as? NSNumber
//        deaths = json["deaths"] as? NSNumber
//        todayDeaths = json["todayDeaths"] as? NSNumber
//        recovered = json["recovered"] as? NSNumber
//        active = json["active"] as? NSNumber
//        critical = json["critical"] as? NSNumber
//        casesPerOneMillion = json["casesPerOneMillion"] as? NSNumber
//        deathsPerOneMillion = json["deathsPerOneMillion"] as? NSNumber
//    }
//}

class CountryModel: Decodable {
    var _id: Int?
    var country: String?
    var iso2: String?
    var iso3: String?
    var lat: Float?
    var long: Float?
    var flag: String?
}

class CoronaModel: Decodable {
    var country: String?
    var countryInfo: CountryModel?
    var cases: Int?
    var todayCases: Int?
    var deaths: Int?
    var todayDeaths: Int?
    var recovered: Int?
    var active: Int?
    var critical: Int?
    var casesPerOneMillion: Float?
    var deathsPerOneMillion: Float?
}
