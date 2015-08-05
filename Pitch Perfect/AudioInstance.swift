//
//  AudioInstance.swift
//  Pitch Perfect
//
//  Created by Jason Scott Timmerman on 8/5/15.
//  Copyright © 2015 Jason Scott Timmerman. All rights reserved.
//

import Foundation
import AVFoundation

class AudioInstance: NSObject {
    var engine: AVAudioEngine!
    var player: AVAudioPlayer!
    var effect: AVAudioUnitTimePitch!
    var file: AVAudioFile!
    var node: AVAudioPlayerNode!
    
    init(audio: RecordedAudio, delegate: AVAudioPlayerDelegate) {
        do {try player = AVAudioPlayer(contentsOfURL: audio.filePathUrl)} catch {}
        engine = AVAudioEngine()
        effect = AVAudioUnitTimePitch()

        engine.attachNode(effect)
        engine.connect(effect, to: engine.outputNode, format: nil)

        do {try file = AVAudioFile(forReading: audio.filePathUrl)} catch {}
        
        player.prepareToPlay()
        player.delegate = delegate
        player.enableRate = true
    }
    
    func playAudioIn(delay: NSTimeInterval) {
        player.stop()
        engine.stop()
        engine.reset()
        player.currentTime = 0
        
        node = AVAudioPlayerNode()
        
        engine.attachNode(node)
        engine.connect(node, to: effect, format: nil)

        do {try self.engine.start()} catch {}

        node.scheduleFile(file, atTime: nil, completionHandler: nil)
        node.playAtTime(AVAudioTime(hostTime: AVAudioTime.hostTimeForSeconds(player.deviceCurrentTime + delay)))
    }
    
    func setEffect(speed: Float, pitch: Float) {
        effect.rate = pow (2.0, speed)
        effect.pitch = pitch
    }
    
    func stop() {
        player.stop()
        engine.stop()
    }
}