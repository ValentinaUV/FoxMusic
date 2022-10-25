//
//  MusicKitPlayer.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 05.10.2022.
//

import UIKit
import MusicKit
import MediaPlayer

final class MusicKitPlayer: UIView {
  
  var player: MPMusicPlayerController
  
  private lazy var coverWidth: Double = {
    return UIScreen.main.bounds.width * 0.66
  } ()
  
  private lazy var cover: UIImageView = {
    let view = UIImageView(frame: CGRect(x: 0, y: 0, width: coverWidth, height: coverWidth))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.roundedImage()
    view.layer.borderWidth = 15.0
    view.layer.borderColor = UIColor.black.cgColor
    return view
  }()
  
  private lazy var coverCircle: UIImageView = {
    let width = UIScreen.main.bounds.width * 0.52
    let lineWidth = 1.0
    let view = UIImageView()
    view.drawCircle(
      size: CGSize(width: width + 2, height: width + 2),
      fillColor: UIColor.black.withAlphaComponent(0.0).cgColor,
      strokeColor: UIColor(named: "orange")?.cgColor ?? UIColor.systemOrange.cgColor,
      lineWidth: lineWidth,
      rectangle: CGRect(x: lineWidth, y: lineWidth, width: width, height: width),
      mode: .fillStroke)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var coverCircleCenter: UIImageView = {
    let width = 35.0
    let lineWidth = 12.0
    let view = UIImageView()
    view.drawCircle(
      size: CGSize(width: width + lineWidth, height: width + lineWidth),
      fillColor: UIColor.black.cgColor,
      strokeColor: UIColor(named: "orange")?.cgColor ?? UIColor.systemOrange.cgColor,
      lineWidth: lineWidth,
      rectangle: CGRect(x: 6, y: 6, width: width, height: width),
      mode: .fillStroke)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var progressArc: CircularSlider = {

    var options = CircularSliderOptions()
    options.barColor = UIColor.init(named: "darkGrey") ?? .darkGray
    options.thumbColor = UIColor(named: "orange") ?? .systemOrange
    let slider = CircularSlider(frame: bounds, options: options)
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.backgroundColor = UIColor.black.withAlphaComponent(0.0)
    slider.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
    return slider
  }()
  
  private lazy var elapsedTimeLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = .systemFont(ofSize: 14)
    view.text = "00:00"
    view.textColor = .white
    return view
  }()
  
  private lazy var remainingTimeLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = .systemFont(ofSize: 14)
    view.text = "00:00"
    view.textColor = .white
    return view
  }()
  
