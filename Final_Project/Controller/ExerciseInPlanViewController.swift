//
//  ExerciseInPlanViewController.swift
//  Final_Project
//
//  Created by ofir kariv on 5/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class ExerciseInPlanViewController: UIViewController {
    
    var secondsVar = 30
    var timer = Timer()
    var audioPlayer = AVAudioPlayer()

    @IBOutlet weak var numberOfSets: UILabel!
    @IBOutlet weak var numberOfRepeats: UILabel!
    @IBOutlet weak var viewYouTube: UIWebView!
    @IBOutlet weak var exDescr: UILabel!
    @IBOutlet weak var seconds: UILabel!
   
   
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBAction func slider(_ sender: UISlider) {
        secondsVar = Int(sender.value)
        var numTxt = secondsVar
        seconds.text = String(numTxt) + " seconds"
    }
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBAction func start(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ExerciseInPlanViewController.counter), userInfo: nil, repeats: true)
    }
    
    @objc func counter(){
        secondsVar -= 1
        seconds.text = String(secondsVar) + " seconds"
        if secondsVar == 0 {
            
            timer.invalidate()
            audioPlayer.play()
            
            var reps = Int(numberOfRepeats.text!)
            reps = reps!-1
            numberOfRepeats.text = String(reps!)
        }
    }
    
    @IBOutlet weak var stopOutlet: UIButton!
    @IBAction func stop(_ sender: AnyObject) {
        audioPlayer.stop()
        timer.invalidate()
        secondsVar = 30
        sliderOutlet.setValue(30, animated: true)
        seconds.text = "30" + " seconds"
    }
    
    
    
    
    @IBOutlet weak var sets: UILabel!
    
    @IBOutlet weak var repeats: UILabel!
    
     var currentUser : User?
     var exercise : Exercise?
    
    override func viewDidLoad() {
    super.viewDidLoad()
        do {
        let audioPath = Bundle.main.path(forResource: "alarm", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch{
            //print error
            
        }
    if let exe = exercise {
        numberOfSets.text = exe.numOfSets
        numberOfRepeats.text = exe.numOfRepeats
        secondsVar = Int(exe.numOfRestTime!)!
        
        seconds.text = exe.numOfRestTime! + " seconds"
        exDescr.text = exe.execDescription
        sliderOutlet.setValue(Float(secondsVar), animated: true)
        let youtubeurl = exe.urlVideo
        print(youtubeurl)
        viewYouTube.allowsInlineMediaPlayback = true
        viewYouTube.loadHTMLString("<iframe width=\"\(viewYouTube.frame.width)\" height=\"\(viewYouTube.frame.height)\" src=\"\(youtubeurl)? &playsline=1\" frameborder=\"0\" gesture=\"media\" allow=\"encrypted-media\" allowfullscreen></iframe>", baseURL: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
