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
    
    override func viewDidLoad() {
         super.viewDidLoad()

         view = SKView(frame: view.bounds)

         if let view = self.view as! SKView? {
             // Initialise the scene
             let scene = GameScene(size: view.bounds.size)

             // Set the scale mode to scale to fit the window
             scene.scaleMode = .aspectFill

             // Present the scene
             view.presentScene(scene)

             // Scene properties
             view.showsPhysics = false
             view.ignoresSiblingOrder = true
             view.showsFPS = true
             view.showsNodeCount = true
         }
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
