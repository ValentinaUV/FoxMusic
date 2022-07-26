//
//  MediaPlayer.swift
//  MusicApp
//
//  Created by Ungurean Valentina on 11.07.2022.
//

import UIKit
import AVKit


final class MediaPlayer: UIView {
  
  var album: Album
  private lazy var albumName: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.textAlignment = .center
    view.font = .systemFont(ofSize: 32, weight: .bold)
    return view
  }()
  
  private lazy var albumCover: UIImageView = {
    let width = UIScreen.main.bounds.width * 0.66
    let view = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleAspectFill
    view.roundedImage()
    view.layer.borderWidth = 15.0
    view.layer.borderColor = UIColor.black.cgColor
    return view
  }()
  
  private lazy var albumCircle: UIImageView = {
    let width = UIScreen.main.bounds.width * 0.52
    let lineWidth = 1.0
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: width + 2, height: width + 2))
    let image = renderer.image { ctx in
      ctx.cgContext.setFillColor(UIColor.black.withAlphaComponent(0.0).cgColor)
      ctx.cgContext.setStrokeColor(UIColor(named: "orange")?.cgColor ?? UIColor.systemOrange.cgColor)
      ctx.cgContext.setLineWidth(lineWidth)
      
      let rectangle = CGRect(x: lineWidth, y: lineWidth, width: width, height: width)
      ctx.cgContext.addEllipse(in: rectangle)
      ctx.cgContext.drawPath(using: .fillStroke)
    }
    
    let view = UIImageView(image: image)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var albumCircleCenter: UIImageView = {
    let width = 35.0
    let lineWidth = 12.0
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: width + lineWidth, height: width + lineWidth))
    let image = renderer.image { ctx in
      ctx.cgContext.setFillColor(UIColor.black.cgColor)
      ctx.cgContext.setStrokeColor(UIColor(named: "orange")?.cgColor ?? UIColor.systemOrange.cgColor)
      ctx.cgContext.setLineWidth(lineWidth)
      
      let rectangle = CGRect(x: 6, y: 6, width: width, height: width)
      ctx.cgContext.addEllipse(in: rectangle)
      ctx.cgContext.drawPath(using: .fillStroke)
    }
    
    let view = UIImageView(image: image)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
