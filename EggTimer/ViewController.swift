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
    
    // Make a dictionary to stores times for each egg type.
    let eggTimes = ["Soft" : 300, "Medium" : 420, "Hard" : 960]
    
    // Also make variables to track time.
    var secondsPassed: Int = 0
    var totalTime: Int = 60
    
    // Make a timer object.
    var timer = Timer()
    
    // AV Objects
    var player: AVAudioPlayer!
    
    // Outlets.
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Action function.
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Sets the progress bar to zero.
        progressBar.progress = 0
        timer.invalidate()
        
        // Sets the initial parameters.
        let hardness = sender.currentTitle!
        secondsPassed = 0
        totalTime = eggTimes[hardness]!
        topLabel.text = "\(hardness)!"
        
        // Sets the timer.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Updates the Seconds everytime the timer fires.
    @objc func updateTimer() {
        if(secondsPassed < totalTime) {
            // Update Seconds
            secondsPassed += 1
            
            // Update the progress bar.
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
            
        } else {
            // Invalidate timer and change label.
            timer.invalidate()
            topLabel.text = "Done!"
            
            // Play the sound
            playSound()
        }
    }
    
    // Play sound when timer is done.
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

}
