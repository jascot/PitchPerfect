//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jason Scott Timmerman on 7/20/15.
//  Copyright (c) 2015 Jason Scott Timmerman. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var recorder: AVAudioRecorder!
    var audio: RecordedAudio!
    var paused: Bool = false
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {readyToRecord()}

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.text = "Recording in Progress"
        stopButton.hidden = false
        pauseButton.hidden = false
        recordButton.enabled = false
        
        if(!paused) {
            do {try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)} catch {}
        
            do {try recorder = AVAudioRecorder(URL: NSURL.fileURLWithPathComponents([NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String, "recording.wav"])!, settings: [AVSampleRateKey: 44100.0])} catch {}
            recorder.meteringEnabled = true
            recorder.delegate = self
            recorder.prepareToRecord()
        }
        recorder.record()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recorder.stop()
        do {try AVAudioSession.sharedInstance().setActive(false)} catch {}
    }
    
    @IBAction func pauseRecording(sender: UIButton) {
        recorder.pause()
        recordingLabel.text = "Tap Mic to Continue"
        stopButton.hidden = true
        pauseButton.hidden = true
        recordButton.enabled = true
        paused = true
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            audio = RecordedAudio(url: recorder.url, tit: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: audio)
        } else {readyToRecord()}
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            (segue.destinationViewController as! PlaySpeedsViewController).audio = sender as! RecordedAudio
        }
    }
    
    func readyToRecord() {
        recordingLabel.text = "Tap Mic to Record"
        stopButton.hidden = true
        pauseButton.hidden = true
        recordButton.enabled = true
        paused = false
    }
}

