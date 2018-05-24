//
//  FeedTableViewCell.swift
//  RSS2
//
//  Created by A.S.Sahasranamam on 2/21/18.
//  Copyright © 2018 A.S.Sahasranamam. All rights reserved.
//

import UIKit
import AVKit

class FeedTableViewCell: UITableViewCell {

    let playable:Bool=false
    var url:String!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var palyPodcoast: AVPlayer!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!

    @IBOutlet weak var dateLabel: UILabel!
    
 

    @IBAction func play(_ sender: Any) {

        //    let cell =  btn.superview?.superview

        //        let indexPath = FeedTableViewCell.indexPath(for: cell as! UITableViewCell)




      let localPlayer = AVPlayer.init(url: URL.init(string:url!)!)
        print(localPlayer.currentItem!)
        localPlayer.play()

        self.palyPodcoast = localPlayer

        self.palyPodcoast.play()

        self.playButton.isHidden = true
    }
    
    @IBAction func hi(_ sender: Any) {
        print("hekllo")
        
        if self.palyPodcoast != nil {
            
            self.palyPodcoast.pause()

            self.playButton.isHidden = false

        }
    }

  
    var item : RSSItem! {
        
        didSet{
            titleLabel.text = item.Title
            descriptionLabel.text = item.description
            url = item.enclosure
        //    self.localplayer = player
         //   dateLabel.text = item.pubDate
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}

