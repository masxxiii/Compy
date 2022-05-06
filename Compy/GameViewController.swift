//
//  GameViewController.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        // creates our scene
        let scene = GameScene()
        
        // configuring
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        // setting the scale mode:
        scene.scaleMode = .aspectFill
        // size our scene to fit the view exactly:
        scene.size = view.bounds.size
        // show the new scene:
        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