//  private lazy var progressArc: UIControl = {
//    let options = [
//      ArcSliderOption.barColor(UIColor(named: "darkGrey") ?? UIColor.darkGray),
//      ArcSliderOption.thumbColor(UIColor(named: "orange") ?? UIColor.systemOrange),
//      ArcSliderOption.trackingColor(UIColor(named: "darkGrey") ?? UIColor.darkGray),
//      ArcSliderOption.barWidth(5),
//      ArcSliderOption.thumbWidth(20),
////      ArcSliderOption.thumbPosition(20),
//      ArcSliderOption.startAngle(-90),
//      ArcSliderOption.maxValue(90),
//      ArcSliderOption.minValue(0),
//      ArcSliderOption.sliderEnabled(true)
//    ]
//    let arcSlider = ArcSlider(frame: bounds, options: options)
//    arcSlider.translatesAutoresizingMaskIntoConstraints = false
//    arcSlider.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
////    view.addSubview(circleSlider)
//    return arcSlider
//  }()
  
  private lazy var progressArc: CircularSlider = {

    let slider = CircularSlider(frame: bounds, options: CircularSliderOptions())
    slider.translatesAutoresizingMaskIntoConstraints = false
    slider.backgroundColor = UIColor.black.withAlphaComponent(0.0)
//    slider.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
    return slider
  }()
  
  private lazy var progressBar: UISlider = {
    let view = UISlider()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
    view.minimumTrackTintColor = UIColor(named: "orange")
    view.thumbTintColor = UIColor(named: "orange")
    
    return view
  }()
  
  private lazy var elapsedTimeLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = .systemFont(ofSize: 14, weight: .light)
    view.text = "00:00"
    return view
  }()
  
  private lazy var remainingTimeLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = .systemFont(ofSize: 14, weight: .light)
    view.text = "00:00"
    return view
  }()
  
  private lazy var songNameLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = .systemFont(ofSize: 16, weight: .bold)
    return view
  }()
  
  private lazy var artistNameLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.font = .systemFont(ofSize: 16, weight: .light)
    return view
  }()
  
  private lazy var previousButton: UIButton = {
    let view = UIButton()
    view.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 30)
    view.setImage(UIImage.init(systemName: "backward.end.fill", withConfiguration: config), for: .normal)
    view.addTarget(self, action: #selector(didTapPrevious(_:)), for: .touchUpInside)
    view.tintColor = .white
    return view
  }()
  
  private lazy var playPauseButton: UIButton = {
    let view = UIButton()
    view.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 100)
    view.setImage(UIImage.init(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
    view.addTarget(self, action: #selector(didTapPlayPause(_:)), for: .touchUpInside)
    view.tintColor = .white
    return view
  }()
  
  private lazy var nextButton: UIButton = {
    let view = UIButton()
    view.translatesAutoresizingMaskIntoConstraints = false
    let config = UIImage.SymbolConfiguration(pointSize: 30)
    view.setImage(UIImage.init(systemName: "forward.end.fill", withConfiguration: config), for: .normal)
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
  
  private var player = AVAudioPlayer()
  private var timer: Timer?
  private var playingIndex = 0
  
  init(album: Album) {
    self.album = album
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    albumName.text = album.name
    albumCover.image = UIImage(named: album.image)
    backgroundColor = UIColor(named: "darkColor")
    setupPlayer(song: album.songs[playingIndex])
    [albumName, songNameLabel, artistNameLabel, elapsedTimeLabel, remainingTimeLabel].forEach { label in
      label.textColor = .white
    }
    [albumName, albumCover, albumCircle, albumCircleCenter, songNameLabel, artistNameLabel, progressArc, elapsedTimeLabel, remainingTimeLabel, controlStack].forEach { v in
      addSubview(v)
    }
    setupConstraints()
  }
  
  private func setupConstraints() {
    //album name
    NSLayoutConstraint.activate([
      albumName.leadingAnchor.constraint(equalTo: leadingAnchor),
      albumName.trailingAnchor.constraint(equalTo: trailingAnchor),
      albumName.topAnchor.constraint(equalTo: topAnchor, constant: 16)
    ])
    
    //album cover
    NSLayoutConstraint.activate([
      albumCover.centerXAnchor.constraint(equalTo: centerXAnchor),
      albumCover.topAnchor.constraint(equalTo: albumName.bottomAnchor, constant: 40),
      albumCover.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65),
      albumCover.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65)
    ])
    
    //album circle
    NSLayoutConstraint.activate([
      albumCircle.centerXAnchor.constraint(equalTo: albumCover.centerXAnchor),
      albumCircle.centerYAnchor.constraint(equalTo: albumCover.centerYAnchor),
    ])
    
    //album circle center
    NSLayoutConstraint.activate([
      albumCircleCenter.centerXAnchor.constraint(equalTo: albumCover.centerXAnchor),
      albumCircleCenter.centerYAnchor.constraint(equalTo: albumCover.centerYAnchor),
    ])
    
    //progress arc
    NSLayoutConstraint.activate([
      progressArc.centerXAnchor.constraint(equalTo: albumCover.centerXAnchor),
      progressArc.centerYAnchor.constraint(equalTo: albumCover.centerYAnchor),
//      progressArc.topAnchor.constraint(equalTo: albumCover.topAnchor),
      progressArc.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
      progressArc.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8)
    ])
    
    //progress bar
//    NSLayoutConstraint.activate([
//      progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//      progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//      progressBar.topAnchor.constraint(equalTo: albumCover.bottomAnchor, constant: 8)
//    ])
    
    //song name
    NSLayoutConstraint.activate([
      songNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      songNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      songNameLabel.topAnchor.constraint(equalTo: albumCover.bottomAnchor, constant: 32)
    ])
    
    //artist name
    NSLayoutConstraint.activate([
      artistNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      artistNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      artistNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 8)
    ])
    
    //elapsed time
    NSLayoutConstraint.activate([
      elapsedTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      elapsedTimeLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8)
    ])
    
    //remaining time
    NSLayoutConstraint.activate([
      remainingTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      remainingTimeLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8)
    ])
    
    //control stack
    NSLayoutConstraint.activate([
      controlStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
      controlStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
      controlStack.topAnchor.constraint(equalTo: remainingTimeLabel.bottomAnchor, constant: 8)
    ])
  }
  
  private func setupPlayer(song: Song) {
    guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
      return
    }
    
    if timer == nil {
      timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress(_:)), userInfo: nil, repeats: true)
    }
    
    songNameLabel.text = song.name
    artistNameLabel.text = song.artist
    
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player.delegate = self
      player.prepareToPlay()
      
      try AVAudioSession.sharedInstance().setCategory(.playback)
      try AVAudioSession.sharedInstance().setActive(true)
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func play() {
    progressBar.value = 0.0
    progressBar.maximumValue = Float(player.duration)
    player.play()
    setPlayPauseIcon(isPlaying: player.isPlaying)
  }
  
  func stop() {
    player.stop()
    timer?.invalidate()
    timer = nil
  }
  
  private func setPlayPauseIcon(isPlaying: Bool) {
    let config = UIImage.SymbolConfiguration(pointSize: 100)
    playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill", withConfiguration: config), for: .normal)
  }
  
  @objc private func updateProgress(_ sender: Timer) {
    progressBar.value = Float(player.currentTime)
    elapsedTimeLabel.text = getFormattedTime(timeInterval: player.currentTime)
    let remainingTime = player.duration - player.currentTime
    remainingTimeLabel.text = getFormattedTime(timeInterval: remainingTime)
  }
  
  @objc private func progressScrubbed(_ sender: ArcSlider) {
    player.currentTime = Float64(sender.value)
  }
  
  @objc private func didTapPrevious(_ sender: UIButton) {
    playingIndex -= 1
    if playingIndex < 0 {
      playingIndex = album.songs.count - 1
    }
    
    setupPlayer(song: album.songs[playingIndex])
    play()
    setPlayPauseIcon(isPlaying: player.isPlaying)
  }
  
  @objc private func didTapPlayPause(_ sender: UIButton) {
    if player.isPlaying {
      player.pause()
    } else {
      player.play()
    }
    
    setPlayPauseIcon(isPlaying: player.isPlaying)
  }
  
  @objc private func didTapNext(_ sender: UIButton) {
    playingIndex += 1
    if playingIndex >= album.songs.count {
      playingIndex = 0
    }
    
    setupPlayer(song: album.songs[playingIndex])
    play()
    setPlayPauseIcon(isPlaying: player.isPlaying)
  }
  
  private func getFormattedTime(timeInterval: TimeInterval) -> String {
    let mins = timeInterval / 60
    let seconds = timeInterval.truncatingRemainder(dividingBy: 60)
    let timeFormatter = NumberFormatter()
    timeFormatter.minimumIntegerDigits = 2
    timeFormatter.minimumFractionDigits = 0
    timeFormatter.roundingMode = .down
    
    guard let minsString = timeFormatter.string(from: NSNumber(value: mins)), let secondsString = timeFormatter.string(from: NSNumber(value: seconds)) else {
      return "00:00"
    }
    return "\(minsString):\(secondsString)"
  }

}

extension MediaPlayer: AVAudioPlayerDelegate {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    didTapNext(nextButton)
  }
}

extension UIImageView {
  func roundedImage() {
    self.layer.cornerRadius = (self.frame.size.width) / 2;
    self.clipsToBounds = true
//    self.layer.masksToBounds = false
  }
}
