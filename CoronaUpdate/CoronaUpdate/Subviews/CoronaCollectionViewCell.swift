//
//  CoronaCollectionViewCell.swift
//  CoronaUpdate
//
//  Created by Asif Mujtaba on 3/27/20.
//  Copyright © 2020 Asif Mujtaba. All rights reserved.
//

import UIKit

class CoronaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var countryImgView: UIImageView!
    
    @IBOutlet weak var lblTotalCases: UILabel!
    @IBOutlet weak var lblTotalRecovered: UILabel!
    @IBOutlet weak var lblTotalDeaths: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
