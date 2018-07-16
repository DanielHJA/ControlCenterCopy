//
//  ControlView.swift
//  ControlCenterCopy
//
//  Created by Daniel Hjärtström on 2018-07-16.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
enum ControlViewType {
    case icon, interactive
}

class ControlView: UIView {
    
    private lazy var longPressRecogniser: UILongPressGestureRecognizer = {
        let temp = UILongPressGestureRecognizer()
        temp.minimumPressDuration = 0.5
        temp.addTarget(self, action: #selector(didLongPressControl(_:)))
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
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        layer.cornerRadius = 14.0
        clipsToBounds = true
        addGestureRecognizer(longPressRecogniser)
    }

    @objc private func didLongPressControl(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            UIView.animate(withDuration: 1.0, animations: { [unowned self] in
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }) { (completion) in }
        case .ended:
            transform = CGAffineTransform.identity
        default:
            break
        }
    }
}
