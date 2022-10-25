//
//  MusicPlayerViewController.swift
//  MusicApp
//
//  Created by Ungurean Valentina on 12.07.2022.
//

import UIKit
import MusicKit
import MediaPlayer

final class MusicPlayerViewController: UIViewController {
  
  var mediaPlayer: MusicKitPlayer!
  
  init(album: MusicKit.Album) {
    
    do {
      if let albumPlayParams = album.playParameters {
        let data = try JSONEncoder().encode(albumPlayParams)
        let playParameters = try JSONDecoder().decode(MPMusicPlayerPlayParameters.self, from: data)
        let queue = MPMusicPlayerPlayParametersQueueDescriptor(playParametersQueue: [playParameters])
        let player = MPMusicPlayerController.applicationMusicPlayer
        player.setQueue(with: queue)
        mediaPlayer = MusicKitPlayer(player: player)
        mediaPlayer.translatesAutoresizingMaskIntoConstraints = false
      } else {
        print("PLAY PARAMS NOT AVAILABLE")
      }
    } catch {
      print(error)
    }
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    title = Constants.playerScreen.title
    addBlurredView()
    view.addSubview(mediaPlayer)
    setupConstraints()
  }
  
  private func addBlurredView() {
    if !UIAccessibility.isReduceMotionEnabled {
      self.view.backgroundColor = UIColor.clear
      let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = self.view.bounds
      blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      
      view.addSubview(blurEffectView)
    } else {
      view.backgroundColor = UIColor.black
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      mediaPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mediaPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mediaPlayer.topAnchor.constraint(equalTo: view.topAnchor),
      mediaPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    mediaPlayer.play()
    UIApplication.shared.isIdleTimerDisabled = true
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    mediaPlayer.stop()
    UIApplication.shared.isIdleTimerDisabled = false
  }
}
