//
//  ControlsView.swift
//  ControlCenterCopy
//
//  Created by Daniel Hjärtström on 2018-07-14.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ControlsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
    }

}
