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

    var audio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3") {
            audio = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path), error: nil)
            
            audio.prepareToPlay()
            audio.delegate = self
            audio.enableRate = true
            
    }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlowly(sender: UIButton) {
        audio.rate = 0.5
        audio.play()
    }

    @IBAction func playQuickly(sender: UIButton) {
        audio.rate = 2.0
        audio.play()
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
