//
//  ViewController.swift
//  Scribe
//
//  Created by Darshan Gowda on 26/11/16.
//  Copyright © 2016 Darshan Gowda. All rights reserved.
//

import UIKit
import Speech
import AVFoundation


class ViewController: UIViewController,AVAudioPlayerDelegate {

    @IBOutlet weak var transcriptorTextField: UITextView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    var audiPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true
        
    }

    func requestSpeechAuth(){
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a"){
                    do{
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audiPlayer = sound
                        self.audiPlayer.play()
                        self.audiPlayer.delegate = self
                    }catch let err as NSError{
                        print(err.description)
                    }
                    
                    let recogniser = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recogniser?.recognitionTask(with: request, resultHandler: { (result, error) in
                        if let err = error{
                            print(err)
                        }
                        else{
                            self.transcriptorTextField.text = result?.bestTranscription.formattedString
                        }
                    })
                    
                }
            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        requestSpeechAuth()
        
    }
    
}

