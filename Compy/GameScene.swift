//
//  GameScene.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import SpriteKit

class GameScene: SKScene {
    
    let cam = SKCameraNode()
    let ground = Ground()
    let compy = Compy()
    let alien1 = Alien(position: CGPoint(x: 200, y: 250))
    let alien2 = Alien(position: CGPoint(x: 50, y: 250))
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 1.00, green: 0.89, blue: 0.77, alpha: 1.00)
        self.anchorPoint = .zero
        self.camera = cam
    
        compy.position = CGPoint(x: 150, y: 250)
        
                
        //positioning ground
        ground.position = CGPoint(x: -self.size.width*2, y: 100)
        ground.size = CGSize(width: self.size.width*6, height: 0)
        ground.tileGround()
        self.addChild(ground)
        self.addChild(compy)
        self.addChild(alien1)
        self.addChild(alien2)
    }
    
    override func didSimulatePhysics() {
        self.camera!.position = compy.position
    }
}
