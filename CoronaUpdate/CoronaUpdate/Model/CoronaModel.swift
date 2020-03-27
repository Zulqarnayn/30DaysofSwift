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

class CoronaModel: NSObject {
    var countryName: String?
    var countryFlag: String?
    var cases: NSNumber?
    var todayCases: NSNumber?
    var deaths: NSNumber?
    var todayDeaths: NSNumber?
    var recovered: NSNumber?
    var active: NSNumber?
    var critical: NSNumber?
    var casesPerOneMillion: NSNumber?
    var deathsPerOneMillion: NSNumber?
}
