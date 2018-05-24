//
//  FeedDetailsViewController.swift
//  RSS2
//
//  Created by A.S.Sahasranamam on 19/04/18.
//  Copyright © 2018 A.S.Sahasranamam. All rights reserved.
//

import UIKit
import AVKit

class FeedDetailsViewController: UIViewController {

    @IBOutlet weak var rssTitleLabel: UILabel!
    
    var rssItemsValue: RSSItem!
    
    @IBOutlet weak var rssDescriptionLabel: UILabel!
    
    var podcoastAVPlayer: AVPlayer!
    
    public var timer2: CMTime!
    
    @IBOutlet weak var playButton: UIButton!
    
   // @IBOutlet weak var slider: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var timer: UILabel!

    @IBOutlet weak var pauseButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        rssTitleLabel.text = rssItemsValue.Title
        rssDescriptionLabel.text = rssItemsValue.description
       

        
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        if !AppDelegate.isPodCastPlaying() {
            
            AppDelegate.initPodCast(WithPodCastUrl: rssItemsValue.enclosure)
            
        } else {
            
            self.playButton.isHidden = true

        }
        let playerItem = AppDelegate.mainAVPlayer.currentItem

        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        
        slider!.maximumValue = Float(seconds)
        slider!.isContinuous = false
        
        AppDelegate.mainAVPlayer!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if AppDelegate.mainAVPlayer.currentItem?.status == .readyToPlay || AppDelegate.isPodCastPlaying()  {
                let time : Float64 = CMTimeGetSeconds(AppDelegate.mainAVPlayer!.currentTime());
                self.slider!.value = Float ( time );
                self.timer.text =  String(self.slider.value)

            }
            
        }
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

    @IBAction func play(_ sender: Any) {
        
            AppDelegate.playPodCast(rssItemPlaying: rssItemsValue)
        if AppDelegate.isPodCastWaitingforPlay() {
            
            print("waiting to Play")
        }
        
        self.playButton.isHidden = true
        
    }
    
    @IBAction func pause(_ sender: Any) {
        
        AppDelegate.mainAVPlayer.pause()
        
        self.playButton.isHidden = false

    }

    
    @IBAction func changeAudioTime(_ sender: Any) {
        
        let seconds : Int64 = Int64(slider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        AppDelegate.mainAVPlayer!.seek(to: targetTime)
        
        if AppDelegate.mainAVPlayer!.rate == 0
        {
            AppDelegate.mainAVPlayer?.play()
        }
    }

    
    
    
}

    
