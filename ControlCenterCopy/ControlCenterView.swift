//
//  ControlCenterView.swift
//  ControlCenterCopy
//
//  Created by Daniel Hjärtström on 2018-07-14.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

enum AnimationStatus {
    case present, dismiss
}

protocol RemovalProtocol: class {
    func shouldRemoveControlView()
}

class ControlCenterView: UIView {
    
    weak var delegate: RemovalProtocol?
    
    private lazy var controlsView: ControlsView = {
        let temp = ControlsView(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: frame.height))
        return temp
    }()
    
    private lazy var arrowView: Arrow = {
        let temp = Arrow(frame: CGRect(x: 0, y: 0, width: frame.width * 0.1, height: frame.height * 0.03))
        temp.alpha = 0
        controlsView.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: controlsView.centerXAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: controlsView.topAnchor, constant: 20.0).isActive = true
        temp.heightAnchor.constraint(equalTo: controlsView.heightAnchor, multiplier: 0.03).isActive = true
        temp.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.1).isActive = true
        return temp
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .regular)
        let temp = UIVisualEffectView(effect: effect)
        temp.frame = bounds
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(blurView)
        insertSubview(controlsView, aboveSubview: blurView)
        arrowView.isHidden = false
        addControls()
    }
    
    private func addControls() {
        let heightPadding = controlsView.frame.width * 0.2 / 7
        let widthPadding = controlsView.frame.width * 0.2 / 5
        
        let smallControl = CGRect(x: 0, y: 0, width: controlsView.frame.width * 0.2, height: controlsView.frame.width * 0.2)
        let mediumControl = CGRect(x: 0, y: 0, width: controlsView.frame.width * 0.4 + widthPadding, height: controlsView.frame.width * 0.2)
        let tallcontrol = CGRect(x: 0, y: 0, width: controlsView.frame.width * 0.2, height: controlsView.frame.width * 0.4 + heightPadding)
        let largeControl = CGRect(x: 0, y: 0, width: controlsView.frame.width * 0.2 + widthPadding, height: controlsView.frame.width * 0.4 + heightPadding)
        
        // First row
        
        let recordControl = ControlView(frame: smallControl)
        controlsView.addSubview(recordControl)
        recordControl.translatesAutoresizingMaskIntoConstraints = false
        recordControl.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: widthPadding).isActive = true
        recordControl.bottomAnchor.constraint(equalTo: controlsView.bottomAnchor, constant: -heightPadding).isActive = true
        recordControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
        recordControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
    
        // Second row
        
        let flashLightControl = ControlView(frame: smallControl)
        controlsView.addSubview(flashLightControl)
        flashLightControl.translatesAutoresizingMaskIntoConstraints = false
        flashLightControl.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: widthPadding).isActive = true
        flashLightControl.bottomAnchor.constraint(equalTo: recordControl.topAnchor, constant: -heightPadding).isActive = true
        flashLightControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
        flashLightControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true

        let timerControl = ControlView(frame: smallControl)
        controlsView.addSubview(timerControl)
        timerControl.translatesAutoresizingMaskIntoConstraints = false
        timerControl.leadingAnchor.constraint(equalTo: flashLightControl.trailingAnchor, constant: widthPadding).isActive = true
        timerControl.bottomAnchor.constraint(equalTo: recordControl.topAnchor, constant: -heightPadding).isActive = true
        timerControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
        timerControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true

        let calculatorControl = ControlView(frame: smallControl)
        controlsView.addSubview(calculatorControl)
        calculatorControl.translatesAutoresizingMaskIntoConstraints = false
        calculatorControl.leadingAnchor.constraint(equalTo: timerControl.trailingAnchor, constant: widthPadding).isActive = true
        calculatorControl.bottomAnchor.constraint(equalTo: recordControl.topAnchor, constant: -heightPadding).isActive = true
        calculatorControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
        calculatorControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true

        let cameraControl = ControlView(frame: smallControl)
        controlsView.addSubview(cameraControl)
        cameraControl.translatesAutoresizingMaskIntoConstraints = false
        cameraControl.leadingAnchor.constraint(equalTo: calculatorControl.trailingAnchor, constant: widthPadding).isActive = true
        cameraControl.bottomAnchor.constraint(equalTo: recordControl.topAnchor, constant: -heightPadding).isActive = true
        cameraControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
        cameraControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true

        // Screen Doubling

        let screenControl = ControlView(frame: mediumControl)
        controlsView.addSubview(screenControl)
        screenControl.translatesAutoresizingMaskIntoConstraints = false
        screenControl.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: widthPadding).isActive = true
        screenControl.bottomAnchor.constraint(equalTo: cameraControl.topAnchor, constant: -heightPadding).isActive = true
        screenControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
        screenControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.4 + widthPadding / controlsView.frame.width).isActive = true

        // Rotation and nightshift
        
        let rotationControl = ControlView(frame: smallControl)
        controlsView.addSubview(rotationControl)
        rotationControl.translatesAutoresizingMaskIntoConstraints = false
        rotationControl.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: widthPadding).isActive = true
        rotationControl.bottomAnchor.constraint(equalTo: screenControl.topAnchor, constant: -heightPadding).isActive = true
        rotationControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
        rotationControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true

        let nightShiftControl = ControlView(frame: smallControl)
        controlsView.addSubview(nightShiftControl)
        nightShiftControl.translatesAutoresizingMaskIntoConstraints = false
        nightShiftControl.leadingAnchor.constraint(equalTo: rotationControl.trailingAnchor, constant: widthPadding).isActive = true
        nightShiftControl.bottomAnchor.constraint(equalTo: screenControl.topAnchor, constant: -heightPadding).isActive = true
        nightShiftControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
        nightShiftControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
    
        // Interactive controls (light / sound)
        
        let lightControl = ControlView(frame: tallcontrol)
        controlsView.addSubview(lightControl)
        lightControl.translatesAutoresizingMaskIntoConstraints = false
        lightControl.leadingAnchor.constraint(equalTo: screenControl.trailingAnchor, constant: widthPadding).isActive = true
        lightControl.bottomAnchor.constraint(equalTo: cameraControl.topAnchor, constant: -heightPadding).isActive = true
        lightControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.4 + heightPadding / controlsView.frame.width).isActive = true
        lightControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true

        let soundControl = ControlView(frame: tallcontrol)
        controlsView.addSubview(soundControl)
        soundControl.translatesAutoresizingMaskIntoConstraints = false
        soundControl.leadingAnchor.constraint(equalTo: lightControl.trailingAnchor, constant: widthPadding).isActive = true
        soundControl.bottomAnchor.constraint(equalTo: cameraControl.topAnchor, constant: -heightPadding).isActive = true
        soundControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.4 + heightPadding / controlsView.frame.width).isActive = true
        soundControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.2).isActive = true
    
        // TopControls
        
        let connectivityControl = ControlView(frame: largeControl)
        controlsView.addSubview(connectivityControl)
        connectivityControl.translatesAutoresizingMaskIntoConstraints = false
        connectivityControl.leadingAnchor.constraint(equalTo: controlsView.leadingAnchor, constant: widthPadding).isActive = true
        connectivityControl.bottomAnchor.constraint(equalTo: rotationControl.topAnchor, constant: -heightPadding).isActive = true
        connectivityControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.4 + heightPadding / controlsView.frame.width).isActive = true
        connectivityControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.4 + widthPadding / controlsView.frame.width).isActive = true
        
        let musicControl = ControlView(frame: largeControl)
        controlsView.addSubview(musicControl)
        musicControl.translatesAutoresizingMaskIntoConstraints = false
        musicControl.leadingAnchor.constraint(equalTo: connectivityControl.trailingAnchor, constant: widthPadding).isActive = true
        musicControl.bottomAnchor.constraint(equalTo: lightControl.topAnchor, constant: -heightPadding).isActive = true
        musicControl.heightAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.4 + heightPadding / controlsView.frame.width).isActive = true
        musicControl.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.4 + widthPadding / controlsView.frame.width).isActive = true

    }
    
    @objc private func didLongPressControl(_ sender: UILongPressGestureRecognizer) {
        
    }
    
    func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        
        switch sender.state {
        case .began, .changed:
            setAlpha()
            animateArrow()
            setTranslation(translation)
            sender.setTranslation(CGPoint.zero, in: self)
        case .ended:
            endAnimation()
            animateArrow()
        default:
            break
        }
    }
    
    private func endAnimation() {
        if controlsView.frame.origin.y < frame.height / 2 {
            animatePannedView(.present)
        } else {
            animatePannedView(.dismiss)
        }
    }
    
    private func animateArrow() {
        let origin = controlsView.frame.origin.y
        
        if origin < 40.0 {
            if !arrowView.isPresenting {
                arrowView.animate(status: .present)
                arrowView.isPresenting = true
            }
        }
        
        if origin > 60.0 {
            if arrowView.isPresenting {
                arrowView.animate(status: .dismiss)
                arrowView.isPresenting = false
            }
        }
        arrowView.isHidden = origin > 80.0 ? true : false
    }
    
    private func setTranslation(_ translation: CGPoint) {
        if controlsView.frame.origin.y >= 0 {
            controlsView.frame.origin.y += translation.y
        }
    }
    
    private func setAlpha() {
        let percentage = 1 - controlsView.frame.origin.y / frame.height
        blurView.alpha = percentage
        arrowView.alpha = percentage
    }
    
    private func animatePannedView(_ status: AnimationStatus) {
        UIView.animate(withDuration: 1.0, animations: { [unowned self] in
            if status == .present {
                self.controlsView.frame.origin = CGPoint(x: 0, y: 0)
            } else {
                self.controlsView.frame.origin = CGPoint(x: 0, y: self.frame.height)
            }
            self.setAlpha()
        }) { (competion) in
            if status == .dismiss {
                self.delegate?.shouldRemoveControlView()
            }
        }
    }
    
    deinit {
        print("Control center has been de-initialized")
    }
}
