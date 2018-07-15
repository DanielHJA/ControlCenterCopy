//
//  Arrow.swift
//  AnimateBezier
//
//  Created by Daniel Hjärtström on 2018-07-15.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class Arrow: UIView {

    private var shapeLayer: CAShapeLayer!
    private var startPath: UIBezierPath!
    private var endPath: UIBezierPath!
    var isPresenting: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        startPath = UIBezierPath()
        startPath.move(to: CGPoint(x: 0, y: frame.maxY / 2))
        startPath.addLine(to: CGPoint(x: frame.maxX / 2, y: frame.maxY / 2))
        startPath.addLine(to: CGPoint(x: frame.maxX, y: frame.maxY / 2))
        
        endPath = UIBezierPath()
        endPath.move(to: CGPoint(x: 0, y: frame.maxY / 2))
        endPath.addLine(to: CGPoint(x: frame.maxX / 2, y: frame.maxY))
        endPath.addLine(to: CGPoint(x: frame.maxX, y: frame.maxY / 2))
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = startPath.cgPath
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.strokeEnd = 1.0
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineWidth = 6.0
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.frame = bounds
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(shapeLayer)
    }
    
    func animate(status: AnimationStatus) {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = status == .present ? startPath.cgPath : endPath.cgPath
        animation.toValue = status == .present ? endPath.cgPath : startPath.cgPath
        animation.duration = 0.2
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "AnimateArrow")
    }
    
}
