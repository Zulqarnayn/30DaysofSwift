//
//  ViewController.swift
//  Day_1_StopWatch
//
//  Created by Asif Mujtaba on 3/26/20.
//  Copyright © 2020 Asif Mujtaba. All rights reserved.
//

import UIKit

enum timerState {
    case running, stopped
}

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var lblStopWatch: UILabel!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    //MARK: - variables
    var currentTimerState: timerState = .stopped
    var timer: Timer?
    var counter = 0
    
    //MARK: - status bar
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK: - life cycle method
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - outlet methods
    @IBAction func btnPlayPauseAction(_ sender: UIButton) {
        if currentTimerState == .stopped {
            currentTimerState = .running
            btnPlayPause.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            
            if (timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
        }
        else {
            stopTimer()
        }
    }
    @IBAction func btnResetAction(_ sender: UIButton) {
        counter = 0
        lblStopWatch.text = "00:00:00"
        stopTimer()
    }
    
    @objc func updateTimer() {
        counter += 1
        
        let min = (counter / (100 * 60))
        var sec = (counter / 100)
        let msec = (counter % 100)
        
        sec = sec > 60 ?  sec % 60 : sec
        
        lblStopWatch.text = String(format: "%02d:%02d:%02d", min, sec, msec)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        currentTimerState = .stopped
        btnPlayPause.setImage(#imageLiteral(resourceName: "play"), for: .normal)
    }
}
