//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    let eggTimes = [
        "Soft": 3 ,
        "Medium": 4,
        "Hard": 7
    ]
    var player: AVAudioPlayer?
    
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    
    
    @IBOutlet weak var headLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    
    @objc func updateCounter(type: Int) {
        
        if secondPassed < totalTime  {
            secondPassed += 1
            let percentageProgress = Float(secondPassed) / Float(totalTime)
            progressView.progress = percentageProgress
            
        } else {
           timer.invalidate()
            playSound()
           headLabel.text = "Done."
        }
        
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        //invalidate for multi click button
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!

       //default
       progressView.progress = 0.0
       secondPassed = 0
       headLabel.text = hardness
        
      
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
      
        

    }
    
    
}
