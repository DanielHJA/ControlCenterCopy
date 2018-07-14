//
//  ViewController.swift
//  ControlCenterCopy
//
//  Created by Daniel Hjärtström on 2018-07-14.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var screenEdgePanRecognizer: UIScreenEdgePanGestureRecognizer = {
        return UIScreenEdgePanGestureRecognizer(target: self, action: #selector(didPan(_ :)))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(screenEdgePanRecognizer)
    }
    
    @objc func didPan(_ sender: UIScreenEdgePanGestureRecognizer) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

