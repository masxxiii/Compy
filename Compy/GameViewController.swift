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


    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
