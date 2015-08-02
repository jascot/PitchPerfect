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
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        recordingLabel.text = "Tap Mic to Record"
        stopButton.hidden = true
        recordButton.enabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.text = "Recording in Progress"
        stopButton.hidden = false
        recordButton.enabled = false
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {}
        
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        do {
            try recorder = AVAudioRecorder(URL: NSURL.fileURLWithPathComponents([dirPath, "recording.wav"])!, settings: [AVSampleRateKey: 44100.0])
        } catch {}
        recorder.meteringEnabled = true
        recorder.prepareToRecord()
        recorder.record()
        recorder.delegate = self
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recorder.stop()
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {}
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            audio = RecordedAudio(url: recorder.url, tit: recorder.url.lastPathComponent!)
        
            self.performSegueWithIdentifier("stopRecording", sender: audio)
        } else {
            recordingLabel.text = "Tap Mic to Record"
            stopButton.hidden = true
            recordButton.enabled = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            (segue.destinationViewController as! PlaySpeedsViewController).audio = sender as! RecordedAudio
        }
    }
    
    
}

