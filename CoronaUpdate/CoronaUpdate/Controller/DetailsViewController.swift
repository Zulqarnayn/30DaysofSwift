//
//  DetailsViewController.swift
//  CoronaUpdate
//
//  Created by Asif Mujtaba on 3/28/20.
//  Copyright © 2020 Asif Mujtaba. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var ImageViewFlag: UIImageView!
    @IBOutlet weak var lblCases: UILabel!
    @IBOutlet weak var lblTodayCases: UILabel!
    @IBOutlet weak var lblDeaths: UILabel!
    @IBOutlet weak var lblTodayDeaths: UILabel!
    @IBOutlet weak var lblRecovered: UILabel!
    @IBOutlet weak var lblActive: UILabel!
    @IBOutlet weak var lblCritical: UILabel!
    @IBOutlet weak var lblCasesPM: UILabel!
    @IBOutlet weak var lblDeathsPM: UILabel!
    
    var model: CoronaModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        lblCountryName.text = model?.countryName
        ImageViewFlag.sd_setImage(with: URL(string: model!.countryFlag!), placeholderImage: #imageLiteral(resourceName: "world"))
        lblCases.text = String(format: "Cases  : %d", model?.cases?.intValue ?? 0)
        lblDeaths.text = String(format: "Deaths  : %d", model?.deaths?.intValue ?? 0)
        lblRecovered.text = String(format: "Recovered  : %d", model?.recovered?.intValue ?? 0)
        lblTodayCases.text = String(format: "Today Cases   : %d", model?.todayCases?.intValue ?? 0)
        lblTodayDeaths.text = String(format: "Today Deaths  : %d", model?.todayDeaths?.intValue ?? 0)
        lblActive.text = String(format: "Active  :  %d", model?.active?.intValue ?? 0)
        lblCritical.text = String(format: "Critical  : %d", model?.critical?.intValue ?? 0)
        lblCasesPM.text = String(format: "Cases Per Million  : %d", model?.casesPerOneMillion?.intValue ?? 0)
        lblDeathsPM.text = String(format: "Deaths Per Million  : %d", model?.deathsPerOneMillion?.intValue ?? 0)
    }

    @IBAction func bntDismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
