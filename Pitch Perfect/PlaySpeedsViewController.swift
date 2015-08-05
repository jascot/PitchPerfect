//
//  PlaySpeedsViewController.swift
//  Pitch Perfect
//
//  Created by Jason Scott Timmerman on 7/20/15.
//  Copyright (c) 2015 Jason Scott Timmerman. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySpeedsViewController: UIViewController {
    
    var instances: [AudioInstance]! = [AudioInstance]()
    var audio: RecordedAudio!

    var echo = false
    var reverb = false
    
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...20 {
            instances.append(AudioInstance(audio: audio))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playSlowly(sender: UIButton) {
        speedSlider.value = -0.8
        startAudio()
    }

    @IBAction func playQuickly(sender: UIButton) {
        speedSlider.value = 0.8
        startAudio()
    }

    @IBAction func normalSpeed(sender: UIButton) {
        speedSlider.value = 0.0
        startAudio()
    }
    
    @IBAction func speedSliderChanged(sender: UISlider) {
        startAudio()
    }
    
    @IBAction func playHighPitched(sender: UIButton) {
        pitchSlider.value = 800.0
        startAudio()
    }

    @IBAction func playLowPitched(sender: UIButton) {
        pitchSlider.value = -800.0
        startAudio()
    }
    
    @IBAction func normalPitch(sender: UIButton) {
        pitchSlider.value = 0.0
        startAudio()
    }
    
    @IBAction func pitchSliderChanged(sender: UISlider) {
        startAudio()
    }
    
    @IBAction func echoClicked(sender: UIButton) {
        echo = !echo
        echoButton.alpha = echo ? 1.0 : 0.6
        startAudio()
    }
    
    @IBAction func reverbClicked(sender: UIButton) {
        reverb = !reverb
        reverbButton.alpha = reverb ? 1.0 : 0.6
        startAudio()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        for i in instances {i.stop()}
    }
    
    func startAudio() {
        stopAudio(stopButton)
        for x in 0...(echo ? 2 : 0) {
            for y in 0...(reverb ? 6 : 0) {
                let v = pow(0.3, Float(x)) * pow(1.6, Float(reverb ? y - 5 : 0))
                instances[x + (y * 3)].playAudio(speedSlider.value, pitch: pitchSlider.value, volume: v, delay: Double(x) * 0.3 + Double(y) * 0.05)
            }
        }        
    }
}
