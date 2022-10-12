//
//  MusicKitPlayer.swift
//  FoxMusic
//
//  Created by Valentina Ungurean on 05.10.2022.
//

import UIKit
import AVKit

final class MusicKitPlayer: UIView {
  
  var musicCollection: MusicCollection
  
  private lazy var cover: UIImageView = {
    let width = UIScreen.main.bounds.width * 0.66
    let view = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: width))
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
    let config = UIImage.SymbolConfiguration(pointSize: 60)
    view.setImage(UIImage.init(systemName: "play", withConfiguration: config), for: .normal)
    view.addTarget(self, action: #selector(didTapPlayPause(_:)), for: .touchUpInside)
    view.tintColor = .white
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
  
  private var player = AVAudioPlayer()
  var avPlayer: AVPlayer!
  var isPaused: Bool!
  private var timer: Timer?
  private var playingIndex = 0
  
  init(musicCollection: MusicCollection) {
    self.musicCollection = musicCollection
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    collectionName.text = musicCollection.getName()
    
    //here should be song's image
//    cover.image = UIImage(named: musicCollection.getImage())
    backgroundColor = UIColor(named: "darkColor")
    
    isPaused = false
//    playButton.setImage(UIImage(named:"pause"), for: .normal)
//    guard let songUrlString = playList[self.index] as? String else {return}
    guard let songUrl = musicCollection.getSong(index: playingIndex).getUrl() else {return}
    self.playUrl(url: songUrl)
//    self.setupTimer()
    
//    setupPlayer(song: musicCollection.getSong(index: playingIndex))
    [collectionName, cover, coverCircle, coverCircleCenter, songNameLabel, artistNameLabel, progressArc, elapsedTimeLabel, remainingTimeLabel, controlStack].forEach { v in
      addSubview(v)
    }
    setupConstraints()
  }
  
  func playUrl(url:URL) {
    let a = URL(string: "https://www.bensound.org/bensound-music/bensound-happyrock.mp3")
    self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url: a!))
      self.avPlayer.automaticallyWaitsToMinimizeStalling = false
      avPlayer!.volume = 1.0
      avPlayer.play()
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
  
  private func loadCoverImage(song: Song) {
    if let imageUrl = song.getImageUrl() {
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: imageUrl) {
          DispatchQueue.main.async {
            self.cover.image = UIImage(data: data)
          }
        }
      }
    }
  }
  
  
  
  
  
  func getLibraryDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)

    // just send back the first one, which ought to be the only one
    return paths[0]
  }
  
  private func saveDataFile(data:Data, fileName: String, folderName: String) -> URL {
     
    let directoryUrl = self.getLibraryDirectory().appendingPathComponent(folderName, isDirectory: true)
             
    do {
      try FileManager.default.createDirectory(at: directoryUrl, withIntermediateDirectories: true)
      print("Directory Creation -> Success \n \(directoryUrl)")
    } catch {
      print("Directory Creation -> Failed")
    }
     
    let url = directoryUrl.appendingPathComponent(fileName)
     
    do {
      try data.write(to: url, options: .atomic )
      print("File Writing -> Success")
    } catch {
      print("File Writing -> Error \n \(error.localizedDescription)")
    }
         
    return url
  }
  
  private func setupPlayer(song: Song) {
//    guard let url = Bundle.main.url(forResource: song.getUrl()?.description, withExtension: song.getFileExtension()) else {
//      return
//    }
    
//    guard let url = Bundle.main.url(forResource: song.getFileName(), withExtension: song.getFileExtension()) else {
//      return
//    }
    
    if timer == nil {
      timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateProgress(_:)), userInfo: nil, repeats: true)
    }
    
    loadCoverImage(song: song)
    songNameLabel.text = song.getName()
    artistNameLabel.text = song.getArtist()
    
    let storedURL: URL?
//    guard let path = Bundle.main.path(forResource: song.getUrl()?.absoluteString, ofType: song.getFileExtension()) else {
//      print("Sound file not found")
//      return
//    }
//    let url = URL(fileURLWithPath: path)
    guard let url = song.getUrl() else {
      print("no song url")
      return
    }
    
    downloadFileFromURL(url: url)
