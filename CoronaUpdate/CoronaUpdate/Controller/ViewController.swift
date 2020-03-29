//
//  ViewController.swift
//  CoronaUpdate
//
//  Created by Asif Mujtaba on 3/27/20.
//  Copyright © 2020 Asif Mujtaba. All rights reserved.
//

import UIKit
import Reachability

enum sortedBy: Int {
    case none, ascending, descending
}

class ViewController: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    let reachability = try! Reachability()
    let refreshControl = UIRefreshControl()
    var coronaModels: [CoronaModel]?
    var casesSortType: sortedBy = .none
    var deathsSortType: sortedBy = .none
    var recoverStoryType: sortedBy = .none
    @IBOutlet weak var coronaCV: CoronaCollectionView!
    
    
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        fetchData()
    }
    
    func initialize() {
        coronaCV.customDelegate = self
        coronaCV.refreshControl = refreshControl
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        lblDescription.text = """
        Coronavirus Cases:
        \(0)
        
        Deaths:
        \(0)
        
        Recovered:
        \(0)
        """
    }
    
    @objc func refreshData(_ sender: Any) {
        fetchData()
        self.refreshControl.endRefreshing()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
           do{
             try reachability.startNotifier()
           }catch{
             print("could not start reachability notifier")
           }
    }
    
    func fetchData() {
        let session = URLSession.shared
        guard let url = URL(string: urlString) else {
             return
        }
        session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                self.coronaModels = try JSONDecoder().decode([CoronaModel].self, from: data)
                
                var cases = 0
                var death = 0
                var recover = 0
                
                for model in self.coronaModels! {
                    cases += model.cases ?? 0
                    death += model.deaths ?? 0
                    recover += model.recovered ?? 0
                }
                
                self.coronaCV.colData = self.coronaModels!
                DispatchQueue.main.async {
                    self.coronaCV.reloadData()
                    self.updateData(cases: cases, deaths: death, recovered: recover)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers )
//
//                self.coronaModels = [CoronaModel]()
//
//                var cases = 0
//                var death = 0
//                var recover = 0
//
//                for dictionary in json as! [[String: AnyObject]] {
//                    let model = CoronaModel.init(json: dictionary)
//
//                    self.coronaModels?.append(model)
//                    cases += model.cases?.intValue ?? 0
//                    death += model.deaths?.intValue ?? 0
//                    recover += model.recovered?.intValue ?? 0
//
//                }
//
//                self.coronaCV.colData = self.coronaModels!
//                DispatchQueue.main.async {
//                    self.coronaCV.reloadData()
//                    self.updateData(cases: cases, deaths: death, recovered: recover)
//                }
//
//
//
//            } catch let jsonError {
//                print(jsonError)
//            }
            
            
        }.resume()
    }
    
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
            print("Reachable via WiFi")
            fetchData()
      case .cellular:
            print("Reachable via Cellular")
            fetchData()
      case .unavailable:
            print("Network not reachable")
      case .none: break
        
        }
    }
    
    func updateData(cases: Int, deaths: Int, recovered: Int) {
        
        self.lblDescription.text = """
        Coronavirus Cases:
        \(cases)
        
        Deaths:
        \(deaths)
        
        Recovered:
        \(recovered)
        """
    }
    
    @IBAction func btnCasesAction(_ sender: UIButton) {
        var ascend = false
        if casesSortType == .none || casesSortType == .descending {
            casesSortType = .ascending
            ascend = true
        }
        else if casesSortType == .ascending {
            casesSortType = .descending
            ascend = false
        }
        
        coronaCV.sortBy(type: .cases, ascending: ascend)
    }
    
    @IBAction func btnDeathAction(_ sender: UIButton) {
        var ascend = false
        if deathsSortType == .none || deathsSortType == .descending {
            deathsSortType = .ascending
            ascend = true
        }
        else if deathsSortType == .ascending {
            deathsSortType = .descending
            ascend = false
        }
        coronaCV.sortBy(type: .deaths, ascending: ascend)
    }
    @IBAction func btnRecoverAction(_ sender: UIButton) {
        var ascend = false
        if recoverStoryType == .none || recoverStoryType == .descending {
            recoverStoryType = .ascending
            ascend = true
        }
        else if recoverStoryType == .ascending {
            recoverStoryType = .descending
            ascend = false
        }
        coronaCV.sortBy(type: .recover, ascending: ascend)
    }
    
    func showDetailsViewControllerWith(model: CoronaModel) {
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        detailVC.model = model
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
}

extension ViewController: CoronaCollectionViewDelegate {
    func tapped(model: CoronaModel) {
        showDetailsViewControllerWith(model: model)
    }
}
