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
    var exerciseArr = [Exercise]()
    var currentExe : Int = 0
    var flag : Bool = false
    var currentUser : User?
    var exercise : Exercise?
    var startIsOn : Bool = false
    @IBOutlet weak var sets: UILabel!
    @IBOutlet weak var repeats: UILabel!
    @IBOutlet weak var numberOfSets: UILabel!
    @IBOutlet weak var numberOfRepeats: UILabel!
    @IBOutlet weak var viewYouTube: UIWebView!
    @IBOutlet weak var exDescr2: UILabel!
    @IBOutlet weak var seconds: UILabel!
    @IBOutlet weak var exDescr: UITextView!
    
   
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBAction func slider(_ sender: UISlider) {
        secondsVar = Int(sender.value)
        var numTxt = secondsVar
        seconds.text = String(numTxt) + " seconds"
    }
    
    @IBOutlet weak var startOutlet: UIButton!
    @IBAction func start(_ sender: Any) {
        if(startIsOn == false &&  seconds.text != "0 seconds"){
           sliderOutlet.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ExerciseInPlanViewController.counter), userInfo: nil, repeats: true)
            startIsOn = true;
        }
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
    
    @IBAction func nextButton(_ sender: Any) {
        
        if exerciseArr.count <= currentExe+1 {
            // TODO: finish page
        }
        else {
            self.stop(self)
            currentExe = currentExe + 1
            exercise = exerciseArr[currentExe]
            viewDidAppear(true)
        }
    }
    
    @IBAction func prevButton(_ sender: Any) {
        if currentExe == 0 {
        }
        else {
            self.stop(self)
            currentExe = currentExe - 1
            exercise = exerciseArr[currentExe]
            viewDidAppear(true)
        }
    }
    @IBOutlet weak var stopOutlet: UIButton!
    @IBAction func stop(_ sender: AnyObject) {
        sliderOutlet.isHidden = false
        startIsOn = false;
        audioPlayer.stop()
        timer.invalidate()
        if let exe=exercise{
            let restTime = exe.numOfRestTime!
           // let restTime = exe.numOfRestTime! + " seconds"
            seconds.text = restTime + " seconds"
            secondsVar = (restTime as NSString).integerValue
            sliderOutlet.setValue((restTime as NSString).floatValue, animated: true)
       // seconds.text = "30" + " seconds"
        }
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        do {
        let audioPath = Bundle.main.path(forResource: "alarm", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        }
        catch{
            //print error
            
        }
   

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
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
