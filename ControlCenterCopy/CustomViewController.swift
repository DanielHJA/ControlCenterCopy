//
//  CustomViewController.swift
//  ControlCenterCopy
//
//  Created by Daniel Hjärtström on 2018-07-14.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController, RemovalProtocol {
    
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(didPan(_ :)))
    }()
    
    private var controlView: ControlCenterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(panRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func didPan(_ sender: UIPanGestureRecognizer) {
        if controlView == nil {
            controlView = ControlCenterView(frame: view.frame)
            controlView!.delegate = self
    //        view.insertSubview(controlView!, at: 0)
            view.insertSubview(controlView!, at: self.view.subviews.count + 1)

            controlView!.didPan(sender: sender)
        } else {
            controlView!.didPan(sender: sender)
        }
    }
    
    func shouldRemoveControlView() {
        controlView?.removeFromSuperview()
        controlView = nil
    }
    
}
