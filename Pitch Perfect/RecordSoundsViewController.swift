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
    
    // This is the instance of audio that we will be passing to the other View Controller when we segue.
    var audio: RecordedAudio!
    var paused: Bool = false
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {readyToRecord()}

    // In order to record we have to set the category of the session and then open up a recorder to the file path.
    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.text = "Recording in Progress"
        okayToStartRecording(false)
        
        if(!paused) {
            do {try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)} catch {}
        
            do {try recorder = AVAudioRecorder(URL: NSURL.fileURLWithPathComponents([NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String, "recording.wav"])!, settings: [AVSampleRateKey: 44100.0])} catch {}
            recorder.meteringEnabled = true
            recorder.delegate = self
            recorder.prepareToRecord()
        }
        recorder.record()
    }
    
    // Stop the recorder and deactivate the session when stop is pressed.
    @IBAction func stopRecording(sender: UIButton) {
        recorder.stop()
        do {try AVAudioSession.sharedInstance().setActive(false)} catch {}
    }
    
    // When we pause, the message should say "Tap Mic to Continue" instead of "Tap Mic to Record"
    @IBAction func pauseRecording(sender: UIButton) {
        recorder.pause()
        recordingLabel.text = "Tap Mic to Continue"
        okayToStartRecording(true)
        paused = true
    }

    // After pressing stop, the recording will eventually finish, and then call the segue.
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            audio = RecordedAudio(url: recorder.url, tit: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: audio)
        } else {readyToRecord()}
    }
    
    // We want to make sure that the destination View Controller knows the audio recording for playback.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            (segue.destinationViewController as! PlaySpeedsViewController).audio = sender as! RecordedAudio
        }
    }
    
    // Called when we are ready to start a new recording.
    func readyToRecord() {
        recordingLabel.text = "Tap Mic to Record"
        okayToStartRecording(true)
        paused = false
    }
    
    // Called when we might begin or continue recording.
    func okayToStartRecording(ok: Bool) {
        stopButton.hidden = ok
        pauseButton.hidden = ok
        recordButton.enabled = ok
    }
}

