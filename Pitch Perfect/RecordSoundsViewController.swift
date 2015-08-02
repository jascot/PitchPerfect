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
        recordingLabel.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        
        recorder = AVAudioRecorder(URL: NSURL.fileURLWithPathComponents([dirPath, "recording.wav"]), settings: nil, error: nil)
        recorder.meteringEnabled = true
        recorder.prepareToRecord()
        recorder.record()
        recorder.delegate = self
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recorder.stop()
        AVAudioSession.sharedInstance().setActive(false, error: nil)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag) {
            audio = RecordedAudio()
            audio.filePathUrl = recorder.url
            audio.title = recorder.url.lastPathComponent
        
            self.performSegueWithIdentifier("stopRecording", sender: audio)
        } else {
            recordingLabel.hidden = true
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