//    do {
//      let fileData = try Data(contentsOf: url)
//      storedURL = saveDataFile(data: fileData, fileName: "test.mp3", folderName: "testFolder")
//
//      print("File Writing on View -> Success \(storedURL?.description) ")
//
//      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//      let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
//      let playerItem:AVPlayerItem = AVPlayerItem(url: url)
//      player = AVPlayer(playerItem: playerItem)
//      player.delegate = self
//      player.prepareToPlay()
//
//      try AVAudioSession.sharedInstance().setCategory(.playback)
//      try AVAudioSession.sharedInstance().setActive(true)
//    } catch let error {
//      print(error.localizedDescription)
//    }
//    do {
////      player = try AVAudioPlayer(contentsOf: url)
//      guard let url = storedURL else {return}
//      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//      player.delegate = self
//      player.prepareToPlay()
//
//      try AVAudioSession.sharedInstance().setCategory(.playback)
//      try AVAudioSession.sharedInstance().setActive(true)
//    } catch let error {
//      print(error.localizedDescription)
//    }
  }
  
  func downloadFileFromURL(url: URL){
    var downloadTask:URLSessionDownloadTask
    downloadTask = URLSession.shared.downloadTask(with: url) { (url, response, error) in
        self.playSong(url: url!)
    }
    downloadTask.resume()
  }
  
  func playSong(url:URL) {
    do {
      let songData = try NSData(contentsOf: url, options: NSData.ReadingOptions.mappedIfSafe)
      try AVAudioSession.sharedInstance().setCategory(.playback)
      try AVAudioSession.sharedInstance().setActive(true)
      player = try AVAudioPlayer(data: songData as Data, fileTypeHint: AVFileType.mp3.rawValue)
      player.prepareToPlay()
      player.play()
      
      
      
      
//      player = try AVAudioPlayer(contentsOf: url as URL)
//      print("Let's play: \(url.description)")
//      player.delegate = self
//      player.prepareToPlay()

//      try AVAudioSession.sharedInstance().setCategory(.playback)
//      try AVAudioSession.sharedInstance().setActive(true)
      
//        player.prepareToPlay()
//        player.volume = 2.0
//      player.play()
    } catch let error as NSError {
      print("error here .....")
        print(error.localizedDescription)
    } catch {
        print("AVAudioPlayer init failed")
    }
      
  }
  
  
  func play() {
    progressArc.value = 0.0
    progressArc.maxValue = CGFloat(player.duration)
    player.play()
    setPlayPauseIcon(isPlaying: player.isPlaying)
  }
  
  func stop() {
    player.stop()
    timer?.invalidate()
    timer = nil
  }
  
  private func setPlayPauseIcon(isPlaying: Bool) {
    let config = UIImage.SymbolConfiguration(pointSize: 60)
    playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause" : "play", withConfiguration: config), for: .normal)
  }
  
  @objc private func updateProgress(_ sender: Timer) {
    progressArc.value = CGFloat(player.currentTime)
    elapsedTimeLabel.text = getFormattedTime(timeInterval: player.currentTime)
    let remainingTime = player.duration - player.currentTime
    remainingTimeLabel.text = getFormattedTime(timeInterval: remainingTime)
  }
  
  @objc private func progressScrubbed(_ sender: CircularSlider) {
    player.currentTime = Float64(sender.value)
  }
  
  @objc private func didTapPrevious(_ sender: UIButton) {
    playingIndex -= 1
    if playingIndex < 0 {
      playingIndex = musicCollection.getSongsCount() - 1
    }
    
    setupPlayer(song: musicCollection.getSong(index: playingIndex))
    play()
    setPlayPauseIcon(isPlaying: player.isPlaying)
  }
  
  @objc private func didTapPlayPause(_ sender: UIButton) {
    if player.isPlaying {
      player.pause()
      player.stop()
    } else {
      player.play()
    }
    
    setPlayPauseIcon(isPlaying: player.isPlaying)
  }
  
  @objc private func didTapNext(_ sender: UIButton) {
    playingIndex += 1
    if playingIndex >= musicCollection.getSongsCount() {
      playingIndex = 0
    }
    
    setupPlayer(song: musicCollection.getSong(index: playingIndex))
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

//extension MediaPlayer: AVAudioPlayerDelegate {
//  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//    didTapNext(nextButton)
//  }
//}
//
//extension UIImageView {
//  func roundedImage() {
//    self.layer.cornerRadius = (self.frame.size.width) / 2;
//    self.clipsToBounds = true
//  }
//}
