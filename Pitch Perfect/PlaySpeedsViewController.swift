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
    
    var engine: AVAudioEngine!
    var player: AVAudioPlayer!
    var audio: RecordedAudio!
    var effect: AVAudioUnitTimePitch!
    var file: AVAudioFile!
    
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {try player = AVAudioPlayer(contentsOfURL: audio.filePathUrl)} catch {}
        engine = AVAudioEngine()
        effect = AVAudioUnitTimePitch()
        engine.attachNode(effect)
        engine.connect(effect, to: engine.outputNode, format: nil)
        
        do {try file = AVAudioFile(forReading: audio.filePathUrl)} catch {}
        
        player.prepareToPlay()
        player.delegate = self
        player.enableRate = true
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
    
    
    @IBAction func stopAudio(sender: UIButton) {
        player.stop()
        engine.stop()
        stopButton.hidden = true
    }
    
    func startAudio() {
        effect.rate = pow (2.0, speedSlider.value)
        effect.pitch = pitchSlider.value
        
        player.stop()
        engine.stop()
        engine.reset()
        player.currentTime = 0.0
        
        let playerNode = AVAudioPlayerNode()
        engine.attachNode(playerNode)
        engine.connect(playerNode, to: effect, format: nil)
        
        playerNode.scheduleFile(file, atTime: nil, completionHandler: nil)
        
        do {try self.engine.start()} catch {}
        
        playerNode.play()
        stopButton.hidden = false
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        stopButton.hidden = true
    }
}
