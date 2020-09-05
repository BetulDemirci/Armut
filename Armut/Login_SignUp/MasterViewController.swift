//
//  MasterViewController.swift
//  Armut
//
//  Created by Semafor Teknolojı on 3.09.2020.
//  Copyright © 2020 Semafor Teknolojı. All rights reserved.
//

import UIKit

class MasterViewController: VideoSplashViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         setupVideoBackground()
    }
    
    func setupVideoBackground() {
      let url = URL(fileURLWithPath: Bundle.main.path(forResource: "video-team", ofType: "mp4")!)
      // setup layout
      videoFrame = view.frame
      fillMode = .resizeAspectFill
      alwaysRepeat = true
      sound = true
      startTime = 0.1
      alpha = 0.8
      
      contentURL = url
      view.isUserInteractionEnabled = false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
      return .lightContent
    }
      

}

