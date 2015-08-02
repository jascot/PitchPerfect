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

    var player: AVAudioPlayer!
    var audio: RecordedAudio!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path), error: nil)
            
            player.prepareToPlay()
            player.delegate = self
            player.enableRate = true
            
    }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowly(sender: UIButton) {
        player.rate = 0.5
        restartAudio()
    }

    @IBAction func playQuickly(sender: UIButton) {
        player.rate = 2.0
        restartAudio()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        player.stop()
        stopButton.hidden = true
    }
    
    func restartAudio() {
        player.stop()
        player.currentTime = 0.0
        player.play()
        stopButton.hidden = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
