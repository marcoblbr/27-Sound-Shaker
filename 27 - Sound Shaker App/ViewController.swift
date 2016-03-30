//
//  ViewController.swift
//  26 - Shake and Swipe
//
//  Created by Marco on 7/31/15.
//  Copyright (c) 2015 Marco. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var timer = NSTimer ()
    var player : AVAudioPlayer = AVAudioPlayer ()
    var files = ["sfx01", "sfx02", "sfx03", "sfx04", "sfx05"]
    
    // função é chamada quando ele termina de movimentar o celular
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        if event.subtype == UIEventSubtype.MotionShake {
            let randomSound = Int (arc4random_uniform (UInt32 (files.count)))
            
            switchToMusic (randomSound)
            
            player.play ()

            // muda pra figura com o texto boom aparecendo
            (view.viewWithTag (1) as! UIImageView).image = UIImage(named: "boom2.png")
            
            // o tempo de música é para durar apenas 2s. Logo, assim que ele
            // entrar na função result, o tempo será parado.
            timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector ("result"), userInfo: nil, repeats: true)
        }
    }

    func result (){
        // muda pra figura original
        (view.viewWithTag (1) as! UIImageView).image = UIImage(named: "boom1.png")
        
        player.stop()
        
        player.currentTime = 0

        timer.invalidate()
    }
    
    func switchToMusic (id : Int) {

        var error : NSError? = nil
        
        let string = files [id]
        
        var fileLocation =  NSBundle.mainBundle().URLForResource(string, withExtension: "mp3")!
        
        player = AVAudioPlayer (contentsOfURL: fileLocation, error: &error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


