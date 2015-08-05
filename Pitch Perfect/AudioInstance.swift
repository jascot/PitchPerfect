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
    var mixer: AVAudioMixerNode!
    
    // We need the engine and effect for pitch effects, and the mixer so volumes can combine into echo and reverb effects.
    init(audio: RecordedAudio) {
        do {try player = AVAudioPlayer(contentsOfURL: audio.filePathUrl)} catch {}
        engine = AVAudioEngine()
        effect = AVAudioUnitTimePitch()
        mixer = AVAudioMixerNode()

        engine.attachNode(effect)
        engine.attachNode(mixer)
        engine.connect(effect, to: engine.outputNode, format: nil)

        do {try file = AVAudioFile(forReading: audio.filePathUrl)} catch {}
    }

    // We want to be able to play the clip at various speeds, pitches, volumes, and delays.
    func playAudio(speed: Float, pitch: Float, volume: Float, delay: NSTimeInterval) {
        engine.stop()
        engine.reset()

        node = AVAudioPlayerNode()
        node.volume = volume
        engine.attachNode(node)
        engine.connect(node, to: mixer, format: nil)
        engine.connect(mixer, to: effect, format: nil)
        effect.rate = pow (2.0, speed)
        effect.pitch = pitch
        
        do {try self.engine.start()} catch {}

        node.scheduleFile(file, atTime: nil, completionHandler: nil)
        node.playAtTime(AVAudioTime(hostTime: AVAudioTime.hostTimeForSeconds(player.deviceCurrentTime + delay)))
    }    
}