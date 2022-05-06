//
//  GameScene.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import SpriteKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let cam = SKCameraNode()
    let ground = Ground()
    let player = Compy()
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 1.00, green: 0.89, blue: 0.77, alpha: 1.00)
        self.anchorPoint = .zero
    
        player.position = CGPoint(x: 150, y: 250)
        
                
        //positioning ground
        ground.position = CGPoint(x: -self.size.width*2, y: 100)
        ground.size = CGSize(width: self.size.width*6, height: 0)
        ground.tileGround()
        self.addChild(ground)
        self.addChild(player)
    }
}
