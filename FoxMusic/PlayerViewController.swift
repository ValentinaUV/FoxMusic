//
//  PlayerViewController.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 04.10.2022.
//

import UIKit
import AVFoundation
import AVKit

class PlayerViewController: UIViewController {
  
  var player:AVPlayer?
     var playerItem:AVPlayerItem?
     var playButton:UIButton?
     
   override func viewDidLoad() {
     super.viewDidLoad()
   }
     
   override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     
//     let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
     let url = URL(string: "https://music.apple.com/ro/album/go-down-deh-feat-sean-paul-shaggy/1563274810?i=1563274812")
//     let url = URL(string: "https://music.apple.com/ro/album/boombastic/775997117?i=775997122")
//     playList.add("https://www.bensound.org/bensound-music/bensound-happyrock.mp3")
//     playList.add("https://www.bensound.org/bensound-music/bensound-summer.mp3")
//     playList.add("https://www.bensound.org/bensound-music/bensound-creativeminds.mp3")
     let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
     player = AVPlayer(playerItem: playerItem)
     
     let playerLayer=AVPlayerLayer(player: player!)
     playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
     self.view.layer.addSublayer(playerLayer)
     
     playButton = UIButton(type: UIButton.ButtonType.system) as UIButton
     let xPostion:CGFloat = 50
     let yPostion:CGFloat = 100
     let buttonWidth:CGFloat = 150
     let buttonHeight:CGFloat = 45
     
     playButton!.frame = CGRect(x: xPostion, y: yPostion, width: buttonWidth, height: buttonHeight)
     playButton!.backgroundColor = UIColor.lightGray
     playButton!.setTitle("Play", for: UIControl.State.normal)
     playButton!.tintColor = UIColor.black
     playButton!.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
     
     self.view.addSubview(playButton!)
   }
  
  @objc func playButtonTapped(_ sender:UIButton)
     {
         if player?.rate == 0
         {
         
             player!.play()
           print("debug player: \(player.debugDescription)")
           print(player?.currentItem)
           print("PLAYER ERROR: \(player?.error?.localizedDescription)")
             
             //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
             playButton!.setTitle("Pause", for: UIControl.State.normal)

         } else {
             player!.pause()
             //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
             playButton!.setTitle("Play", for: UIControl.State.normal)
         }
     }
}
