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
        let temp = Arrow(frame: CGRect(x: 0, y: 0, width: frame.width * 0.1, height: frame.height * 0.05))
        temp.alpha = 0
        controlsView.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: controlsView.centerXAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: controlsView.topAnchor, constant: 20.0).isActive = true
        temp.heightAnchor.constraint(equalTo: controlsView.heightAnchor, multiplier: 0.05).isActive = true
        temp.widthAnchor.constraint(equalTo: controlsView.widthAnchor, multiplier: 0.1).isActive = true
        return temp
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .regular)
        let temp = UIVisualEffectView(frame: frame)
        temp.backgroundColor = UIColor.blue
        temp.alpha = 0
        return temp
    }()
    
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
        animateArrow()
    }
    
    private func animateArrow() {
        if controlsView.frame.origin.y < frame.height * 0.1 {
            if !arrowView.isPresenting {
                arrowView.animate(status: .present)
                arrowView.isPresenting = true
            }
            
        } else if controlsView.frame.origin.y > frame.height * 0.2 {
            if arrowView.isPresenting {
                arrowView.animate(status: .dismiss)
                arrowView.isPresenting = false
            }
        }
    }
    
    private func setTranslation(_ translation: CGPoint) {
        if controlsView.frame.origin.y >= 0 {
            controlsView.frame.origin.y += translation.y
        }
    }
    
    private func setAlpha() {
        let percentage = 1 - controlsView.frame.origin.y / frame.height
        blurView.alpha = percentage
        
        let arrowPercentage = 1 - controlsView.frame.origin.y / (frame.height / 1.5)
        arrowView.alpha = arrowPercentage

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
    }
}
