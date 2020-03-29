//
//  CoronaCollectionView.swift
//  CoronaUpdate
//
//  Created by Asif Mujtaba on 3/27/20.
//  Copyright © 2020 Asif Mujtaba. All rights reserved.
//

import UIKit

protocol CoronaCollectionViewDelegate: NSObject {
    func tapped(model: CoronaModel)
}

enum sortType {
    case cases, deaths, recover
}

class CoronaCollectionView: UICollectionView {

    weak var customDelegate: CoronaCollectionViewDelegate?
    var colData = [CoronaModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup() {
        
        self.delegate = self
        self.dataSource = self
        
        self.register(UINib(nibName: "CoronaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoronaCollectionViewCell")
    }
    
    func sortBy(type: sortType, ascending: Bool){
        if type == .cases {
            colData.sort {
                if ascending {
                    return (($0.cases)!) < (($1.cases)!)
                }
                else {
                    return (($0.cases)!) > (($1.cases)!)
                }
            }
        }
        else if type == .deaths {
            colData.sort {
                if ascending {
                    return (($0.deaths)!) < (($1.deaths)!)
                }
                else {
                    return (($0.deaths)!) > (($1.deaths)!)
                }
            }
        }
        else if type == .recover {
            colData.sort {
                if ascending {
                    return (($0.recovered)!) < (($1.recovered)!)
                }
                else {
                    return (($0.recovered)!) > (($1.recovered)!)
                }
            }
        }
        
        reloadData()
    }
    
}

extension CoronaCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        customDelegate?.tapped(model: colData[indexPath.row])
    }
}

extension CoronaCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("+++ codData: \(colData.count)")
        return colData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoronaCollectionViewCell", for: indexPath) as! CoronaCollectionViewCell
        
        let model = colData[indexPath.row]
        
        //thumb url
        if model.countryInfo!.flag != nil {
            cell.countryImgView.loadImageUsingUrlString(urlString: model.countryInfo!.flag!)
        }
        
        cell.lblCountry.text = model.country!
        cell.lblTotalCases.text = String(format: "%d", model.cases ?? 0)
        cell.lblTotalDeaths.text = String(format: "%d", model.deaths ?? 0)
        cell.lblTotalRecovered.text = String(format: "%d", model.recovered ?? 0)
        return cell
    }
    
    
}

extension CoronaCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
}
