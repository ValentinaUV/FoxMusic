//
//  MediaPlayer.swift
//  MusicApp
//
//  Created by Ungurean Valentina on 26.07.2022.
//

import UIKit

enum ArcSliderOption {
    case startAngle(Double)
    case barColor(UIColor)
    case trackingColor(UIColor)
    case thumbColor(UIColor)
    case thumbImage(UIImage?)
    case barWidth(CGFloat)
    case thumbWidth(CGFloat)
    case maxValue(Float)
    case minValue(Float)
    case sliderEnabled(Bool)
    case viewInset(CGFloat)
    case minMaxSwitchTreshold(Float)
    case thumbPosition(Float)
}

enum ArcSliderStatus {
    case noChangeMinValue
    case inProgressChangeValue
    case reachedMaxValue
}

class ArcSlider: UIControl {
    var delegate: ArcSliderDelegate?
    var status: ArcSliderStatus {
        switch _value {
        case minValue:
            return ArcSliderStatus.noChangeMinValue
            
        case maxValue:
            return ArcSliderStatus.reachedMaxValue
            
        default:
            return ArcSliderStatus.inProgressChangeValue
        }
    }
    
    fileprivate let minThumbTouchAreaWidth: CGFloat = 44
    fileprivate var latestDegree: Double = 0
    fileprivate var _value: Float = 0
    var value: Float {
        get {
            return self._value
        }
        set {
            var value = newValue
            let significantChange = (self.maxValue - self.minValue) * (1.0 - self.minMaxSwitchTreshold)
          let isSignificantChangeOccured = abs(newValue - self._value) > significantChange
            
            if isSignificantChangeOccured {
                if self._value < newValue {
                    value = self.minValue
                } else {
                    value = self.maxValue
                }
            } else {
                value = newValue
            }
            
            if _value == minValue && newValue > minValue {
                self.delegate?.didStartChangeValue()
            }
            
            self._value = value
            self.sendActions(for: .valueChanged)
            var degree = Math.degreeFromValue(self.startAngle, value: self.value, maxValue: self.maxValue, minValue: self.minValue)
            
            // fix rendering issue near max value
            // substract 1/100 of one degree from the current degree to fix a very little overflow
            // which otherwise cause to display a layer as it is on a min value
            if self._value == self.maxValue {
                degree = degree - degree / (360 * 100)
                self.delegate?.didReachedMaxValue()
            }
            
            self.layout(degree)
        }
    }
    fileprivate var trackLayer: TrackLayer! {
        didSet {
            self.layer.addSublayer(self.trackLayer)
        }
    }
    fileprivate var thumbView: UIView! {
        didSet {
            if self.sliderEnabled {
                self.thumbView.backgroundColor = self.thumbColor
                self.thumbView.center = self.thumbCenter(self.startAngle)
                self.thumbView.layer.cornerRadius = self.thumbView!.bounds.size.width * 0.5
                self.addSubview(self.thumbView)
                if let thumbImage = self.thumbImage {
                    let thumbImageView = UIImageView(frame: self.thumbView.bounds)
                    thumbImageView.image = thumbImage
                    self.thumbView.addSubview(thumbImageView)
                    self.thumbView.backgroundColor = UIColor.clear
                }
            } else {
                self.thumbView.isHidden = true
            }
        }
    }
    // Options
    fileprivate var startAngle: Double = -90
    fileprivate var barColor = UIColor.lightGray
    fileprivate var trackingColor = UIColor.blue
    fileprivate var thumbColor = UIColor.black
    fileprivate var barWidth: CGFloat = 20
    fileprivate var maxValue: Float = 101
    fileprivate var minValue: Float = 0
    fileprivate var sliderEnabled = true
    fileprivate var viewInset: CGFloat = 20
    fileprivate var minMaxSwitchTreshold: Float = 0.0 // from 0.0 to 1.0
    fileprivate var thumbImage: UIImage?
    fileprivate var _thumbWidth: CGFloat?
    fileprivate var thumbWidth: CGFloat {
        get {
            if let retValue = self._thumbWidth {
                return retValue
            }
            return self.barWidth * 1.5
        }
        set {
            self._thumbWidth = newValue
        }
    }
    fileprivate var thumbPosition: Float = 0.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }
    
    init(frame: CGRect, options: [ArcSliderOption]?) {
        super.init(frame: frame)
        if let options = options {
            build(options)
        }
    }
    
    convenience init(frame: CGRect, options: [ArcSliderOption]?, delegate: ArcSliderDelegate?) {
        self.init(frame: frame, options: options)
        self.delegate = delegate
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of _: CALayer) {
        if trackLayer == nil {
            trackLayer = TrackLayer(bounds: bounds.insetBy(dx: viewInset, dy: viewInset), setting: createLayerSetting())
        }
        if thumbView == nil {
            thumbView = UIView(frame: CGRect(x: 0, y: 0, width: thumbWidth, height: thumbWidth))
        }
    }
    
    override func hitTest(_ point: CGPoint, with _: UIEvent?) -> UIView? {
        if !sliderEnabled {
            return nil
        }
        if trackLayer == nil {
          trackLayer = TrackLayer(bounds: bounds.insetBy(dx: viewInset, dy: viewInset), setting: createLayerSetting())
        }
      
        let rect = trackLayer.hollowRect
        let hollowPath = UIBezierPath(roundedRect: rect, cornerRadius: trackLayer.hollowRadius)
        if !(bounds.contains(point) || hollowPath.contains(point)) ||
            !(thumbView.frame.contains(point)) {
            return nil
        }
        return self
    }
    
    override func continueTracking(_ touch: UITouch, with _: UIEvent?) -> Bool {
        let degree = Math.pointPairToBearingDegrees(center, endPoint: touch.location(in: self))
        latestDegree = degree
        layout(degree)
        let value = Float(Math.adjustValue(startAngle, degree: degree, maxValue: self.maxValue, minValue: self.minValue))
        self.value = value
        return true
    }
    
    func changeOptions(_ options: [ArcSliderOption]) {
        build(options)
        redraw()
    }
    
    fileprivate func redraw() {
        
        if trackLayer != nil {
            trackLayer.removeFromSuperlayer()
        }
        trackLayer = TrackLayer(bounds: bounds.insetBy(dx: viewInset, dy: viewInset), setting: createLayerSetting())
        if thumbView != nil {
            thumbView.removeFromSuperview()
        }
        thumbView = UIView(frame: CGRect(x: 0, y: 0, width: thumbWidth, height: thumbWidth))
        layout(latestDegree)
    }
    
    fileprivate func build(_ options: [ArcSliderOption]) {
        for option in options {
            switch option {
            case let .startAngle(value):
                self.startAngle = value
                latestDegree = self.startAngle
            case let .barColor(value):
                self.barColor = value
            case let .trackingColor(value):
                self.trackingColor = value
            case let .thumbColor(value):
                self.thumbColor = value
            case let .barWidth(value):
                self.barWidth = value
            case let .thumbWidth(value):
                self.thumbWidth = value
            case let .maxValue(value):
                self.maxValue = value
                // Adjust because value not rise up to the maxValue
                self.maxValue += 1
            case let .minValue(value):
                self.minValue = value
                _value = self.minValue
            case let .sliderEnabled(value):
                self.sliderEnabled = value
            case let .viewInset(value):
                self.viewInset = value
            case let .minMaxSwitchTreshold(value):
                self.minMaxSwitchTreshold = value
            case let .thumbImage(value):
                self.thumbImage = value
            case let .thumbPosition(value):
                self.thumbPosition = value
            }
        }
    }
    
    fileprivate func layout(_ degree: Double) {
        if let trackLayer = self.trackLayer, let thumbView = self.thumbView {
            trackLayer.degree = degree
            thumbView.center = thumbCenter(degree)
            trackLayer.setNeedsDisplay()
        }
    }
    
    fileprivate func createLayerSetting() -> TrackLayer.Setting {
        var setting = TrackLayer.Setting()
        setting.startAngle = startAngle
        setting.barColor = barColor
        setting.trackingColor = trackingColor
        setting.barWidth = barWidth
        return setting
    }
    
    fileprivate func thumbCenter(_ degree: Double) -> CGPoint {
        let radius = (bounds.insetBy(dx: viewInset, dy: viewInset).width * 0.5) - (barWidth * CGFloat(thumbPosition))
        return Math.pointFromAngle(frame, angle: degree, radius: Double(radius))
    }
}

public protocol ArcSliderDelegate {
    func didStartChangeValue()
    func didReachedMaxValue()
}
