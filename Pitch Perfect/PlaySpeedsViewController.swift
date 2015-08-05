//
//  PlaySpeedsViewController.swift
//  Pitch Perfect
//
//  Created by Jason Scott Timmerman on 7/20/15.
//  Copyright (c) 2015 Jason Scott Timmerman. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySpeedsViewController: UIViewController, AVAudioPlayerDelegate {
    
    var i: AudioInstance!
    
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
        i = AudioInstance(audio: audio, delegate: self)
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
        i.stop()
        stopButton.hidden = true
    }
    
    func startAudio() {
        i.setEffect(speedSlider.value, pitch: pitchSlider.value)
        
        i.playAudioIn(5)
        stopButton.hidden = false
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        stopButton.hidden = true
    }
}
