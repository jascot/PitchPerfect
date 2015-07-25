//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Jason Scott Timmerman on 7/20/15.
//  Copyright (c) 2015 Jason Scott Timmerman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        //TODO: Begin recording the audio clip
        recordingLabel.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
    }

    @IBAction func stopRecording(sender: UIButton) {
        //TODO: Stop recording audio
        recordingLabel.hidden = true
        stopButton.hidden = true
        recordButton.enabled = true
    
    }
}

