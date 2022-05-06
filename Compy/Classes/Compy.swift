//
//  Compy.swift
//  Compy
//
//  Created by Masood Zafar on 06.05.2022.
//

import SpriteKit

class Compy: SKSpriteNode, GameSprite {
    var textureAtlas: SKTextureAtlas = SKTextureAtlas(named: "Compy")
    
    var initialSize: CGSize = CGSize(width: 100, height: 100)
    
    var jumpAnimation = SKAction()
    
    var standAnimation = SKAction()
    
    var deadAnimation = SKAction()
    
    var moveAnimation = SKAction()
    
    // initialization instance.
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        addJumpAnimations()
        addStandAnimations()
        addDeadAnimations()
        addMoveAnimations()
        addPhysics()
        self.run(standAnimation, withKey: "standAnimation")
    }
    
    // function for adding jump animation.
    func addJumpAnimations()
    {
        let jumpFrames: [SKTexture] = [textureAtlas.textureNamed("jump")]
        let jumpAction = SKAction.animate(with: jumpFrames, timePerFrame: 0.03)
        jumpAnimation = SKAction.repeatForever(jumpAction)
    }
    
    // function for adding stand animation.
    func addStandAnimations() {
        let standFrames: [SKTexture] = [textureAtlas.textureNamed("stand")]
        let standAction = SKAction.animate(with: standFrames, timePerFrame: 0.03)
        standAnimation = SKAction.repeatForever(standAction)
    }
    
    // function for adding dead animation.
    func addDeadAnimations() {
        let deadFrames: [SKTexture] = [textureAtlas.textureNamed("dead")]
        let deadAction = SKAction.animate(with: deadFrames, timePerFrame: 0.03)
        deadAnimation = SKAction.repeatForever(deadAction)
    }
    
    // function for adding move animation.
    func addMoveAnimations() {
        let moveFrames: [SKTexture] = [
            textureAtlas.textureNamed("move1"),
            textureAtlas.textureNamed("move2"),
            textureAtlas.textureNamed("move3"),
            textureAtlas.textureNamed("move4"),
            textureAtlas.textureNamed("move5"),
            textureAtlas.textureNamed("move6")
        ]
        let moveAction = SKAction.animate(with: moveFrames, timePerFrame: 0.03)
        moveAnimation = SKAction.repeatForever(moveAction)
    }
    
    // function for adding physics to our sprite.
    func addPhysics() {
        let bodyTexture = textureAtlas.textureNamed("stand")
        self.physicsBody = SKPhysicsBody(texture: bodyTexture, size: self.size)
        self.physicsBody?.linearDamping = 0.9
        self.physicsBody?.mass = 3
        self.physicsBody?.allowsRotation = false
    }
    
    // function for updating our sprite.
    func update() {}
    
    
    // function for adding tap functionality.
    func onTap() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