  private lazy var artistNameLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = .systemFont(ofSize: 16)
    view.textColor = .white
    return view
  }()
  
  private lazy var songNameLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = .systemFont(ofSize: 20, weight: .bold)
    view.textColor = UIColor.systemOrange
    return view
  }()
  
  private lazy var collectionName: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = .systemFont(ofSize: 16)
    view.textColor = .white
    return view
  }()
  
  private lazy var previousButton: UIButton = {
    let view = UIButton()
    view.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 30)
    view.setImage(UIImage.init(systemName: "backward", withConfiguration: config), for: .normal)
    view.addTarget(self, action: #selector(didTapPrevious(_:)), for: .touchUpInside)
    view.tintColor = .white
    return view
  }()
  
  private lazy var playPauseButton: UIButton = {
    let view = UIButton()
    view.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 70)
    view.setImage(UIImage.init(systemName: "play.circle", withConfiguration: config), for: .normal)
    view.addTarget(self, action: #selector(didTapPlayPause(_:)), for: .touchUpInside)
    view.tintColor = UIColor(named: "orange") ?? .systemOrange
    return view
  }()
  
  private lazy var nextButton: UIButton = {
    let view = UIButton()
    view.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 30)
    view.setImage(UIImage.init(systemName: "forward", withConfiguration: config), for: .normal)
    view.addTarget(self, action: #selector(didTapNext(_:)), for: .touchUpInside)
    view.tintColor = .white
    return view
  }()
  
  private lazy var controlStack: UIStackView = {
    let view = UIStackView(arrangedSubviews: [previousButton, playPauseButton, nextButton])
    view.translatesAutoresizingMaskIntoConstraints = false
    view.axis = .horizontal
    view.distribution = .equalSpacing
    view.spacing = 20
    return view
  }()
  
  var isPaused: Bool!
  private var timer: Timer?
  private var playingIndex = 0
  
  init(player: MPMusicPlayerController) {
    self.player = player
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    backgroundColor = UIColor(named: "darkColor")
    
    isPaused = false
    setPlayPauseIcon(isPlaying: true)
    setupTimer()

    [collectionName, cover, coverCircle, coverCircleCenter, songNameLabel, artistNameLabel, progressArc, elapsedTimeLabel, remainingTimeLabel, controlStack].forEach { v in
      addSubview(v)
    }
    setupConstraints()
  }
  
  private func setupTimer() {
    if timer == nil {
      timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateProgress(_:)), userInfo: nil, repeats: true)
    }
  }
  
  private func setupConstraints() {
    //cover
    NSLayoutConstraint.activate([
      cover.centerXAnchor.constraint(equalTo: centerXAnchor),
      cover.topAnchor.constraint(equalTo: topAnchor, constant: 120),
      cover.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65),
      cover.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65)
    ])
    
    //cover circle
    NSLayoutConstraint.activate([
      coverCircle.centerXAnchor.constraint(equalTo: cover.centerXAnchor),
      coverCircle.centerYAnchor.constraint(equalTo: cover.centerYAnchor),
    ])
    
    //cover circle center
    NSLayoutConstraint.activate([
      coverCircleCenter.centerXAnchor.constraint(equalTo: cover.centerXAnchor),
      coverCircleCenter.centerYAnchor.constraint(equalTo: cover.centerYAnchor),
    ])
    
    //progress arc
    NSLayoutConstraint.activate([
      progressArc.centerXAnchor.constraint(equalTo: cover.centerXAnchor),
      progressArc.centerYAnchor.constraint(equalTo: cover.centerYAnchor),
      progressArc.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.85),
      progressArc.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.85)
    ])
    
    //elapsed time
    NSLayoutConstraint.activate([
      elapsedTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      elapsedTimeLabel.bottomAnchor.constraint(equalTo: progressArc.centerYAnchor, constant: -15)
    ])
    
    //remaining time
    NSLayoutConstraint.activate([
      remainingTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      remainingTimeLabel.bottomAnchor.constraint(equalTo: progressArc.centerYAnchor, constant: -15)
    ])
    
    //artist name
    NSLayoutConstraint.activate([
      artistNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      artistNameLabel.topAnchor.constraint(equalTo: progressArc.bottomAnchor, constant: 20)
    ])
    
    //song name
    NSLayoutConstraint.activate([
      songNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      songNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8)
    ])
    
    //collection name
    NSLayoutConstraint.activate([
      collectionName.centerXAnchor.constraint(equalTo: centerXAnchor),
      collectionName.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 8)
    ])
  
    //control stack
    NSLayoutConstraint.activate([
      controlStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
      controlStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
      controlStack.topAnchor.constraint(equalTo: collectionName.bottomAnchor, constant: 20)
    ])
  }
  
  func play() {
    progressArc.value = 0.0
    player.play()
    updateView()
    
    if player.playbackState == MPMusicPlaybackState.playing {
      setPlayPauseIcon(isPlaying: true)
    }
  }
  
  private func updateView() {
    collectionName.text = player.nowPlayingItem?.albumTitle
    cover.image = player.nowPlayingItem?.artwork?.image(at: CGSize(width: coverWidth, height: coverWidth))
    songNameLabel.text = player.nowPlayingItem?.title
    artistNameLabel.text = player.nowPlayingItem?.artist
    progressArc.maxValue = CGFloat(player.nowPlayingItem?.playbackDuration ?? 0.0)
  }
  
  func stop() {
    player.stop()
    timer?.invalidate()
    timer = nil
  }
  
  private func setPlayPauseIcon(isPlaying: Bool) {
    let config = UIImage.SymbolConfiguration(pointSize: 70)
    playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.circle" : "play.circle", withConfiguration: config), for: .normal)
  }
  
  @objc private func updateProgress(_ sender: Timer) {
    progressArc.value = CGFloat(player.currentPlaybackTime)
    elapsedTimeLabel.text = getFormattedTime(timeInterval: player.currentPlaybackTime)
    var remainingTime = 0.0
    if let duration = player.nowPlayingItem?.playbackDuration {
      remainingTime = duration - player.currentPlaybackTime
    }
    remainingTimeLabel.text = getFormattedTime(timeInterval: remainingTime)
    
    if elapsedTimeLabel.text == "00:00" {
      updateView()
    }
  }
  
  @objc private func progressScrubbed(_ sender: CircularSlider) {
    player.currentPlaybackTime = Float64(sender.value)
  }
  
  @objc private func didTapPrevious(_ sender: UIButton) {
    player.skipToPreviousItem()
    if player.playbackState == MPMusicPlaybackState.playing {
      setPlayPauseIcon(isPlaying: true)
    }
  }
  
  @objc private func didTapPlayPause(_ sender: UIButton) {
    if player.playbackState == MPMusicPlaybackState.playing {
      setPlayPauseIcon(isPlaying: false)
      player.pause()
      player.stop()
    } else {
      setPlayPauseIcon(isPlaying: true)
      player.play()
    }
  }
  
  @objc private func didTapNext(_ sender: UIButton) {
    player.skipToNextItem()
    if player.playbackState == MPMusicPlaybackState.playing {
      setPlayPauseIcon(isPlaying: true)
    }
  }
  
  private func getFormattedTime(timeInterval: TimeInterval) -> String {
    let mins = timeInterval / 60
    let seconds = timeInterval.truncatingRemainder(dividingBy: 60)
    let timeFormatter = NumberFormatter()
    timeFormatter.minimumIntegerDigits = 2
    timeFormatter.minimumFractionDigits = 0
    timeFormatter.roundingMode = .down
    
    guard var minsString = timeFormatter.string(from: NSNumber(value: mins)), var secondsString = timeFormatter.string(from: NSNumber(value: seconds)) else {
      return "00:00"
    }
    if minsString == "-00" {
      minsString = "00"
    }
    if secondsString == "-00" {
      secondsString = "00"
    }
    
    return "\(minsString):\(secondsString)"
  }
}
